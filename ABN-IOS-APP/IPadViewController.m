//
//  IPadViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/22/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "IPadViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface IPadViewController ()

@end

@implementation IPadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.paypalView.layer.cornerRadius = 10;
    self.paypalView.layer.masksToBounds = YES;

    self.contactUsView.layer.cornerRadius = 10;
    self.contactUsView.layer.masksToBounds = YES;

    [[self noteTextField] setReturnKeyType:UIReturnKeyDone];
    [[self noteTextField] resignFirstResponder];
    [[self noteTextField] setDelegate:self];
    
    [self loadVotd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
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

- (void) invalidAmount {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please verify your information is correct." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

- (void) doDonate {
    
    NSString * amount = self.amountTextField.text;
    NSString * note = self.noteTextField.text;
    
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    if([formatter numberFromString:amount] == nil) {
        [self invalidAmount];
        return;
    }
    
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
        [self invalidAmount];
        return;
    }
    
    // Start out working with the test environment! When you are ready, remove this line to switch to live.
    //[PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    // Provide a payerId that uniquely identifies a user within the scope of your system,
    // such as an email address or user ID.
    NSString *aPayerId = @"noreply@abnsat.com";
    
    // Create a PayPalPaymentViewController with the credentials and payerId, the PayPalPayment
    // from the previous step, and a PayPalPaymentDelegate to handle the results.
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"AQ7jBBAgVgpeHyrvnXcb8DJ0kiDWQt0D75lXaPPOb4i7673Gb_Xdc7eMZha7"
                                                                    receiverEmail:@"accountant@abnsat.com"
                                                                          payerId:aPayerId
                                                                          payment:payment
                                                                         delegate:self];
    
    // Present the PayPalPaymentViewController.
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
}

- (IBAction)donateButtonClick:(id)sender {
    [self doDonate];
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

- (void) openUrl: (NSString *) url {
    NSLog(url);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:url]];
}

- (IBAction)facebookButtonClick:(id)sender {
    [self openUrl:@"https://www.facebook.com/pages/ABNSAT/112926788749272"];
}

- (IBAction)youtubeButtonClick:(id)sender {
    [self openUrl:@"http://www.youtube.com/user/ABNSAT2"];
}

- (IBAction)twitterButtonClick:(id)sender {
    [self openUrl:@"http://www.twitter.com/abnsat"];
}

- (IBAction)emailGeneralButtonClick:(id)sender {
    [self openUrl:@"mailto:abn@abnsat.com"];
}

- (IBAction)emailMissionsButtonClick:(id)sender {
    [self openUrl:@"mailto:missions@abnsat.com"];
}

- (IBAction)emailBassimButtonClick:(id)sender {
    [self openUrl:@"mailto:bassim@abnsat.com"];
}

- (IBAction)callUsButtonClick:(id)sender {
    [self openUrl:@"tel:2484161300"];
}

- (IBAction)visitSiteButtonClick:(id)sender {
    [self openUrl:@"http://www.abnsat.com"];
}

- (IBAction)addressButtonClick:(id)sender {
    [self openUrl:@"http://maps.google.com/maps?q=48390"];
}

- (void) loadVotd {
    
    NSURL *url = [NSURL URLWithString:@"http://www.biblegateway.com/votd/get/?format=json&version=31"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    
    if(jsonData != nil) {

        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error == nil) {
            NSLog(@"%@", result);
        
            NSDictionary *res = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
            
            NSDictionary *votd = [res objectForKey:@"votd"];
            
            NSString *verse = [votd objectForKey:@"content"];
            NSString *reference = [votd objectForKey:@"display_ref"];
            
            NSLog(verse);
            
            [[self votdLabel] setText: [NSString stringWithFormat: @"%@\n- %@", verse, reference]];
        }
    }
    
}

@end
