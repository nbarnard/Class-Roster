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

@interface NmffViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NmffDataController *myDataSource;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *alphabetizeButton;

@end

@implementation NmffViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _myTableView.delegate = self;
    _myDataSource = [[NmffDataController alloc] init];
    _myTableView.dataSource = _myDataSource;

    self.title = @"Roster";

    // Do any additional setup after loading the view, typically from a nib.
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UITableViewCell *tapped = sender;

    NSString *individual = tapped.textLabel.text;

    if ([segue.destinationViewController isKindOfClass:[NmffDetailViewController class]]) {
        NmffDetailViewController *destination = (NmffDetailViewController *)segue.destinationViewController;
        destination.individualName = individual;
    }
}

- (IBAction) alphabetizeButtonPressed:(id)sender {
    [_myDataSource alphabetizeList];

    [_myTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end