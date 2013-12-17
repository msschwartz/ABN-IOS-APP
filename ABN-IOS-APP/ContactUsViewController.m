//
//  ContactUsViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/15/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (void) openUrl: (NSString *) url {
    NSLog(@"%@", url);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:url]];
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (cell.tag) {
        case 100:
            [self openUrl:@"mailto:abn@abnsat.com"];
            break;
        case 101:
            [self openUrl:@"mailto:missions@abnsat.com"];
            break;
        case 102:
            [self openUrl:@"mailto:bassim@abnsat.com"];
            break;
        case 110:
            [self openUrl:@"tel:2484161300"];
            break;
        case 120:
            [self openUrl:@"http://www.abnsat.com"];
            break;
        case 130:
            [self openUrl:@"http://maps.google.com/maps?q=48390"];
            break;            
        default:
            break;
    }
}

@end
