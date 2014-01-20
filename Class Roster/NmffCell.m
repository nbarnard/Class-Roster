//
//  NmffCell.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/16/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffCell.h"

@implementation NmffCell

#pragma mark - Update Cell

- (void)updateWithIndividual: (NmffIndividual *)individual {
    _individual = individual;

    self.textLabel.text = individual.name;
    self.detailTextLabel.text = [self stringWithRole:individual.role];
    self.imageView.image = individual.img;

    CALayer *cellImageLayer = self.imageView.layer;
    [cellImageLayer setCornerRadius:33];
    [cellImageLayer setMasksToBounds:TRUE];

    return;
}

- (NSString *)stringWithRole: (roleType)individual {

    NSString *roleText = [[NSString alloc] init];
    switch (individual) {
        case Student:
            roleText = @"Student";
            break;
        case Instructor:
            roleText = @"Instructor";
            break;
        case Adminstrator:
            roleText = @"Adminstrator";
            break;
        default: //Also catches Unknown enum Type
            roleText = @"Unknown";
            break;
    }
    return roleText;
}


#pragma mark - boilerplate

- (id)initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected: (BOOL)selected animated: (BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
