//
//  WatchViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "UIKit/UIKit.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVPlayer.h"

@interface WatchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UIButton *arabicButton;
@property (weak, nonatomic) IBOutlet UIButton *englishButton;

@property (weak, nonatomic) IBOutlet UIButton *arabicAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *englishAudioButton;

@property (strong, nonatomic) MPMoviePlayerViewController *player;
@property (strong, nonatomic) AVPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *arabicAudioPlayingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *englishAudioPlayingIndicator;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *arabicScheduleLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *englishScheduleLoadingIndicator;

@property (strong, nonatomic) UIImage * stopAudioImage;
@property (strong, nonatomic) UIImage * playAudioImage;

@property (strong, nonatomic) NSURL * arabicHlsUrl;
@property (strong, nonatomic) NSURL * englishHlsUrl;

@property BOOL arabicAudioPlaying;
@property BOOL englishAudioPlaying;

@property NSString * englishScheduleFeedUrlString;
@property NSString * arabicScheduleFeedUrlString;

@property (weak, nonatomic) IBOutlet UIButton *upcomingShowsEnglish;

@property (weak, nonatomic) IBOutlet UIButton *upcomingShowsArabic;

@property UIView * currentScheduleView;

@property NSMutableArray * upcomingShowsData;
@property UITableView * upcomingShowsTable;

@end
