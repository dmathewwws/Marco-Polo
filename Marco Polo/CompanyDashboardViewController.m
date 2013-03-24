//
//  CompanyDashboardViewController.m
//  Marco Polo
//
//  Created by Roland on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//


#import "CompanyDashboardViewController.h"
#import "Singleton.h"
#import "ActionSheetStringPicker.h"


@interface CompanyDashboardViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *companyDashboardTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipsToolsSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *jobCategoryTextField;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL selected;

@end


@implementation CompanyDashboardViewController


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

    self.companyDashboardTableView.delegate = self;
    self.companyDashboardTableView.dataSource = self;
    self.jobCategoryTextField.delegate = self;

    self.selected = NO;

    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
    [self.segmentedControl setTitleTextAttributes:attributes
                                         forState:UIControlStateNormal];
    [self.tipsToolsSegmentedControl setTitleTextAttributes:attributes
                                                  forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:attributes
                                         forState:UIControlStateNormal];
    [self.tipsToolsSegmentedControl setTitleTextAttributes:attributes
                                                  forState:UIControlStateNormal];
    CGRect frame= self.segmentedControl.frame;
    [self.segmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 22.0f)];
    frame= self.tipsToolsSegmentedControl.frame;
    [self.tipsToolsSegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 22.0f)];

    self.categories = [NSArray arrayWithObjects:@"Automotive", @"Technology", @"Fashion", nil];
}


- (void)viewDidUnload
{
    [self setCompanyDashboardTableView:nil];
    
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


#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"In numberOfRowsInSection, for section %d", section);
    if (self.selected)
    {
        return 2;
    }
    else
    {
        return 0;
    }
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


#pragma mark - Picker methods

- (IBAction)pickCategory:(id)sender
{
    [ActionSheetStringPicker showPickerWithTitle:@"Select Job Category"
                                            rows:self.categories
                                initialSelection:self.selectedIndex
                                          target:self successAction:@selector(jobCategoryWasSelected:element:)
                                    cancelAction:@selector(actionPickerCancelled:)
                                          origin:sender];
    
}


- (void)jobCategoryWasSelected:(NSNumber *)selectedIndex
                       element:(id)element
{
    self.selectedIndex = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.jobCategoryTextField.text = [self.categories objectAtIndex:self.selectedIndex];
    [self.jobCategoryTextField resignFirstResponder];

    if ([self.jobCategoryTextField.text isEqualToString:@"Automotive"])
    {
        self.selected = YES;
    }
    
    [self.companyDashboardTableView reloadData];
}


- (void)actionPickerCancelled:(id)parm
{
    NSLog(@"Action picker cancelled");
    [self.jobCategoryTextField resignFirstResponder];
}


#pragma mark - Normal method

- (IBAction)newJobButtonTapped:(id)sender
{
    [Singleton sharedInstance].createJobSource = 0;
}


@end
