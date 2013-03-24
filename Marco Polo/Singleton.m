//
//  Singleton.m
//  Marco Polo
//
//  Created by Roland on 2013-03-23.
//  Copyright (c) 2013 com.marcopolo. All rights reserved.
//


#import "Singleton.h"


@interface Singleton ()

@end


@implementation Singleton


#pragma mark - Singleton Implementation

static Singleton *_sharedSingleton = nil;
static bool _isInitFromShared = NO;


+ (Singleton *)sharedInstance
{
	@synchronized([Singleton class])
	{
		if (!_sharedSingleton)
        {
            _isInitFromShared = YES;
			_sharedSingleton = [[self alloc] init];
            _isInitFromShared = NO;
        }
		return _sharedSingleton;
	}
    
	return nil;
}


+ (id)alloc
{
	@synchronized([Singleton class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}


- (void)dealloc
{
    
}


- (id)init
{
    NSAssert(_isInitFromShared == YES, @"Attempted to instantiate mzxUser with init.  Use currentUser instead.");
	self = [super init];
	if (self != nil)
    {
        // Initialise properties
	}
    
	return self;
}


@end
