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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (IBAction)arabicButtonClick:(id)sender {

    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://abnarabic-live.hls.adaptive.level3.net/hls-live/abnarabic-live/_definst_/live.m3u8"]];
    [self presentMoviePlayerViewControllerAnimated:self.player];
}

- (IBAction)englishButtonClick:(id)sender {
    
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://abnenglish-live.hls.adaptive.level3.net/hls-live/abnenglish-live/_definst_/live.m3u8"]];
    
    [self presentMoviePlayerViewControllerAnimated:self.player];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
        interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

@end
