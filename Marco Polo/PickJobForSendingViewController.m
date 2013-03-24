//
//  PickJobForSendingViewController.m
//  Marco Polo
//
//  Created by Roland on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//


#import "PickJobForSendingViewController.h"
#import "Singleton.h"


@interface PickJobForSendingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *pickJobForSendingTableView;

@end


@implementation PickJobForSendingViewController


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
    
    self.pickJobForSendingTableView.delegate = self;
    self.pickJobForSendingTableView.dataSource = self;
}


- (void)viewDidUnload
{
    [self setPickJobForSendingTableView:nil];
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"In numberOfRowsInSection, for section %d", section);
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"s%ir%i", indexPath.section, indexPath.row];
    NSLog(@"Using cellID = %@", cellIdentifier);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        //you can customize your cell here because it will be used just for one row.
    }
    
    return cell;
}


#pragma mark - Normal methods

- (IBAction)sendExistingJobButtonTapped:(id)sender
{
    NSString *alertMessage = @"Your job has been sent to Catherine";
    [[[UIAlertView alloc] initWithTitle:@"You're one step closer!"
                                message:alertMessage
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];

    [self.navigationController popToViewController:[Singleton sharedInstance].myDashboardViewController
                                          animated:YES];
}


- (IBAction)createNewJobButtonTapped:(id)sender
{
}


@end
