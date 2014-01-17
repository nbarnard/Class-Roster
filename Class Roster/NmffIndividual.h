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


@interface NmffIndividual : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) enum roleType individualRole;
@property (nonatomic) UIImage *individualImage;

- (instancetype)initWithName: (NSString *)name andRole:(enum roleType)individualRole;

@end
