//
//  PostJobController.h
//  Marco Polo
//
//  Created by Daniel Mathews on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetStringPicker.h"

@interface PostJobController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *blogsPerWeek;
@property (strong, nonatomic) IBOutlet UITextField *durationPerWeek;
@property (strong, nonatomic) IBOutlet UITextField *dollarsPerWeek;
@property (strong, nonatomic) IBOutlet UITextField *category;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray *blogsPerWeekArray;
@property (nonatomic) NSInteger selectedIndexBlogsPerWeek;
@property (nonatomic, strong) NSArray *durationArray;
@property (nonatomic) NSInteger selectedIndexDuration;

@property (strong, nonatomic) ActionSheetStringPicker *stringPicker;
@property (strong, nonatomic) ActionSheetStringPicker *blogsPerWeekPicker;
@property (strong, nonatomic) ActionSheetStringPicker *durationPicker;

- (IBAction)submitJob:(id)sender;
- (void) dismissKeyboard:(id) sender;
- (IBAction)pickCategory:(id)sender;

- (IBAction)pickBlogsPerWeek:(id)sender;
- (IBAction)pickDuration:(id)sender;

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element;
@end
