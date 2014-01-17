//
//  NmffDetailViewController.h
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NmffIndividual.h"

@interface NmffDetailViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NmffIndividual *individual;
@property (strong, nonatomic) NSString *sectionName;

@end
