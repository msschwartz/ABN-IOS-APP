//
//  YouTubeChannelViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YouTubeChannelViewController : UIViewController<UIWebViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    NSMutableArray * channelsArray;
    NSMutableArray * urlsArray;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;

@property (weak, nonatomic) IBOutlet UIPickerView *channelPicker;

@property (weak, nonatomic) IBOutlet UIButton *selectChannelButton;

@property (nonatomic, retain) NSMutableArray * channelsArray;
@property (nonatomic, retain) NSMutableArray * urlsArray;

- (IBAction)backButtonClick:(id)sender;

- (IBAction)forwardButtonClick:(id)sender;

@end
