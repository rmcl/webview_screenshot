//
//  WebViewScreenshot.m
//  WebViewScreenshot
//
//  Created by Russell Mcloughlin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WebViewScreenshot.h"
@interface WebViewScreenshot ()

@property (retain, nonatomic) NSMutableArray *garbageWebViews;

@end


@implementation WebViewScreenshot

@synthesize garbageWebViews = _garbageWebViews;

- (id)init {
    self = [super init];
    if (self != nil) {
        _garbageWebViews = [[NSMutableArray alloc] init];
    }
    return self;
}

// A method to capture a screenshot of a given url and pass the image
// to the given delegate.
// passThrough can be any object that will be passed to the delegate.
- (void)captureScreenFor:(NSURL *)url delegate:(id)delegate passThrough:(id)obj {
    // Iterate through a list of web views that have been used and release them
    [self removeGarbageWebViews];
    
    //Allocate & Init a new web view.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    [webView setDelegate:self];
    
    //Put delegate in key/value store of webview so we can retrieve it after
    // the web view loads.
    [webView.layer setValue:delegate forKey:@"delegate"];
    [webView.layer setValue:obj forKey:@"passthrough"];
    
    // Start loading the request with the given URL
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

// Remove web views that are no longer required.
- (void)removeGarbageWebViews {
    
    for (UIWebView *curWV in _garbageWebViews) {
        [curWV release];
    }
    [_garbageWebViews removeAllObjects];
    
}

- (void)didFailLoadWithError:(NSError *)error {
    NSLog(@"Failed to load page to capture screenshot.");
}
- (void)webViewDidFinishLoad:(UIWebView *)curWebView {
    
    // Setup the Image context. Special handling for retina.
    if ([UIScreen instancesRespondToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0f) {
        UIGraphicsBeginImageContextWithOptions(curWebView.frame.size, NO, 2.0f);
    } else {
        UIGraphicsBeginImageContext(curWebView.frame.size);
    }
    
    // Render the web view
	[curWebView.layer renderInContext:UIGraphicsGetCurrentContext()];
	
    // Get the image
    UIImage *image = [UIGraphicsGetImageFromCurrentImageContext() retain];
    
    // End the graphics context
	UIGraphicsEndImageContext();
        
    // Retrieve the delegate that wants to be notified when we have the screenshot.
    id <WebViewScreenshotDelegate> delegate = [curWebView.layer valueForKey:@"delegate"];
    [curWebView.layer setValue:nil forKey:@"delegate"];
    
    id passThrough = [curWebView.layer valueForKey:@"passthrough"];
    [curWebView.layer setValue:nil forKey:@"passthrough"];
    
    [_garbageWebViews addObject:curWebView];
    
    // Send the message.
    [delegate didGenerateScreenshot:image passThrough:passThrough];
}

- (void)dealloc {
    [super dealloc];
}

@end
