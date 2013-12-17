//
//  DetailViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 11/5/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [self buildView];
    
    [super viewDidLoad];
}

- (void) buildView {
    
    NSString * title = [self.data valueForKey:@"title"];
    NSString * description = [self.data valueForKey:@"longDesc"];
    NSString * imageUrl = [self.data valueForKey:@"largeImageUrl"];
    
    self.navigationItem.title = title;
    self.descriptionTextView.text = description;
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    
    CALayer * l = [self.imageView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

@end
