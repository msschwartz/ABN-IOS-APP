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

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (IBAction)canadianDonorsClicked:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Canadian Donors" message: @"Make checks out to \"GNTCA\"\nABN Inc.\nP.O Box 34085\n446 Holland Trail\nAurora ON, L4G 7T6 Canada" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
}

- (IBAction)donateButtonClicked:(id)sender {
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"http://www.abnsat.com/#!donate/c2t8"]];
}

@end
