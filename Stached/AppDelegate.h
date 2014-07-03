//
//  AppDelegate.h
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-17.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    UIViewController *viewController;    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UIViewController *viewController;

- (void) startCamera;

@end
