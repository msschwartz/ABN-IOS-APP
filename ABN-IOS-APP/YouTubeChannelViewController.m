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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *fullURL = @"https://www.youtube.com/user/ABNSAT2";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
