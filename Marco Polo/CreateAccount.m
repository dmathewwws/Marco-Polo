//
//  CreateAccount.m
//  Marco Polo
//
//  Created by Daniel Mathews on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//

#import "CreateAccount.h"
#import "MarcoConstants.h"
#import "UIImage+ResizeAdditions.h"
#import "UIImage+RoundedCornerAdditions.h"

@interface CreateAccount ()

@end

@implementation CreateAccount

@synthesize name = _name;
@synthesize email = _email;
@synthesize twitterHandle = _twitterHandle;
@synthesize blogLink = _blogLink;
@synthesize category = _category;
@synthesize aboutMe = _aboutMe;
@synthesize picker = _picker;
@synthesize avatarImage = _avatarImage;
@synthesize stringPicker = _stringPicker;
@synthesize userSmallAvatar = _userSmallAvatar;
@synthesize categories = _categories;
@synthesize selectedIndex = _selectedIndex;


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
    _name.delegate = self;
    _email.delegate = self;
    _blogLink.delegate = self;
    _category.delegate = self;
    _aboutMe.delegate = self;
    
    self.categories = [NSArray arrayWithObjects:@"Automotive", @"Technology", @"Fashion", nil];

    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setName:nil];
    [self setEmail:nil];
    [self setTwitterHandle:nil];
    [self setBlogLink:nil];
    [self setCategory:nil];
    [self setAboutMe:nil];
    [self setAvatarImage:nil];
    [super viewDidUnload];
}

- (IBAction)authTwitter:(id)sender {
    
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Twitter login.");
                
            } else {
                NSLog(@"Uh oh. An error occurred: %@ Code:%d", error, error.code);
                UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error accessing Twitter, please try again or pick a different signup option"]
                                                                   message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alertView show];
            }
            return;
        } else{
            NSLog(@"User signed up and logged in with Twitter!");
            [self twitterInit:@""];
        }
    }];
}

- (void)twitterInit:(NSString *)permissions {
    // Construct the parameters string. The value of "status" is percent-escaped.
    
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/account/verify_credentials.json"];
    NSMutableURLRequest *tweetRequest = [NSMutableURLRequest requestWithURL:url];
    
    [[PFTwitterUtils twitter] signRequest:tweetRequest];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    // Post status synchronously.
    NSData *data = [NSURLConnection sendSynchronousRequest:tweetRequest
                                         returningResponse:&response
                                                     error:&error];
    
    NSError* error2;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error2];
    
    // Handle response.
    if (!error && !error2) {
        
        
       // NSLog(@"blog url is %@",[json objectForKey:@"url"]);
        NSLog(@"profile image url is %@",[json objectForKey:@"profile_image_url"]);
        
        _name.text = [json objectForKey:@"name"];
       // _blogLink.text = [json objectForKey:@"url"];
        _avatarImage.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[json objectForKey:@"profile_image_url"]]]];
        [self uploadImage:_avatarImage.image];
        _twitterHandle = [json objectForKey:@"screen_name"];
    
        // save local data to Parse DB
    }else {
        NSLog(@"Error: %@ or Error2: %@", error, error2);
    }
}

- (IBAction)submitButton:(id)sender {
    
    if (_name.text.length == 0) {
        
    }else{
        
/*        PFUser *currentUser = [PFUser currentUser];
        
        // add FB data to Parse db
        [currentUser setObject:_name.text forKey:kMarcoNameKey];
        [currentUser setObject:_email.text forKey:kMarcoEmailKey];
        [currentUser setObject:_twitterHandle forKey:kMarcoTwitterHandleKey];
        [currentUser setObject:_blogLink.text forKey:kMarcoBlogLinkKey];
        [currentUser setObject:_category.text forKey:kMarcoCategoryKey];
        [currentUser setObject:_aboutMe.text forKey:kMarcoAboutMeKey];
        [currentUser setObject:_userSmallAvatar forKey:kMarcoAvatarKey];
        [currentUser setObject:[NSNumber numberWithInt:1] forKey:kMarcoTypeKey];

        // save local data to Parse DB
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                NSLog(@"Horray! User saved in Database");
                
                TwtCreateAccountViewController *createView = [self.storyboard instantiateViewControllerWithIdentifier:@"TwtCreateAccountViewController"];
                 [self presentViewController:createView animated:YES completion:nil];
                
            }else {
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                
                [PFUser logOut];
                
                UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error! %@",errorString]
                                                                   message:nil
                                                                  delegate:self
                                                         cancelButtonTitle:nil
                                                         otherButtonTitles:@"Ok", nil];
                [alertView show];
                
            }
        }];
*/
    }
}

- (BOOL) uploadImage:(UIImage *)anImage{
    
    // Create a thumbnail and add a corner radius for use in table views
    UIImage *thumbnailImage = [anImage thumbnailImage:86.0f
                                    transparentBorder:0.0f
                                         cornerRadius:10.0f
                                 interpolationQuality:kCGInterpolationDefault];
    
    // Get an NSData representation of our images. We use JPEG for the larger image
    // for better compression and PNG for the thumbnail to keep the corner radius transparency

    NSData *thumbnailImageData = UIImageJPEGRepresentation(thumbnailImage, 0.8f);
    
    if (!thumbnailImageData) {
        return NO;
    }
    
    _userSmallAvatar = [PFFile fileWithData:thumbnailImageData];
    
    // Save the files
    [_userSmallAvatar saveInBackground];
    
    return YES;
}

#pragma mark -
#pragma mark TextFields

- (void) dismissKeyboard:(id) sender {
 
    [_name resignFirstResponder];
    [_email resignFirstResponder];
    [_blogLink resignFirstResponder];
    [_category resignFirstResponder];
    [_aboutMe resignFirstResponder];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _avatarImage.userInteractionEnabled = NO;
    [self animateTextField:textField up:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self animateTextField:textField up:NO];
    _avatarImage.userInteractionEnabled = YES;
    
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

- (IBAction)pickCategory:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Category" rows:self.categories initialSelection:self.selectedIndex target:self successAction:@selector(animalWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    
}

- (void)animalWasSelected:(NSNumber *)selectedIndex element:(id)element {
    self.selectedIndex = [selectedIndex intValue];
    
    //may have originated from textField or barButtonItem, use an IBOutlet instead of element
    self.category.text = [self.categories objectAtIndex:self.selectedIndex];
    [_category resignFirstResponder];
}

@end
