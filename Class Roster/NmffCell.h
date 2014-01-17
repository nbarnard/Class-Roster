//
//  NmffCell.h
//  Class Roster
//
//  Created by Nicholas Barnard on 1/16/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NmffIndividual.h"

@interface NmffCell : UITableViewCell

@property (nonatomic) NmffIndividual *cellIndividual;

- (void)updateWithIndividual:(NmffIndividual *)individual;

@end
