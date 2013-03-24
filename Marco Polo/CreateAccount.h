//
//  CreateAccount.h
//  Marco Polo
//
//  Created by Daniel Mathews on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CreateAccount : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

- (IBAction)authTwitter:(id)sender;
- (IBAction)submitButton:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *avatarImage;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) NSString *twitterHandle;
@property (strong, nonatomic) IBOutlet UITextField *blogLink;
@property (strong, nonatomic) IBOutlet UITextField *category;
@property (strong, nonatomic) IBOutlet UITextView *aboutMe;
@property (strong, nonatomic) UIImagePickerController *picker;

@property (strong, nonatomic) PFFile *userSmallAvatar;

- (void)twitterInit:(NSString *)permissions;
- (BOOL) uploadImage:(UIImage *)anImage;


@end
