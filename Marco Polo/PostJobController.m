//
//  PostJobController.m
//  Marco Polo
//
//  Created by Daniel Mathews on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import "PostJobController.h"
#import "Singleton.h"

@interface PostJobController ()

@property (weak, nonatomic) IBOutlet UIButton *submitJobButton;
@property (weak, nonatomic) IBOutlet UITextView *jobDescriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation PostJobController

@synthesize blogsPerWeek = _blogsPerWeek;
@synthesize durationPerWeek = _durationPerWeek;
@synthesize dollarsPerWeek =_dollarsPerWeek;
@synthesize stringPicker = _stringPicker;
@synthesize categories = _categories;
@synthesize selectedIndex = _selectedIndex;
@synthesize category = _category;
@synthesize selectedIndexBlogsPerWeek = _selectedIndexBlogsPerWeek;
@synthesize selectedIndexDuration = _selectedIndexDuration;
@synthesize blogsPerWeekPicker = _blogsPerWeekPicker;
@synthesize durationPicker = _durationPicker;
@synthesize blogsPerWeekArray = _blogsPerWeekArray;
@synthesize durationArray = _durationArray;

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
    
    NSString *buttonTitle;
    if ([Singleton sharedInstance].createJobSource == 1)
    {
        NSLog(@"Creating job for Catherine");
        buttonTitle = @"Create job for Catherine";
    }
    else
    {
        NSLog(@"Creating new job for anyone");
        buttonTitle = @"Create new job";
    }
    [self.submitJobButton setTitle:buttonTitle
                          forState:UIControlStateNormal];
    [self.submitJobButton setTitle:buttonTitle
                          forState:UIControlStateApplication];
    [self.submitJobButton setTitle:buttonTitle
                          forState:UIControlStateHighlighted];
    [self.submitJobButton setTitle:buttonTitle
                          forState:UIControlStateReserved];
    [self.submitJobButton setTitle:buttonTitle
                          forState:UIControlStateSelected];
    [self.submitJobButton setTitle:buttonTitle
                          forState:UIControlStateDisabled];

    _blogsPerWeek.delegate = self;
    _durationPerWeek.delegate = self;
    _dollarsPerWeek.delegate = self;
    _category.delegate = self;
    _jobDescriptionTextView.delegate = self;
    
    
    self.categories = [NSArray arrayWithObjects:@"Automotive", @"Technology", @"Fashion", nil];
    self.blogsPerWeekArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", nil];
    self.durationArray = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)]];
    
    NSLog(@"Made it to end of ViewDIDLoad");

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBlogsPerWeek:nil];
    [self setDurationPerWeek:nil];
    [self setDollarsPerWeek:nil];
    [self setCategory:nil];
    [self setSubmitJobButton:nil];
    [self setJobDescriptionTextView:nil];
    [self setTotalLabel:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark TextFields

- (IBAction)submitJob:(id)sender
{
    NSString *alertMessage;
    NSString *alertTitle;
    if ([Singleton sharedInstance].createJobSource == 1)
    {
        alertMessage = @"Your job has been created and sent to Catherine.";
        alertTitle = @"Job Sent";
    }
    else
    {
        alertMessage = @"Your job has been created and is now available for bloggers to view.";
        alertTitle = @"Job Created";
    }

    [[[UIAlertView alloc] initWithTitle:alertTitle
                                message:alertMessage
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    
    [self.navigationController popToViewController:[Singleton sharedInstance].myDashboardViewController
                                          animated:YES];

}

- (void) dismissKeyboard:(id) sender {
    
    [_blogsPerWeek resignFirstResponder];
    [_durationPerWeek resignFirstResponder];
    [_dollarsPerWeek resignFirstResponder];
    [_category resignFirstResponder];
    [self.jobDescriptionTextView resignFirstResponder];
}

- (IBAction)pickCategory:(id)sender {
    
    _stringPicker = [ActionSheetStringPicker showPickerWithTitle:@"Select Category" rows:self.categories initialSelection:self.selectedIndex target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];

}

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    
    NSLog(@"in animalWasSelected element is %@",element);
    
    if (element == _category) {
        self.selectedIndex = [selectedIndex intValue];
        
        //may have originated from textField or barButtonItem, use an IBOutlet instead of element
        self.category.text = [self.categories objectAtIndex:self.selectedIndex];
        [_category resignFirstResponder];
        
            NSLog(@"in animalWasSelected elemeent = _stringPicker ");
        
    }else if (element == _blogsPerWeek) {
            self.selectedIndexBlogsPerWeek = [selectedIndex intValue];
            
            //may have originated from textField or barButtonItem, use an IBOutlet instead of element
            self.blogsPerWeek.text = [self.blogsPerWeekArray objectAtIndex:self.selectedIndexBlogsPerWeek];
            [_blogsPerWeek resignFirstResponder];
        
                    NSLog(@"in animalWasSelected elemeent = _blogsPerWeekPicker ");
    }else if (element == _durationPerWeek) {
        self.selectedIndexDuration = [selectedIndex intValue];
        
        //may have originated from textField or barButtonItem, use an IBOutlet instead of element
        self.durationPerWeek.text = [self.durationArray objectAtIndex:self.selectedIndexDuration];
        [_durationPerWeek resignFirstResponder];
        
                            NSLog(@"in animalWasSelected elemeent = _durationPerWeek ");
    }
}


- (IBAction)pickBlogsPerWeek:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Option" rows:self.blogsPerWeekArray initialSelection:self.selectedIndexBlogsPerWeek target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    
}

- (IBAction)pickDuration:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Option" rows:self.durationArray initialSelection:self.selectedIndexDuration target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    
}

