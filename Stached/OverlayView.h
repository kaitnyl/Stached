//
//  OverlayView.h
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-18.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverlayView : UIView
{
    NSMutableArray *pix;
    NSInteger curStache;
    UIImageView *moustacheFrame;
    UIImagePickerController *pickerRef;
}

@property (nonatomic, retain) NSMutableArray *pix;
@property (nonatomic) NSInteger curStache;
@property (nonatomic, retain) UIImageView *moustacheFrame;
@property (nonatomic, retain) UIImagePickerController *pickerRef;

@end
