//
//  DetailViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 11/5/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property NSDictionary * data;

@end
