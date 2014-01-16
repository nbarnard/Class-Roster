//
//  NmffDataController.h
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NmffDataController : NSObject <UITableViewDataSource>

- (void)sortListDirection: (BOOL) direction;

@end
