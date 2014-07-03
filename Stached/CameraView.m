//
//  CameraView.m
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-17.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CameraView.h"
#import "OverlayView.h"
#import "StacheView.h"

@implementation CameraView
@synthesize picker, overlay, updated, showPhoto;

- (void) viewDidAppear: (BOOL)animated
{
    [self displayScreen];
}

- (void) displayScreen
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if(showPhoto == YES)
    {
        [picker.view removeFromSuperview];
        [overlay removeFromSuperview];
        
        // Fix to make up for iPhone5 having larger camera controls area
        int controlsSize = (screenHeight == 568) ? 96 : 54;

        UIGraphicsBeginImageContext(CGSizeMake(screenWidth, screenHeight - controlsSize));
        [updated drawInRect:CGRectMake(0, 0, screenWidth, screenHeight - controlsSize)];
        updated = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *photo = [[UIImageView alloc] initWithImage:updated];
        photo.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:photo];
        [photo release];
        
        StacheView *staches = [[StacheView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        staches.pickerRef = self;
        [self.view addSubview:staches];
    }
    else
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.wantsFullScreenLayout = YES;
            picker.showsCameraControls = NO;
            picker.delegate = self;
            [self.view addSubview:picker.view];
        
            overlay = [[OverlayView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            overlay.pickerRef = picker;

            [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(holdOverlay:) userInfo:overlay repeats:YES];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cameraReady:) name:AVCaptureSessionDidStartRunningNotification object:nil];             
        }
        else
        {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"\n\nNo Camera Detected!" message:@"Woah man, either your camera is broken, or your device has no camera. Currently, this app only works with an active camera.\nYou'll have to close this now... :(" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil] autorelease];
            [alert show];
        }
    }
}

- (void) cameraReady: (NSNotification *)notification
{
    picker.cameraOverlayView = overlay;
}

- (void) holdOverlay: (NSTimer*)timer
{
    UIView *cameraOverlayView = (UIView *)timer.userInfo;
    UIView *previewView = cameraOverlayView.superview.superview;
    
    if (previewView != nil)
    {
        [cameraOverlayView removeFromSuperview];
        [cameraOverlayView release];        
        [previewView insertSubview:cameraOverlayView atIndex:1];
        cameraOverlayView.hidden = NO;
        [timer invalidate];
    }
}

- (void) imagePickerController: (UIImagePickerController *)asdf didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    int width, height;
    if(picker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        width = 320;
        height = 480;
    }
    else
    {
        width = 720;
        height = 960;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    updated = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    showPhoto = YES;
    [self displayScreen];
}

- (void) saveWithStache: (NSArray *)staches :(NSInteger)curStache
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    UIImage *image = updated;
    UIImage *moustache = [staches objectAtIndex:curStache];
    UIImage *watermark = [UIImage imageNamed:@"stached_watermark_.png"];
    
    UIGraphicsBeginImageContext(CGSizeMake((moustache.size.width*2.25), (moustache.size.height*2.22)));
    [moustache drawInRect:CGRectMake(0, 0, (moustache.size.width*2.25), (moustache.size.height*2.22))];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    moustache = newImage;
    
    int width, height;
    if(picker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        width = 320;
        height = 480;
    }
    else
    {
        width = 720;
        height = 960;
    }
    
    // iPhone5 fix- photo preview + actual photo size aren't the same proportion
    int proportionFix = (screenHeight == 568) ? 38 : 61;
    int watermarkFix = (screenHeight == 568) ? 100 : 130;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    [moustache drawAtPoint:CGPointMake(width/2 - moustache.size.width/2, height/2 - moustache.size.height/2 + proportionFix )];
    [watermark drawAtPoint:CGPointMake(width - watermarkFix, height - watermark.size.height - 10)];
    updated = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(updated, nil, nil, nil);
    showPhoto = NO;
    [self displayScreen];
    
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Image Saved" message:@"Don't forget to share yo 'stache with friends! It's in your Camera Roll, so you can upload it to Facebook, Twitter, and Instagram :)" delegate:self cancelButtonTitle:@"Got it!" otherButtonTitles:nil, nil] autorelease];
    [alert show];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) dealloc
{
    [picker release];
    [overlay release];
    [updated release];
    [super dealloc];
}

@end
