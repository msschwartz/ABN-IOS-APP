//
//  GetInvolvedViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "PayPalMobile.h"

@interface GetInvolvedViewController : UIViewController<PayPalPaymentDelegate, UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountButton;
@property (weak, nonatomic) IBOutlet UITextField *noteButton;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

- (IBAction)donateClick:(id)sender;

@end
