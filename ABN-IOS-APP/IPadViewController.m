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
    
    self.contactUsView.layer.cornerRadius = 10;
    self.contactUsView.layer.masksToBounds = YES;
    
    [self loadVotd];
}

- (void) openUrl: (NSString *) url {
    NSLog(@"%@", url);
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
            
            NSMutableString *verse = [votd objectForKey:@"content"];
            NSString *reference = [votd objectForKey:@"display_ref"];

            NSLog(@"%@", verse);
            
            [[self votdWebView] loadHTMLString: [NSString stringWithFormat: @"%@<p>- %@", verse, reference] baseURL:NULL];
        }
    }
    
}
- (IBAction)canadianDonorsButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Canadian Donors" message: @"Make checks out to \"GNTCA\"\nABN Inc.\nP.O Box 34085\n446 Holland Trail\nAurora ON, L4G 7T6 Canada" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)donateNowClick:(id)sender {
    [self openUrl:@"http://www.abnsat.com/#!donate/c2t8"];
}

@end
