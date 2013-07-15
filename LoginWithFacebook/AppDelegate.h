//
//  AppDelegate.h
//  LoginWithFacebook
//
//  Created by mac developer on 7/11/13.
//  Copyright (c) 2013 mac developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController; 

@end
