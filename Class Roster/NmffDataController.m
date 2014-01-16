//
//  NmffDataController.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffDataController.h"
#import "NmffIndividual.h"
#import "NmffViewController.h"
#import "NmffSharedImageProcessor.h"
#import <QuartzCore/CALayer.h>

@interface NmffDataController()

@property (strong, nonatomic) NSArray *myIndividualsArray;

@end

@implementation NmffDataController


- (id)init
{

    if ( self = [super init]) {
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource: @"Bootcamp" ofType:@"plist"];

    NSMutableArray *individuals = [NSMutableArray new];

    NSArray *individualDict = [[NSArray alloc] initWithContentsOfFile:fileName];

    for (NSDictionary *individual in individualDict) {
        NSString *name = [individual objectForKey:@"name"];
        UIImage *image = [UIImage new];
        NSString *role = [individual objectForKey:@"role"];

        enum roleType individualRole = Unknown;

        if ([role isEqualToString:@"student"]) {
            individualRole = Student;
        } else if ([role isEqualToString:@"instructor"]){
            individualRole = Instructor;
        }

        [individuals addObject: [[NmffIndividual alloc] initWithName:name andRole:individualRole andImage:image]];
    }

        _myIndividualsArray = [[NSArray alloc] initWithArray:individuals];
    }

    return self;
}

- (void)sortListDirection: (BOOL) direction {

    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:direction];

    NSArray *sortDescriptors = @[nameDescriptor];

    _myIndividualsArray = [_myIndividualsArray sortedArrayUsingDescriptors:sortDescriptors];

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _myIndividualsArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];

    NmffIndividual *currentIndividual = [_myIndividualsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = currentIndividual.name;

    NSString *roleText = [NSString new];

    switch (currentIndividual.individualRole) {
        case Student:
            roleText = @"Student";
            break;
        case Instructor:
            roleText = @"Instructor";
            break;
        case Adminstrator:
            roleText = @"Adminstrator";
            break;
        default: //Also catches Unknown enum Type
            roleText = @"Unknown";
            break;
    }

    cell.detailTextLabel.text = roleText;

    NSString *indvidualImageFileName = [[NmffSharedImageProcessor sharedProcessor] getIndvidualImageFileNameWithName:currentIndividual.name];

    UIImage *individualImage = [UIImage imageWithContentsOfFile:indvidualImageFileName];

    cell.imageView.image = individualImage;

    CALayer *cellImageLayer = cell.imageView.layer;

    [cellImageLayer setCornerRadius:33];
    [cellImageLayer setMasksToBounds:TRUE];

    return cell;
    
}

@end
