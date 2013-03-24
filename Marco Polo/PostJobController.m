//
//  PostJobController.m
//  Marco Polo
//
//  Created by Daniel Mathews on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import "PostJobController.h"

@interface PostJobController ()

@end

@implementation PostJobController

@synthesize blogsPerWeek = _blogsPerWeek;
@synthesize durationPerWeek = _durationPerWeek;
@synthesize dollarsPerWeek =_dollarsPerWeek;
@synthesize stringPicker = _stringPicker;
@synthesize categories = _categories;
@synthesize selectedIndex = _selectedIndex;
@synthesize category = _category;

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
    
    _blogsPerWeek.delegate = self;
    _durationPerWeek.delegate = self;
    _dollarsPerWeek.delegate = self;
    _category.delegate = self;
    
    self.categories = [NSArray arrayWithObjects:@"Automative", @"Technology", @"Fashion", nil];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)]];


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
    [super viewDidUnload];
}

#pragma mark -
#pragma mark TextFields

- (IBAction)submitJob:(id)sender {
    
}

- (void) dismissKeyboard:(id) sender {
    
    [_blogsPerWeek resignFirstResponder];
    [_durationPerWeek resignFirstResponder];
    [_dollarsPerWeek resignFirstResponder];
    [_category resignFirstResponder];
}

- (IBAction)pickCategory:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Category" rows:self.categories initialSelection:self.selectedIndex target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];

}

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.category.text = [self.categories objectAtIndex:self.selectedIndex];
    [_category resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self animateTextField:textField up:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextField:textField up:NO];
    
}

-(void)animateTextField:(id)textField up:(BOOL)up
{
    const int movementDistance = -135; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}




@end
