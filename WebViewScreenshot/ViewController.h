//
//  ViewController.h
//  WebViewScreenshot
//
//  Created by Russell Mcloughlin on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewScreenshot.h"
@interface ViewController : UIViewController <WebViewScreenshotDelegate>

@property (retain, nonatomic) IBOutlet UIImageView *imageViewer;

@end
