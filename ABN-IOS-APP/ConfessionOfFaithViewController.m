//
//  ConfessionOfFaithViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/16/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "ConfessionOfFaithViewController.h"

@interface ConfessionOfFaithViewController ()

@end

@implementation ConfessionOfFaithViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)doneButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

@end
