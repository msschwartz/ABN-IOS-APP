//
//  YouTubeChannelViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "YouTubeChannelViewController.h"
#import "QuartzCore/QuartzCore.h"

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

    channelsArray = [[NSMutableArray alloc] init];
    [channelsArray addObject:@"ABNSAT"];
    [channelsArray addObject:@"English Gospel"];
    [channelsArray addObject:@"Arabic Gospel"];
    [channelsArray addObject:@"Kurdish Gospel"];
    [channelsArray addObject:@"Arabs for Christ"];
    [channelsArray addObject:@"Jesus or Mohammed"];
    [channelsArray addObject:@"Jihad Exposed"];
    [channelsArray addObject:@"Arabs for Jesus"];

    urlsArray = [[NSMutableArray alloc] init];
    [urlsArray addObject:@"ABNSAT2"];
    [urlsArray addObject:@"englishgospel"];
    [urlsArray addObject:@"arabicgospel"];
    [urlsArray addObject:@"kurdishgospel"];
    [urlsArray addObject:@"arabsforchristabn"];
    [urlsArray addObject:@"JesusOrMuhammad"];
    [urlsArray addObject:@"JihadExpose"];
    [urlsArray addObject:@"arabsforjesus"];

    [[self.selectChannelButton layer] setBorderWidth:2.0f];
    [[self.selectChannelButton layer] setCornerRadius:5.0f];
    [[self.selectChannelButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.selectChannelButton layer] setBackgroundColor:[UIColor lightGrayColor].CGColor];
    
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

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [channelsArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [channelsArray objectAtIndex: row];
}

- (void)pickerView:(UIPickerView *)pv didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString * baseUrl = @"https://www.youtube.com/user/";
    NSString * path = [urlsArray objectAtIndex: row];
    NSString * url = [NSString stringWithFormat:@"%@%@", baseUrl, path];
    
    self.currentChannel = url;
    NSLog(@"Current channel: ");
    NSLog(url);
    
}

- (IBAction)selectChannelClick:(id)sender {
    
    if(self.channelPicker.hidden) {
        self.channelPicker.hidden = NO;
    } else {
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.currentChannel]];
        [_webView loadRequest:requestObj];
        self.channelPicker.hidden = YES;
    }
    
}

@end
