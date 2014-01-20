//
//  NmffIndividual.h
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum roleType {
    Student = 0,
    Instructor = 1,
    Adminstrator = 2,
    Unknown = 3
} roleType;

@interface NmffIndividual : NSObject <NSCoding>

@property (nonatomic) NSString *name;
@property (nonatomic) roleType role;
@property (nonatomic) UIImage *img;
@property (nonatomic) NSString *github;
@property (nonatomic) NSString *twitter;

- (NmffIndividual *)initWithName: (NSString *)name andRole:(roleType)role;

- (NmffIndividual *)initWithName: (NSString *)name andRole:(roleType)role andTwitter: (NSString *)twitter andGithub: (NSString *)github;

- (void)updateWithName: (NSString *)name andRole:(roleType)role andTwitter: (NSString *)twitter andGithub: (NSString *)github;

@end
