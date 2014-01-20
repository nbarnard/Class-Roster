//
//  NmffViewController.m
//  Class Roster
//
//  Created by Nicholas Barnard on 1/14/14.
//  Copyright (c) 2014 NMFF Development. All rights reserved.
//

#import "NmffViewController.h"
#import "NmffDetailViewController.h"
#import "NmffIndividual.h"
#import "NmffDataController.h"
#import "NmffCell.h"

@interface NmffViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NmffDataController *myDataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sortbutton;

@end

@implementation NmffViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _myTableView.delegate = self;
    _myDataSource = [[NmffDataController sharedController] loadInitialData];
    _myTableView.dataSource = _myDataSource;

    self.title = @"Roster";

    // Do any additional setup after loading the view, typically from a nib.
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NmffCell *tappedIndividual = sender;

    if ([segue.destinationViewController isKindOfClass:[NmffDetailViewController class]]) {
        NmffDetailViewController *destination = (NmffDetailViewController *)segue.destinationViewController;
        destination.individual = tappedIndividual.cellIndividual;

    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.myTableView reloadData];
}

- (IBAction) sortButtonPressed:(id)sender {
    UIActionSheet *sortDirectionActionSheet = [[UIActionSheet alloc] initWithTitle:@"Sort direction" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"A - Z", @"Z - A", nil];
    [sortDirectionActionSheet showInView:_myTableView];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSString *buttonTapped = [actionSheet buttonTitleAtIndex:buttonIndex];

    if([buttonTapped isEqualToString:@"A - Z"]) {
        [_myDataSource sortListDirection:YES];
    } else if ([buttonTapped isEqualToString:@"Z - A"]) {
        [_myDataSource sortListDirection:NO];
    } else {
        return;
    }

    [_myTableView reloadData];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end