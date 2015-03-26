//
//  IPadViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/22/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "PayPalMobile.h"

@interface IPadViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *paypalView;

@property (weak, nonatomic) IBOutlet UIView *contactUsView;

@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

@property (weak, nonatomic) IBOutlet UIButton *youtubeButton;

@property (weak, nonatomic) IBOutlet UIButton *twitterButton;

@property (weak, nonatomic) IBOutlet UIButton *emailGeneralButton;

@property (weak, nonatomic) IBOutlet UIButton *emailMissionsButton;

@property (weak, nonatomic) IBOutlet UIButton *emailBassimButton;

@property (weak, nonatomic) IBOutlet UIButton *callUsButton;

@property (weak, nonatomic) IBOutlet UIButton *visitOurSiteButton;

@property (weak, nonatomic) IBOutlet UIButton *addressButton;

@property (weak, nonatomic) IBOutlet UILabel *votdLabel;

@property (weak, nonatomic) IBOutlet UIWebView *votdWebView;

@property (weak, nonatomic) IBOutlet UIButton *canadianDonorsButton;

@property (weak, nonatomic) IBOutlet UIButton *donateNowButton;

@end
