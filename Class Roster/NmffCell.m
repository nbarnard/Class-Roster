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

    _cellIndividual = individual;

    self.textLabel.text = individual.name;

    NSString *roleText = [NSString new];

    switch (individual.role) {
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

    self.detailTextLabel.text = roleText;

    UIImage *individualImage = individual.img;

    self.imageView.image = individualImage;

    CALayer *cellImageLayer = self.imageView.layer;

    [cellImageLayer setCornerRadius:33];
    [cellImageLayer setMasksToBounds:TRUE];

    return;
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
