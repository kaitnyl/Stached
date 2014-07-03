//
//  CameraView.h
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-17.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"

@interface CameraView : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *picker;
    OverlayView *overlay;
    UIImage *updated;
    BOOL showPhoto;
}

@property (nonatomic, retain) UIImagePickerController *picker;
@property (nonatomic, retain) OverlayView *overlay;
@property (nonatomic, retain) UIImage *updated;
@property BOOL showPhoto;

- (void) displayScreen;
- (void) saveWithStache: (NSArray *)staches :(NSInteger)curStache;

@end
