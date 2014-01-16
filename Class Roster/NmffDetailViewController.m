//
//  NmffDetailViewController.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffDetailViewController.h"

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

    UIActionSheet *photoSourceActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Gallery", nil];


    [photoSourceActionSheet showInView: _NmffDetailView];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTapped = [actionSheet buttonTitleAtIndex:buttonIndex];

    UIImagePickerController *imagePicker = [UIImagePickerController new];

    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;


    if([buttonTapped isEqualToString:@"Camera"]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else if ([buttonTapped isEqualToString:@"Photo Gallery"]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        return;
    }

    [self presentViewController:imagePicker animated:TRUE completion:nil];

}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *jpgData = UIImageJPEGRepresentation(editedImage, .55);
        NSString *individualName = [self.title stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSLog(@"%@", individualName);

    }];
}

- (NSString *)documentDirectoryPath{
//    NSURL *documentsURL = [[[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask] lastObject];
//    return [documentsURL path];
    return @"bite me";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
