//
//  NmffDetailViewController.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffDetailViewController.h"
#import "NmffSharedImageProcessor.h"

@interface NmffDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *NmffDetailView;

@end


@implementation NmffDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = _individualName;
    
}

- (IBAction)AddPhotoButtonTapped:(id)sender {


    UIActionSheet *photoSourceActionSheet = [[UIActionSheet alloc] initWithTitle: @"Pick Photo"
                                                                        delegate: self
                                                               cancelButtonTitle:@"cancel"
                                                          destructiveButtonTitle:nil
                                                               otherButtonTitles:@"Camera", @"Photo Library", nil];



    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [photoSourceActionSheet showInView: _NmffDetailView];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self getImage:PhotoGallery];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTapped = [actionSheet buttonTitleAtIndex:buttonIndex];

    if([buttonTapped isEqualToString:@"Camera"]) {
        [self getImage:Camera];
    } else if ([buttonTapped isEqualToString:@"Photo Library"]) {
        [self getImage:PhotoGallery];
    } else {
        return;
    }
}

typedef enum imageSource {
    Camera = 0,
    PhotoGallery = 1
} imageSource;

- (void) getImage:(imageSource) sourcetype {
    UIImagePickerController *imagePicker = [UIImagePickerController new];

    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;

    switch (sourcetype){
        case Camera:
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case PhotoGallery:
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
    }

    [self presentViewController:imagePicker animated:TRUE completion:nil];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *jpgData = UIImageJPEGRepresentation(editedImage, .55);

        NSString *indvidualImageFileName = [[NmffSharedImageProcessor sharedProcessor] getIndvidualImageFileNameWithName:self.title];

        [jpgData writeToFile:indvidualImageFileName atomically:TRUE];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
