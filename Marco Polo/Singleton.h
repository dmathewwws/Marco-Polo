//
//  Singleton.h
//  Marco Polo
//
//  Created by Roland on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Singleton : NSObject

@property (weak, nonatomic) UIViewController *myDashboardViewController;

+ (Singleton *)sharedInstance;

@end