- (void)actionPickerCancelled:(id)parm
{
    NSLog(@"Action picker cancelled");
    [self dismissKeyboard:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"In textFieldShouldReturn");
    [textField resignFirstResponder];
/*
 if(textField == _dollarsPerWeek ){
        NSLog(@"total value is: %d",((self.selectedIndexBlogsPerWeek)+1)*((self.selectedIndexDuration)+1)*[_dollarsPerWeek.text intValue]);
        NSLog(@"self.selectedIndexBlogsPerWeek is: %d",((self.selectedIndexBlogsPerWeek)+1));
        NSLog(@"self.selectedIndexDuration is: %d",((self.selectedIndexDuration)+1));
        NSLog(@"_dollarsPerWeek.text intValue is: %d",[_dollarsPerWeek.text intValue]);
        
    }
*/
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"In textFieldShouldReturn");
    if(textField != _dollarsPerWeek ){
        [textField resignFirstResponder];
    }
    
//    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"In textFieldDidEndEditing");
//    [self animateTextField:textField up:NO];
    
    if(textField == _dollarsPerWeek )
    {
        NSLog(@"total value is: %d",((self.selectedIndexBlogsPerWeek)+1)*((self.selectedIndexDuration)+1)*[_dollarsPerWeek.text intValue]);
        NSLog(@"self.selectedIndexBlogsPerWeek is: %d",((self.selectedIndexBlogsPerWeek)+1));
        NSLog(@"self.selectedIndexDuration is: %d",((self.selectedIndexDuration)+1));
        NSLog(@"_dollarsPerWeek.text intValue is: %d",[_dollarsPerWeek.text intValue]);
        self.totalLabel.text = [NSString stringWithFormat:@"total $%0.2f", ((self.selectedIndexBlogsPerWeek)+1)*((self.selectedIndexDuration)+1)*[_dollarsPerWeek.text floatValue]];
    }
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self animateTextField:textView up:YES];

}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    [self animateTextField:textView up:NO];
    [_jobDescriptionTextView resignFirstResponder];
}

-(void)animateTextField:(id)textField up:(BOOL)up
{
    const int movementDistance = -195; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}




@end
