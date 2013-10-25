//
//  WatchViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "WatchViewController.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVPlayer.h"

@interface WatchViewController ()

@end

@implementation WatchViewController

- (void)viewDidLoad {
    
    self.playAudioImage = [UIImage imageNamed:@"playAudio.png"];
    self.stopAudioImage = [UIImage imageNamed:@"stopAudio.png"];
    
    self.arabicHlsUrl = [NSURL URLWithString:@"http://abnarabic-live.hls.adaptive.level3.net/hls-live/abnarabic-live/_definst_/live.m3u8"];
    self.englishHlsUrl = [NSURL URLWithString:@"http://abnenglish-live.hls.adaptive.level3.net/hls-live/abnenglish-live/_definst_/live.m3u8"];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (IBAction)arabicButtonClick:(id)sender {

    [self stopAudioPlayer];

    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:self.arabicHlsUrl];
    [self presentMoviePlayerViewControllerAnimated:self.player];
}

- (IBAction)englishButtonClick:(id)sender {

    [self stopAudioPlayer];

    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:self.englishHlsUrl];
    [self presentMoviePlayerViewControllerAnimated:self.player];
}

- (IBAction)arabicAudioButtonClick:(id)sender {

    if(self.arabicAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }

    [self stopAudioPlayer];

    self.arabicButton.hidden = YES;
    self.arabicAudioPlayingIndicator.hidden = NO;

    [self.arabicAudioButton setBackgroundImage:self.stopAudioImage forState:UIControlStateNormal];

    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.arabicHlsUrl];
    
    [self.audioPlayer play];
    
    self.arabicAudioPlaying = YES;
}

- (IBAction)englishAudioButtonClick:(id)sender {

    if(self.englishAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }
    
    [self stopAudioPlayer];

    self.englishButton.hidden = YES;
    self.englishAudioPlayingIndicator.hidden = NO;
    
    [self.englishAudioButton setBackgroundImage:self.stopAudioImage forState:UIControlStateNormal];

    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.englishHlsUrl];

    [self.audioPlayer play];
    
    self.englishAudioPlaying = YES;
}

-(void) stopAudioPlayer {
    self.audioPlayer = nil;
    
    self.arabicAudioPlaying = NO;
    self.englishAudioPlaying = NO;
    
    self.arabicButton.hidden = NO;
    self.englishButton.hidden = NO;

    self.englishAudioPlayingIndicator.hidden = YES;
    self.arabicAudioPlayingIndicator.hidden = YES;

    [self.arabicAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.englishAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight ||
        interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

@end
