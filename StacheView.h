//
//  StacheView.h
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-18.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"

@interface StacheView : UIView
{
    CameraView *pickerRef;
    UIView *touchView;
    CGPoint startPoint;
    UIImageView *moustacheFrame;    
    NSMutableArray *pix;
    NSInteger curStache;
    UIScrollView *scrollView;
}

@property (nonatomic, retain) CameraView *pickerRef;
@property (nonatomic, retain) UIView *touchView;
@property (nonatomic) CGPoint startPoint;
@property (nonatomic, retain) UIImageView *moustacheFrame;
@property (nonatomic, retain) NSMutableArray *pix;
@property (nonatomic) NSInteger curStache;
@property (nonatomic, retain) UIScrollView *scrollView;

@end
