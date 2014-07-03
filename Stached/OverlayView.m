//
//  OverlayView.m
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-18.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import "OverlayView.h"
#import "CameraView.h"

@implementation OverlayView
@synthesize pix, curStache, moustacheFrame, pickerRef;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        CGFloat camHeight = screenRect.size.height == 568 ? screenRect.size.height - 61 : screenRect.size.height;
        
        pix = [[NSMutableArray alloc] init];
        [pix addObject:[UIImage imageNamed:@"0.png"]];
        curStache = 0;
        
        UIImage *moustache = [pix objectAtIndex:curStache];
        moustacheFrame = [[[UIImageView alloc] initWithImage:moustache] autorelease];
        moustacheFrame.contentMode = UIViewContentModeScaleAspectFit;
        moustacheFrame.center = CGPointMake((screenWidth/2), (camHeight/2));
        [self addSubview:moustacheFrame];
        
        /*UIImageView *border = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bar_.png"]] autorelease];
         [self addSubview:border];*/
        
        UIImageView *flipIcon = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera_view_.png"]] autorelease];
        flipIcon.frame = CGRectMake(265, 5, flipIcon.bounds.size.width/1.3, flipIcon.bounds.size.height/1.3);
        [self addSubview:flipIcon];
        
        UIButton *buttonFlip = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFlip.frame = CGRectMake(255, 0, 65, 35);
        [buttonFlip addTarget:self action:@selector(flipItGood) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonFlip];
        
        UIImageView *tabBar = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_bg_org_.jpg"]] autorelease];
        tabBar.frame = CGRectMake(0, (screenHeight-49), screenWidth, 49);
        
        [self addSubview:tabBar];
        
        UIImageView *takePic = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"take_photo_.png"]] autorelease];
        takePic.frame = CGRectMake((screenWidth/2 - takePic.bounds.size.width/2), (screenHeight - 40), takePic.bounds.size.width, takePic.bounds.size.height);
        [self addSubview:takePic];
        
        UIButton *buttonPic = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonPic.frame = CGRectMake(0, (screenHeight-49), screenWidth, 49);
        [buttonPic addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonPic];

    }
    return self;
}

- (void) flipItGood
{
    if(pickerRef.cameraDevice == UIImagePickerControllerCameraDeviceFront)
        pickerRef.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    else
        pickerRef.cameraDevice = UIImagePickerControllerCameraDeviceFront;
}

- (void) takePicture
{
    [pickerRef takePicture];
}

- (void) dealloc
{
	[pix release];
    [moustacheFrame release];
    [pickerRef release];
    [super dealloc];
}

@end
