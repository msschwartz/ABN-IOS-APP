//
//  WatchViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "WatchViewController.h"
#import "MediaPlayer/MediaPlayer.h"

@interface WatchViewController ()

@end

@implementation WatchViewController

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

- (IBAction)testButtonClick:(id)sender {
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"sample_video"
                                                          ofType:@"m4v"];
    
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL
                                                                      fileURLWithPath:videoPath]];
    
    [self presentMoviePlayerViewControllerAnimated:self.player];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
        interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

@end
