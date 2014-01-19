//
//  NmffIndividual.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffIndividual.h"
#import "NmffDataController.h"

@implementation NmffIndividual

- (instancetype) initWithName: (NSString *)name andRole:(enum roleType) role {
    if (self = [super init]) {
        _name = name;
        _role = role;

        NSString *individualImageFileName = [[NmffDataController sharedController] getIndvidualImageFileNameWithName:_name];

        _img = [UIImage imageWithContentsOfFile:individualImageFileName];

    }
    return self;
}



@end
