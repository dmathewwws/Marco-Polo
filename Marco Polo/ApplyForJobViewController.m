//
//  ApplyForJobViewController.m
//  Marco Polo
//
//  Created by Roland on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//


#import "ApplyForJobViewController.h"
#import "Singleton.h"


@interface ApplyForJobViewController ()

@end


@implementation ApplyForJobViewController


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
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)confirmButtonTapped:(id)sender
{
    NSString *alertMessage = @"Your request has been sent. You will receive a message from BMW shortly.";
    [[[UIAlertView alloc] initWithTitle:@"You're one step closer!"
                                message:alertMessage
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    
    [self.navigationController popToViewController:[Singleton sharedInstance].myDashboardViewController
                                          animated:YES];
}


@end
