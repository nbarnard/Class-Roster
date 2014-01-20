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
#import <QuartzCore/CALayer.h>
#import "NmffCell.h"

@interface NmffDataController()

@property (strong, nonatomic) NSArray *myIndividualsArray;

@end

@implementation NmffDataController

+ (NmffDataController *)sharedController{

    static dispatch_once_t pred;
    static NmffDataController *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[NmffDataController alloc] init];
    });

    return shared;
}

- (NSString *) individualDataFileString {
    NSURL *individualDataFile = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"individualDataFile"];
    return [individualDataFile path];
}

- (NmffDataController *) loadInitialData
{
        NSString *individualDataFileString = [self individualDataFileString];
        if([[NSFileManager defaultManager] fileExistsAtPath: individualDataFileString])
        {
            _myIndividualsArray = [self loadIndividualsFromFile:individualDataFileString];
        } else {
            _myIndividualsArray = [self loadIndividualsFromBundlePList];
        }

    return self;
}

- (NSArray *) loadIndividualsFromFile:(NSString *) individualDataFileString {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:individualDataFileString];
}

- (void)saveIndividualsToFile {
    [NSKeyedArchiver archiveRootObject:_myIndividualsArray toFile:[self individualDataFileString]];

    return;
}

- (NSArray *) loadIndividualsFromBundlePList {
    NSString *fileName = [[NSBundle mainBundle] pathForResource: @"Bootcamp" ofType:@"plist"];

    NSMutableArray *individuals = [NSMutableArray new];

    NSArray *individualDict = [[NSArray alloc] initWithContentsOfFile:fileName];

    for (NSDictionary *individual in individualDict) {
        NSString *name = [individual objectForKey:@"name"];
        NSString *role = [individual objectForKey:@"role"];

        enum roleType individualRole = Unknown;

        if ([role isEqualToString:@"student"]) {
            individualRole = Student;
        } else if ([role isEqualToString:@"instructor"]){
            individualRole = Instructor;
        }

        [individuals addObject: [[NmffIndividual alloc] initWithName:name andRole:individualRole]];
    }

    return [[NSArray alloc] initWithArray:individuals];
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

    NmffCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];

    NmffIndividual *cellIndividual = [_myIndividualsArray objectAtIndex:indexPath.row];

    [cell updateWithIndividual:cellIndividual];

    return cell;
}

// returns the URL to the application's Documents directory
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)getIndvidualImageFileNameWithName: (NSString *)individualName {

    NSString *individualConcatenatedName = [individualName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *documentsPath = [documentsURL path];

    NSString *fileName = [[NSString alloc] initWithFormat:@"%@/%@.png", documentsPath, individualConcatenatedName, nil];
    return fileName;
}

@end
