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
#import <GoogleCast/GoogleCast.h>

@interface WatchViewController : UIViewController <UITableViewDataSource,
                                                    UITableViewDelegate,
                                                    NSXMLParserDelegate,
                                                    UIActionSheetDelegate,
                                                    GCKDeviceScannerListener,
                                                    GCKDeviceManagerDelegate,
                                                    GCKMediaControlChannelDelegate>

@property (weak, nonatomic) IBOutlet UIButton *arabicButton;
@property (weak, nonatomic) IBOutlet UIButton *englishButton;
@property (weak, nonatomic) IBOutlet UIButton *worshipButton;
@property (weak, nonatomic) IBOutlet UIButton *surathButton;
@property (weak, nonatomic) IBOutlet UIButton *kurdushButton;
@property (weak, nonatomic) IBOutlet UIButton *alquddusButton;


@property (weak, nonatomic) IBOutlet UIButton *arabicAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *englishAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *worshipAudio;
@property (weak, nonatomic) IBOutlet UIButton *surathAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *kurdishAudioButton;
@property (weak, nonatomic) IBOutlet UIButton *alquddusAudioButton;

@property (strong, nonatomic) MPMoviePlayerViewController *player;
@property (strong, nonatomic) AVPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *arabicAudioPlayingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *englishAudioPlayingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *worshipAudioPlayingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *surathAudioPlayingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *kurdishAudioPlayingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *alquddusAudioPlayingIndicator;


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *arabicScheduleLoadingIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *englishScheduleLoadingIndicator;

@property (strong, nonatomic) UIImage * stopAudioImage;
@property (strong, nonatomic) UIImage * playAudioImage;

@property (strong, nonatomic) NSURL * arabicHlsUrl;
@property (strong, nonatomic) NSURL * englishHlsUrl;
@property (strong, nonatomic) NSURL * worshipHlsUrl;
@property (strong, nonatomic) NSURL * surathHlsUrl;
@property (strong, nonatomic) NSURL * kurdishHlsUrl;
@property (strong, nonatomic) NSURL * alquddusHlsUrl;

@property BOOL arabicAudioPlaying;
@property BOOL englishAudioPlaying;
@property BOOL worshipAudioPlaying;
@property BOOL surathAudioPlaying;
@property BOOL kurdishAudioPlaying;
@property BOOL alquddusAudioPlaying;

@property NSString * englishScheduleFeedUrlString;
@property NSString * arabicScheduleFeedUrlString;

@property (weak, nonatomic) IBOutlet UIButton *upcomingShowsEnglish;

@property (weak, nonatomic) IBOutlet UIButton *upcomingShowsArabic;

@property UIView * currentScheduleView;

@property NSMutableArray * upcomingShowsData;
@property UITableView * upcomingShowsTable;

@property GCKMediaControlChannel *mediaControlChannel;
@property GCKApplicationMetadata *applicationMetadata;
@property GCKDevice *selectedChromecast;
@property (nonatomic, strong) GCKDeviceScanner *deviceScanner;
@property (nonatomic, strong) IBOutlet UIButton *chromecastButton;
@property (nonatomic, strong) GCKDeviceManager *deviceManager;
@property (nonatomic, readonly) GCKMediaInformation *mediaInformation;

@end
