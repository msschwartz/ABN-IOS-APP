//
//  VotdViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/22/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "VotdViewController.h"

@interface VotdViewController ()

@end

@implementation VotdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadVotd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
            
            NSLog(@"%@", verse);
            
            NSString * html = [NSString stringWithFormat:@"<html> \n"
             "<head> \n"
             "<style type=\"text/css\"> \n"
             "body {font-family: \"%@\"; font-size: %@;}\n"
             "</style> \n"
             "</head> \n"
             "<body>%@<p>- %@</body> \n"
             "</html>", @"helvetica", [NSNumber numberWithInt:20], verse, reference];

            [[self votdWebView] loadHTMLString:html baseURL:NULL];

        }
    }
    
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
