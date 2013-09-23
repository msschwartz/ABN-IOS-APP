//
//  YouTubeChannelViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "YouTubeChannelViewController.h"

@interface YouTubeChannelViewController ()

@end

@implementation YouTubeChannelViewController

- (void)viewDidLoad {
    
    NSString *fullURL = @"https://www.youtube.com/user/ABNSAT2";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:requestObj];
    [_webView setDelegate:self];
    
    [[self activitySpinner] setHidesWhenStopped:YES];
    
    [super viewDidLoad];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[self activitySpinner] stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (IBAction)backButtonClick:(id)sender {
    [_webView goBack];
}

- (IBAction)forwardButtonClick:(id)sender {
    [_webView goForward];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
