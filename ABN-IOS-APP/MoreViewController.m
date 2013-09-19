//
//  MoreViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (void) openUrl: (NSString *) url {
    NSLog(url);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:url]];
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (cell.tag) {
        case 100:
            [self openUrl:@"https://www.facebook.com/pages/ABNSAT/112926788749272"];
            break;
        case 101:
            [self openUrl:@"http://www.twitter.com/abnsat"];
            break;
        case 102:
            [self openUrl:@"http://www.youtube.com/user/ABNSAT2"];
            break;
        case 103:
            // Meet the founders
            //UIViewController *viewController = [[UIViewController alloc] init];
            //[self presentViewController:viewController animated:YES completion:nil];
            break;
        case 104:
            // Statement of Faith
            break;
        case 105:
            // Our Vision
            break;
        default:
            break;
    }
}

@end
