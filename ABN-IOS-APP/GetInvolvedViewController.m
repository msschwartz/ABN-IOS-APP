//
//  GetInvolvedViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "GetInvolvedViewController.h"

@interface GetInvolvedViewController ()

@end

@implementation GetInvolvedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.noteButton resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (int) numberOfColumnsInPickerView:(UIPickerView*)picker {
    return 1;
}

- (int) pickerView:(UIPickerView*)picker numberOfRowsInColumn:(int)col {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row {

    if(row == 1) {
        return @"$ (USD)";
    } else if(row == 2) {
        return @"$ (CAD)";
    } else if(row == 3) {
        return @"£ (GBP)";
    }
    
    return NULL;

}

- (UIPickerView *) pickerView:(UIPickerView *)picker tableCellForRow:(int)row inColumn:(int)col {

    if(row == 1) {
        return NULL;
    } else if(row == 2) {
        return NULL;
    }
    
    return NULL;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    // Any additional checks to ensure you have the correct textField here.
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = -100;
    [self.view setFrame:frame];
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35f];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    [self.view setFrame:frame];
    [UIView commitAnimations];
    return YES;
}

- (IBAction)donateClick:(id)sender {

    // TODO(sgorial): change the names to ***TextField
    NSString * amount = self.amountButton.text;
    NSString * note = self.noteButton.text;
    
    if(note == NULL || note.length == 0) {
        note = @"Monetary donation to ABN.";
    }
    
    // Create a PayPalPayment
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:amount];
    payment.currencyCode = @"USD";
    payment.shortDescription = note;
    
    // Check whether payment is processable.
    if (!payment.processable) {
        // If, for example, the amount was negative or the shortDescription was empty, then
        // this payment would not be processable. You would want to handle that here.
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please verify your information is correct." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
    
    // Start out working with the test environment! When you are ready, remove this line to switch to live.
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    // Provide a payerId that uniquely identifies a user within the scope of your system,
    // such as an email address or user ID.
    NSString *aPayerId = @"noreply@abnsat.com";
    
    // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
    // from the previous step, and a PayPalPaymentDelegate to handle the results.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"YOUR_CLIENT_ID"
                                                                        receiverEmail:@"ssgorial@gmail.com"
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                        delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
}

#pragma mark - PayPalPaymentDelegate methods

- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    // Payment was processed successfully; send to server for verification and fulfillment.
    //[self verifyCompletedPayment:completedPayment];

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Thank You" message:@"Your donation was accepted!  Thank you and God bless you!" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
    // Dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel {
    // The payment was canceled; dismiss the PayPalPaymentViewController.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
