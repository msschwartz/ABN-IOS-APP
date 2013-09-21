//
//  ContactUsViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/15/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITableViewCell *emailGeneralCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailMissionsCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailBassimCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *callCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *websiteCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mailCell;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end
