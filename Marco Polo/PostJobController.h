//
//  PostJobController.h
//  Marco Polo
//
//  Created by Daniel Mathews on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionSheetStringPicker.h"

@interface PostJobController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITextField *blogsPerWeek;
@property (strong, nonatomic) IBOutlet UITextField *durationPerWeek;
@property (strong, nonatomic) IBOutlet UITextField *dollarsPerWeek;
@property (strong, nonatomic) IBOutlet UITextField *category;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) ActionSheetStringPicker *stringPicker;

- (IBAction)submitJob:(id)sender;
- (void) dismissKeyboard:(id) sender;
- (IBAction)pickCategory:(id)sender;

@end
