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

        [individuals addObject: [[NmffIndividual alloc] initWithName:name andRole:Student andImage:image]];
    }

        _myIndividualsArray = [[NSArray alloc] initWithArray:individuals];
    }

    return self;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {



    return _myIndividualsArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];

    NmffIndividual *currentIndividual = [_myIndividualsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = currentIndividual.name;
    
    return cell;
    
}

@end
