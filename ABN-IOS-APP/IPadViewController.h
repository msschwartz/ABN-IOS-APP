//
//  IPadViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/22/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "PayPalMobile.h"

@interface IPadViewController : UIViewController<PayPalPaymentDelegate, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *paypalView;

@property (weak, nonatomic) IBOutlet UIView *contactUsView;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

@property (weak, nonatomic) IBOutlet UITextField *noteTextField;

@property (weak, nonatomic) IBOutlet UIButton *donateButton;

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

@end
