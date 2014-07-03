//
//  StacheView.m
//  Stached
//
//  Created by Kaitlyn McDonald on 12-10-18.
//  Copyright (c) 2012 Kaitlyn McDonald. All rights reserved.
//

#import "StacheView.h"

@implementation StacheView
@synthesize pickerRef, touchView, startPoint, moustacheFrame, pix, curStache, scrollView;

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
        CGFloat camHeight = (screenRect.size.height == 568) ? screenRect.size.height - 61 : screenRect.size.height;
        
        pix = [[NSMutableArray alloc] init];
        [pix addObject:[UIImage imageNamed:@"1.png"]];
        [pix addObject:[UIImage imageNamed:@"2.png"]];
        [pix addObject:[UIImage imageNamed:@"3.png"]];
        [pix addObject:[UIImage imageNamed:@"4.png"]];
        [pix addObject:[UIImage imageNamed:@"5.png"]];
        [pix addObject:[UIImage imageNamed:@"6.png"]];
        [pix addObject:[UIImage imageNamed:@"7.png"]];
        [pix addObject:[UIImage imageNamed:@"8.png"]];
        [pix addObject:[UIImage imageNamed:@"9.png"]];
        [pix addObject:[UIImage imageNamed:@"10.png"]];
        [pix addObject:[UIImage imageNamed:@"11.png"]];
        [pix addObject:[UIImage imageNamed:@"12.png"]];
        curStache = 0;
        
        UIImage *moustache = [pix objectAtIndex:curStache];
        moustacheFrame = [[[UIImageView alloc] initWithImage:moustache] autorelease];
        moustacheFrame.contentMode = UIViewContentModeScaleAspectFit;
        moustacheFrame.center = CGPointMake((screenWidth/2), (camHeight/2));
        [self addSubview:moustacheFrame];
        
        /*UIImageView *border = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_bar_.png"]] autorelease];
         [self addSubview:border];*/
        
        UIImageView *tabBar = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_bg_org_.jpg"]] autorelease];
        tabBar.frame = CGRectMake(0, (screenHeight-49), screenWidth, 49);
        [self addSubview:tabBar];
        
        UIImageView *delete = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close_.png"]] autorelease];
        delete.frame = CGRectMake(65, (screenHeight-40), delete.bounds.size.width, delete.bounds.size.height);
        [self addSubview:delete];
        
        UIButton *buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDelete.frame = CGRectMake(55, (screenHeight-49), 40, 49);
        [buttonDelete addTarget:self action:@selector(deleted) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonDelete];
        
        UIImageView *keep = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accept_.png"]] autorelease];
        keep.frame = CGRectMake(225, (screenHeight-40), keep.bounds.size.width, keep.bounds.size.height);
        [self addSubview:keep];
        
        UIButton *buttonKeep = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonKeep.frame = CGRectMake(215, (screenHeight-49), 40, 49);
        [buttonKeep addTarget:self action:@selector(keeped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonKeep];
        
        [self browseStaches];
        
        touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, screenWidth, (screenHeight-120))];
        touchView.userInteractionEnabled = YES;
        [self addSubview:touchView];

    }
    return self;
}

- (void) deleted
{
    pickerRef.showPhoto = NO;
    [pickerRef displayScreen];
}

- (void) keeped
{
    [pickerRef saveWithStache:pix :curStache];
}

- (void) touchesBegan: (NSSet *)touches withEvent: (UIEvent *)event
{
	UITouch *touch = [touches anyObject];
    startPoint = [touch locationInView:touchView];
}

- (void) touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:touchView];
    CGFloat deltaX = fabsf(startPoint.x - currentPosition.x);
    
    if(deltaX > 30)
    {

        if(currentPosition.x < startPoint.x)
        {
            [self styleThatStache:1 :NO];
            [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self addStaches:curStache];
        }
        else if(currentPosition.x > startPoint.x)
        {
            [self styleThatStache:0 :NO];
            [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self addStaches:curStache];
        }
    }
}

- (void) styleThatStache: (NSInteger)der :(BOOL)specify
{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat camHeight = (screenRect.size.height == 568) ? screenRect.size.height - 61 : screenRect.size.height;
    
    if(specify)
    {
        curStache = der;
    }
    else
    {
        if(der == 0)
            curStache = curStache - 1;
        else
            curStache = curStache + 1;
    }
    
    if(curStache < 0)
        curStache = ([pix count] - 1);
    else if(curStache > ([pix count] - 1))
        curStache = 0;
    
    moustacheFrame.image = nil;
    UIImage *moustache = [pix objectAtIndex:curStache];
    moustacheFrame = [[UIImageView alloc] initWithImage:moustache];
    moustacheFrame.center = CGPointMake((screenWidth/2), (camHeight/2));
    [self addSubview:moustacheFrame];
    [self bringSubviewToFront:moustacheFrame];
}

- (void) browseStaches
{ 
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGRect frame = CGRectMake(0, (screenHeight-108), screenWidth, 60);
    scrollView = [[[UIScrollView alloc] initWithFrame:frame] autorelease];
    scrollView.pagingEnabled = YES;
    
    scrollView.backgroundColor = [UIColor colorWithRed:76/255.0 green:62/255.0 blue:26/255.0 alpha:1.0];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self addStaches:0];
    [self addSubview:scrollView];
}

- (void) addStaches: (int) index;
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    CGSize elementSize = CGSizeMake(80, 60);
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    [icons addObject:[UIImage imageNamed:@"0_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"1_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"2_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"3_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"4_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"5_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"6_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"7_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"8_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"9_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"10_icon_off.png"]];
    [icons addObject:[UIImage imageNamed:@"11_icon_off.png"]];
    
    for(int i = 0; i < icons.count; i++)
    {
        UIView* subview = [[UIView new] autorelease];
        [subview setUserInteractionEnabled:YES];
        UITapGestureRecognizer *selected = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (changeImg: )];
        [subview addGestureRecognizer: selected];
        subview.backgroundColor = [UIColor colorWithPatternImage:[icons objectAtIndex:i]];
        subview.tag = i;
        
        if(i == index)
            subview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d_icon_on.png", index]]];
        
        int elementX = elementSize.width * i;
        subview.frame = CGRectMake(elementX, 0, elementSize.width, elementSize.height);
        
        [scrollView addSubview:subview];
    }
    scrollView.contentSize = CGSizeMake((80*pix.count), scrollView.frame.size.height);
    [scrollView scrollRectToVisible:CGRectMake(screenWidth*(index/4), 0, screenWidth , (screenHeight/2)) animated:YES];
}

- (void)changeImg: (id)sender
{
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*) sender;
    UIImageView *imageView = (UIImageView *) recognizer.view;
    NSInteger index = [imageView tag];

    [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addStaches:index];
    
    [self styleThatStache:index :YES];
}

- (void) dealloc
{
    [pickerRef release];
    [touchView release];
    [moustacheFrame release];
    [pix release];
    [scrollView release];
    [super dealloc];
}

@end
