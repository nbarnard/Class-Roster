//
//  NmffDetailViewController.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffDetailViewController.h"
#import "NmffSharedImageProcessor.h"
#import "NmffIndividual.h"
#import <UIKit/UIKit.h>

@interface NmffDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *NmffDetailView;
@property (strong, nonatomic) UIScrollView *NmffScrollDetailView;
@property (strong, nonatomic) UIView *imageFrame;

@end


@implementation NmffDetailViewController

typedef enum imageSource {
    Camera = 0,
    PhotoGallery = 1
} imageSource;


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
    self.title = self.individual.name;

//    NSLog(@"%f",_NmffDetailView.frame.size.width);
//    NSLog(@"%f",_NmffDetailView.frame.size.height);
    _NmffScrollDetailView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];

    _NmffScrollDetailView.contentSize = CGSizeMake(320, 1000);

    _imageFrame = [[UIView alloc] initWithFrame:CGRectMake(60, 110, 200, 200)];

    // set the image frame up with an image if we have one, or a button to add an image if we don't have one.
    if(_individual.individualImage == NULL) {
        _imageFrame.backgroundColor = [UIColor lightGrayColor];
        UIButton *takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 75, 200, 50)];

        [takePhotoButton setAttributedTitle:[[NSAttributedString alloc] initWithString: @"Add Photo"] forState:UIControlStateNormal];

        [takePhotoButton addTarget:self action:@selector(addPhotoButtonTapped:) forControlEvents:UIControlEventTouchUpInside];

        [_imageFrame addSubview:takePhotoButton];
    } else {

        UIImageView *imageInFrame = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];

        imageInFrame.image = _individual.individualImage;

        [_imageFrame addSubview:imageInFrame];
    }

    [_NmffScrollDetailView addSubview:_imageFrame];

    UITextField *individualTwitter = [[UITextField alloc] initWithFrame:CGRectMake(60, 350, 200, 30)];
    individualTwitter.text = @"Twitter Account"; 
    individualTwitter.clearsOnBeginEditing = TRUE;

    [_NmffScrollDetailView addSubview:individualTwitter];

    [_NmffDetailView addSubview:_NmffScrollDetailView];
}

- (IBAction)addPhotoButtonTapped:(id)sender {
    // Show an action sheet if both camera and photo library are available, if not go direclty to photogallery.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *photoSourceActionSheet = [[UIActionSheet alloc] initWithTitle: @"Pick Photo"
                                                                            delegate: self
                                                                   cancelButtonTitle:@"cancel"
                                                              destructiveButtonTitle:nil
                                                                   otherButtonTitles:@"Camera", @"Photo Library", nil];
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

        NSString *individualImageFileName = [[NmffSharedImageProcessor sharedProcessor] getIndvidualImageFileNameWithName:self.title];

        [jpgData writeToFile:individualImageFileName atomically:TRUE];

        _individual.individualImage = editedImage;

        _imageFrame = [[UIView alloc] initWithFrame:CGRectMake(60, 110, 200, 200)];
        UIImageView *imageInFrame = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];

        imageInFrame.image = editedImage;

        [_imageFrame addSubview:imageInFrame];

        [_NmffDetailView addSubview:_imageFrame];


    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
