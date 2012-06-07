//
//  ViewController.m
//  WebViewScreenshot
//
//  Created by Russell Mcloughlin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "WebViewScreenshot.h"

@interface ViewController ()

@property (nonatomic, retain) WebViewScreenshot *ss;

@end

@implementation ViewController

@synthesize imageViewer = _imageViewer;
@synthesize ss = _ss;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    _ss = [[WebViewScreenshot alloc] init];
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    //[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:htmlPath ofType:@"html"]isDirectory:NO]];
    
    [_ss captureScreenFor:url delegate:self passThrough:@"HELLO"];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didGenerateScreenshot:(UIImage*) newImg passThrough:(id)obj {
    UIImage *oldImage = [_imageViewer image];
    [_imageViewer setImage:newImg];
    
    [oldImage release];
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    [_ss captureScreenFor:url delegate:self passThrough:obj];
}

@end
