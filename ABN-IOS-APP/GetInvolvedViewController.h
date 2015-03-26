//
//  GetInvolvedViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "PayPalMobile.h"

@interface GetInvolvedViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *canadianDonorButton;
@property (weak, nonatomic) IBOutlet UIImageView *canadianDonorFlag;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@end
