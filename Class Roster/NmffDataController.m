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
#import "NmffCell.h"

@interface NmffDataController()

@property (strong, nonatomic) NSArray *individualsArray;

@end

@implementation NmffDataController

#pragma mark - Singleton Initializer

+ (NmffDataController *)sharedController {

    static dispatch_once_t pred;
    static NmffDataController *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[NmffDataController alloc] init];
    });

    return shared;
}

#pragma mark - Data Handling

- (NmffDataController *)loadInitialData {
        NSString *individualDataFileString = [self individualDataFileString];
        if([[NSFileManager defaultManager] fileExistsAtPath: individualDataFileString])
        {
            _individualsArray = [self loadIndividualsFromFile:individualDataFileString];
        } else {
            _individualsArray = [self loadIndividualsFromBundlePList];
        }

    return self;
}

- (NSArray *)loadIndividualsFromFile: (NSString *)individualDataFileString {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:individualDataFileString];
}

- (void)saveIndividualsToFile {
    [NSKeyedArchiver archiveRootObject:_individualsArray toFile:[self individualDataFileString]];

    return;
}

- (NSArray *)loadIndividualsFromBundlePList {
    NSString *fileName = [[NSBundle mainBundle] pathForResource: @"Bootcamp" ofType:@"plist"];
    NSArray *individualDict = [[NSArray alloc] initWithContentsOfFile:fileName];

    NSMutableArray *individuals = [NSMutableArray new];

    for (NSDictionary *individual in individualDict) {
        NSString *name = [individual objectForKey:@"name"];
        roleType individualRole = [self roleTypeFromNSString:[individual objectForKey:@"role"]];
        [individuals addObject: [[NmffIndividual alloc] initWithName:name andRole:individualRole]];
    }

    return [[NSArray alloc] initWithArray:individuals];
}

- (roleType)roleTypeFromNSString: (NSString *)role {

    roleType individualRole;

    if ([role isEqualToString:@"student"]) {
        individualRole = Student;
    } else if ([role isEqualToString:@"instructor"]){
        individualRole = Instructor;
    } else {
        individualRole = Unknown;
    }

    return individualRole;
}

#pragma mark - Sorting

- (void)sortListDirection: (BOOL)direction {

    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:direction];

    NSArray *sortDescriptors = @[nameDescriptor];

    _individualsArray = [_individualsArray sortedArrayUsingDescriptors:sortDescriptors];

}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _individualsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NmffCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];

    NmffIndividual *cellIndividual = [_individualsArray objectAtIndex:indexPath.row];

    [cell updateWithIndividual:cellIndividual];

    return cell;
}

#pragma mark - File Handling

- (NSString *)individualDataFileString {
    NSURL *individualDataFile = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"individualDataFile"];
    return [individualDataFile path];
}

// returns the URL to the application's Documents directory
- (NSURL *)applicationDocumentsDirectory {
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
