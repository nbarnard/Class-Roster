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

#pragma mark - initializers

// Transitional method as class is extended
- (NmffIndividual *) initWithName: (NSString *)name andRole: (roleType) role {
    return [self initWithName:name andRole:role andTwitter:nil andGithub:nil];
}


- (NmffIndividual *) initWithName: (NSString *)name andRole: (roleType)role andTwitter: (NSString *)twitter andGithub: (NSString *)github {
    self = [super init];
    if (self != nil) {
        _name = name;
        _role = role;
        _twitter = twitter;
        _github = github;

        NSString *individualImageFileName = [[NmffDataController sharedController] getIndvidualImageFileNameWithName:_name];

        _img = [UIImage imageWithContentsOfFile:individualImageFileName];

    }
    return self;
}

#pragma mark - Update Object

- (void) updateWithName: (NSString *)name andRole: (roleType)role andTwitter: (NSString *)twitter andGithub: (NSString *)github {
    _name = name;
    _role = role;
    _twitter = twitter;
    _github = github;

    [[NmffDataController sharedController] saveIndividualsToFile];

}

#pragma mark - NSCoding

- (NmffIndividual *)initWithCoder: (NSCoder *)decoder {
    return [self initWithName:[decoder decodeObjectForKey:@"name"]
                      andRole:(roleType)[decoder decodeIntForKey:@"role"]
                   andTwitter:[decoder decodeObjectForKey:@"twitter"]
                    andGithub:[decoder decodeObjectForKey:@"github"]];
}

- (void) encodeWithCoder: (NSCoder *)encoder {
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeInt:_role forKey:@"role"];
    [encoder encodeObject:_twitter forKey:@"twitter"];
    [encoder encodeObject:_github forKey:@"github"];
}

@end
