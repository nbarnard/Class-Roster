//
//  NmffIndividual.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffIndividual.h"


@implementation NmffIndividual

- (instancetype) initWithName: (NSString *)name andRole:(enum roleType) individualRole andImage:(UIImage *) individualImage {
    if (self = [super init]) {
        _name = name;
        _individualRole = individualRole;
        _individualImage = individualImage;
    }
    return self;
}

@end
