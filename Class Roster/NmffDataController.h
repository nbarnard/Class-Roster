//
//  NmffDataController.h
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - sortDirection typedef

// Make this crystal clear as to what NO and YES are
typedef enum sortDirection {
    descending = NO,
    ascending = YES
} sortDirection;

@interface NmffDataController : NSObject <UITableViewDataSource>

+ (NmffDataController *)sharedController;

- (void)sortListDirection: (BOOL) direction;
- (NSString *)getIndvidualImageFileNameWithName: (NSString *)individualName;
- (NmffDataController *)loadInitialData;
- (void)saveIndividualsToFile;

@end
