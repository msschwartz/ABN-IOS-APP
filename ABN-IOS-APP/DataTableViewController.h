//
//  DataTableViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 11/5/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property NSInteger sender;
@property NSMutableArray * tableData;

@end
