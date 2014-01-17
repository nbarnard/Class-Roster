//
//  NmffIndividual.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffIndividual.h"
#import "NmffSharedImageProcessor.h"

@implementation NmffIndividual

- (instancetype) initWithName: (NSString *)name andRole:(enum roleType) individualRole {
    if (self = [super init]) {
        _name = name;
        _individualRole = individualRole;

        NSString *individualImageFileName = [[NmffSharedImageProcessor sharedProcessor] getIndvidualImageFileNameWithName:_name];

        _individualImage = [UIImage imageWithContentsOfFile:individualImageFileName];

    }
    return self;
}

@end
