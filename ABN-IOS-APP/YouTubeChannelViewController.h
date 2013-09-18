//
//  YouTubeChannelViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouTubeChannelViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
- (IBAction)backButtonClick:(id)sender;
- (IBAction)forwardButtonClick:(id)sender;

@end
