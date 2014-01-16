//
//  NmffImageShared.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/15/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffSharedImageProcessor.h"

@implementation NmffSharedImageProcessor

+ (NmffSharedImageProcessor *)sharedProcessor{

    static dispatch_once_t pred;
    static NmffSharedImageProcessor *shared = nil;

    dispatch_once(&pred, ^{
        shared = [[NmffSharedImageProcessor alloc] init];
    });
        
    return shared;
}

- (NSString *)getIndvidualImageFileNameWithName: (NSString *)individualName {

    NSString *individualConcatenatedName = [individualName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *documentsPath = [documentsURL path];

    NSString *fileName = [[NSString alloc] initWithFormat:@"%@/%@.png", documentsPath, individualConcatenatedName, nil];
    return fileName;
}

@end
