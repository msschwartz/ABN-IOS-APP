//
//  DataTableViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 11/5/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "DataTableViewController.h"
#import "DetailViewController.h"

@interface DataTableViewController ()

@end

@implementation DataTableViewController

- (void)viewDidLoad {
    
    [self loadData];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void) loadData {
    
    NSString * jsonUrlStr;
    
    if(self.sender == 10) {
        self.navigationItem.title = @"Our Programs";
        jsonUrlStr = @"http://www.abnsat.com/data/programs.json";
    } else if(self.sender == 11) {
        self.navigationItem.title = @"Our Hosts";
        jsonUrlStr = @"http://www.abnsat.com/data/hosts.json";
    }

    NSURL *url = [[NSURL alloc]initWithString:jsonUrlStr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if(data != nil) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (error == nil) {
            NSLog(@"Result: %@", result);
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            self.tableData = [json objectForKey:@"data"];
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    } else {
        NSLog(@"No data returned from %@!", url);
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
  
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"Cell";
    static int rowHeight = 90;
    static int imageWidth = 45;
    
    NSMutableDictionary * item = [self.tableData objectAtIndex:indexPath.row];
    
    NSString * title = [item valueForKey:@"title"];
    NSString * shortDesc = [item valueForKey:@"shortDesc"];
    NSString * smallImageUrl = [item valueForKey:@"smallImageUrl"];
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, 40, 40)];
    imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:smallImageUrl]]];
    
    UIView * imageContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, rowHeight)];
    imageView.center = CGPointMake(imageWidth / 2, rowHeight / 2);
    [imageContainer addSubview:imageView];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageWidth + 5, 0, screenWidth - imageWidth - 5, rowHeight / 3)];
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.numberOfLines = 1;
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Arial Rounded MT" size:(15.0)];
    titleLabel.text =  title;
    
    UILabel *shortDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageWidth + 5, 25, screenWidth - imageWidth - 5, rowHeight - 25)];
    shortDescLabel.lineBreakMode = UILineBreakModeTailTruncation;
    shortDescLabel.numberOfLines = 3;
    shortDescLabel.textColor = [UIColor grayColor];
    shortDescLabel.backgroundColor = [UIColor whiteColor];
    shortDescLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    shortDescLabel.text =  shortDesc;
    
    [cell.contentView addSubview:titleLabel];
    [cell.contentView addSubview:shortDescLabel];
    [cell.contentView addSubview:imageContainer];
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailSegue" sender:[self.tableData objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DetailViewController *vc = [segue destinationViewController];
    vc.data = sender;
    
}

@end
