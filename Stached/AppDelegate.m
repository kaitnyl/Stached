//
//  AppDelegate.m
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-17.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import "AppDelegate.h"
#import "TutorialView.h"
#import "CameraView.h"

@implementation AppDelegate
@synthesize window, viewController;

- (BOOL) application: (UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    viewController = [UIViewController new];
    window.rootViewController = viewController;
    [viewController release];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"preview"])
    {
        TutorialView *tutorial = [[TutorialView alloc] initWithFrame:[window bounds]];
        [viewController.view addSubview:tutorial];
        [tutorial release];
    }
    else
    {
        [self startCamera];
    }
    // Tutorial screen has been deemed cool and should be shown upon startup every time
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"preview"];
    
    [window makeKeyAndVisible];
    return YES;
}

- (void) startCamera
{
    CameraView *camera = [[CameraView alloc] initWithNibName:nil bundle:nil];
    [viewController.view addSubview:camera.view];
}

- (void) dealloc
{
    [window release];
    [viewController release];
    [super dealloc];
}

@end
