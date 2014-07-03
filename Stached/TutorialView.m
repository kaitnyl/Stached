//
//  TutorialView.m
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-17.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import "TutorialView.h"
#import "AppDelegate.h"

@implementation TutorialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"IS_howtosteps_.png"]];
        UIImage *bgImage = [UIImage imageNamed:@"IS_howtosteps_.png"];
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.f);
        [bgImage drawInRect:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        UIImage *resizedBg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:resizedBg]];
        
        UIButton *peace = [UIButton buttonWithType:UIButtonTypeCustom];
        peace.frame = CGRectMake(60, (self.frame.size.height - 100), 200, 70);
        [peace addTarget:self action:@selector(tutorialFinished) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:peace];
    }
    return self;
}

- (void) tutorialFinished
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate startCamera];
    [self removeFromSuperview];
}

@end
