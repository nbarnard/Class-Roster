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

@interface NmffViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSArray *myIndividualsArray;
@end

@implementation NmffViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    self.title = @"Roster";

    _myIndividualsArray = self.loadIndividuals;

    // Do any additional setup after loading the view, typically from a nib.
}


- (NSArray *)loadIndividuals {

    NSString *fileName = [[NSBundle mainBundle] pathForResource: @"Bootcamp" ofType:@"plist"];

    NSMutableArray *individuals = [NSMutableArray new];

    NSArray *individualDict = [[NSArray alloc] initWithContentsOfFile:fileName];

    for (NSDictionary *individual in individualDict) {
        NSString *name = [individual objectForKey:@"name"];
        UIImage *image = [UIImage new];

        [individuals addObject: [[NmffIndividual alloc] initWithName:name andRole:Student andImage:image]];
    }

    return [[NSArray alloc] initWithArray:individuals];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _myIndividualsArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath: indexPath];

    NmffIndividual *currentIndividual = [_myIndividualsArray objectAtIndex:indexPath.row];

    cell.textLabel.text = currentIndividual.name;

    return cell;

}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UITableViewCell *tapped = sender;

    NSString *individual = tapped.textLabel.text;

    if ([segue.destinationViewController isKindOfClass:[NmffDetailViewController class]]) {
        NmffDetailViewController *destination = (NmffDetailViewController *)segue.destinationViewController;
        destination.individualName = individual;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end