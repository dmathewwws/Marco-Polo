//
//  BloggerDashboardViewController.m
//  Marco Polo
//
//  Created by Roland on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import "BloggerDashboardViewController.h"
#import "Singleton.h"


@interface BloggerDashboardViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *bloggerDashboardTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipsToolsSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *jobCategoryTextField;

@end


@implementation BloggerDashboardViewController


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

    [Singleton sharedInstance].myDashboardViewController = self;
    
    self.bloggerDashboardTableView.delegate = self;
    self.bloggerDashboardTableView.dataSource = self;

    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [self.segmentedControl setTitleTextAttributes:attributes
                                         forState:UIControlStateNormal];
    [self.tipsToolsSegmentedControl setTitleTextAttributes:attributes
                                                  forState:UIControlStateNormal];
    CGRect frame= self.segmentedControl.frame;
    [self.segmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 22.0f)];
    frame= self.tipsToolsSegmentedControl.frame;
    [self.tipsToolsSegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 22.0f)];
}


- (void)viewDidUnload
{
    [self setBloggerDashboardTableView:nil];
    [self setBloggerDashboardTableView:nil];
    [self setSegmentedControl:nil];
    [self setTipsToolsSegmentedControl:nil];
    [self setJobCategoryTextField:nil];
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"In textFieldShouldReturn");
    [textField resignFirstResponder];
    return NO;
}


#pragma mark - Touch Gestures

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    [self.jobCategoryTextField resignFirstResponder];
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


@end
