//
//  NmffImageShared.h
//  Class Roster
//
//  Created by Nicholas Barnard on 1/15/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NmffSharedImageProcessor : NSObject

+ (NmffSharedImageProcessor *)sharedProcessor;

- (NSString *)getIndvidualImageFileNameWithName: (NSString *)individualName;

@end
