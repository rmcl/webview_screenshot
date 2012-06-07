//
//  WebViewScreenshot.h
//  WebViewScreenshot
//
//  Created by Russell Mcloughlin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WebViewScreenshot;

@protocol WebViewScreenshotDelegate <NSObject>
@optional

//- (void)didFailToGenerateScreenshotWithError:(NSError *)error passThrough:(id)obj
- (void)didGenerateScreenshot:(UIImage*) newImg passThrough:(id)obj;

@end


@interface WebViewScreenshot : NSObject <UIWebViewDelegate>
- (void)captureScreenFor:(NSURL *)url delegate:(id)delegate passThrough:(id)passThrough;

@end
