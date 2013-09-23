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

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    // choose whatever width you need instead of 600
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 23)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = UIColorFromRGB(0xe5e7eb);
    label.shadowOffset = CGSizeMake(0, 1);
    label.textColor = UIColorFromRGB(0x717880);
    label.text = @"Verse of the Day";
    label.font = [UIFont boldSystemFontOfSize:20.0];
    UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
    
    NSArray *items = [[NSArray alloc] initWithObjects:self.doneButton, toolBarTitle, nil];
    
    [[self toolbar] setItems:items];

    [super viewDidLoad];
    [self loadVotd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
            
            [[self votdLabel] setText: [NSString stringWithFormat: @"%@\n\n- %@", verse, reference]];
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
