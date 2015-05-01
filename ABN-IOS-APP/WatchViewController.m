//
//  WatchViewController.m
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import "WatchViewController.h"
#import "DataTableViewController.h"
#import "MediaPlayer/MediaPlayer.h"
#import "AVFoundation/AVPlayer.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static NSString *kReceiverAppID = @"EF278A15";

@implementation WatchViewController

- (void)viewDidLoad {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.playAudioImage = [UIImage imageNamed:@"playAudioIPad.png"];
        self.stopAudioImage = [UIImage imageNamed:@"stopAudioIPad.png"];
    } else {
        self.playAudioImage = [UIImage imageNamed:@"playAudio.png"];
        self.stopAudioImage = [UIImage imageNamed:@"stopAudio.png"];
    }
    
    self.arabicHlsUrl = [NSURL URLWithString:@"http://rtmp-arabic.abnsat.com/live/arabic/playlist.m3u8"];
    self.worshipHlsUrl = [NSURL URLWithString:@"http://rtmp-worship.abnsat.com/live/worship/playlist.m3u8"];
    self.englishHlsUrl = [NSURL URLWithString:@"http://rtmp-trinity.abnsat.com/live/trinity/playlist.m3u8"];
    self.surathHlsUrl = [NSURL URLWithString:@"http://rtmp-surath.abnsat.com/live/surath/playlist.m3u8"];
    self.kurdishHlsUrl = [NSURL URLWithString:@"http://rtmp-kurdish.abnsat.com/live/kurdish/playlist.m3u8"];
    self.alquddusHlsUrl = [NSURL URLWithString:@"http://rtmp-alquddoos.abnsat.com/live/alquddoos/playlist.m3u8"];
    
    NSString * scheduleFeedUrlTemplate = @"http://www.google.com/calendar/feeds/%@/public/full?alt=json&orderby=starttime&max-results=10&singleevents=true&sortorder=ascending&futureevents=true";
    
    self.englishScheduleFeedUrlString = [NSString stringWithFormat:scheduleFeedUrlTemplate, @"trinityabn@gmail.com"];
    self.arabicScheduleFeedUrlString = [NSString stringWithFormat:scheduleFeedUrlTemplate, @"1v9dhh74qeiuj9trbmihka9isc@group.calendar.google.com"];
    
    self.upcomingShowsData = [[NSMutableArray alloc] init];
    
    self.deviceScanner = [[GCKDeviceScanner alloc] init];
    self.deviceScanner.passiveScan = YES;
    [self.deviceScanner addListener:self];
    [self.deviceScanner startScan];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL) prefersStatusBarHidden {
    return YES;
}

- (IBAction)arabicButtonClick:(id)sender {
    [self playVideoStream:self.arabicHlsUrl title:@"Arabic Stream"];
}
- (IBAction)englishButtonClick:(id)sender {
    [self playVideoStream:self.englishHlsUrl title:@"English Stream"];
}
- (IBAction)worshipButtonClick:(id)sender {
    [self playVideoStream:self.worshipHlsUrl title:@"Worship Stream"];
}
- (IBAction)surathButtonClick:(id)sender {
    [self playVideoStream:self.surathHlsUrl title:@"Surath Stream"];
}
- (IBAction)kurdishButtonClick:(id)sender {
    [self playVideoStream:self.kurdishHlsUrl title:@"Kurdish Stream"];
}
- (IBAction)alquddusButtonClick:(id)sender {
    [self playVideoStream:self.alquddusHlsUrl title:@"Al Quddoos Stream"];
}


- (void)playVideoStream:(NSURL *)hlsUrl title:(NSString *)title {
    [self stopAudioPlayer];
    if ([self isCasting]) {
        [self castVideo:hlsUrl title:title];
    }
    else {
        self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:hlsUrl];
        [self presentMoviePlayerViewControllerAnimated:self.player];
    }
}


- (void)movieFinishedCallback:(NSNotification *) notification {
    NSLog(@"movieFinishedCallback");
    [self stopAudioPlayer];
}


- (IBAction)arabicAudioButtonClick:(id)sender {

    if(self.arabicAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }

    [self stopAudioPlayer];

    self.arabicButton.hidden = YES;
    self.arabicAudioPlayingIndicator.hidden = NO;

    [self.arabicAudioButton setImage:self.stopAudioImage forState:UIControlStateNormal];

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
    
    [self.englishAudioButton setImage:self.stopAudioImage forState:UIControlStateNormal];

    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.englishHlsUrl];

    [self.audioPlayer play];
    
    self.englishAudioPlaying = YES;
}

- (IBAction)worshipAudioButtonClick:(id)sender {
    
    if(self.worshipAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }
    
    [self stopAudioPlayer];
    
    self.worshipButton.hidden = YES;
    self.worshipAudioPlayingIndicator.hidden = NO;
    
    [self.worshipAudio setImage:self.stopAudioImage forState:UIControlStateNormal];
    
    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.worshipHlsUrl];
    
    [self.audioPlayer play];
    
    self.worshipAudioPlaying = YES;
}

- (IBAction)surathAudioButtonClick:(id)sender {
    if(self.surathAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }
    
    [self stopAudioPlayer];
    
    self.surathButton.hidden = YES;
    self.surathAudioPlayingIndicator.hidden = NO;
    
    [self.surathAudioButton setImage:self.stopAudioImage forState:UIControlStateNormal];
    
    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.surathHlsUrl];
    
    [self.audioPlayer play];
    
    self.surathAudioPlaying = YES;
}

- (IBAction)kurdishAudioButtonClick:(id)sender {
    if(self.kurdishAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }
    
    [self stopAudioPlayer];
    
    self.kurdushButton.hidden = YES;
    self.kurdishAudioPlayingIndicator.hidden = NO;
    
    [self.kurdishAudioButton setImage:self.stopAudioImage forState:UIControlStateNormal];
    
    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.kurdishHlsUrl];
    
    [self.audioPlayer play];
    
    self.kurdishAudioPlaying = YES;
}

- (IBAction)alquddusAudioButtonClick:(id)sender {
    if(self.alquddusAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }
    
    [self stopAudioPlayer];
    
    self.alquddusButton.hidden = YES;
    self.alquddusAudioPlayingIndicator.hidden = NO;
    
    [self.alquddusAudioButton setImage:self.stopAudioImage forState:UIControlStateNormal];
    
    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.alquddusHlsUrl];
    
    [self.audioPlayer play];
    
    self.alquddusAudioPlaying = YES;
}

-(void) stopAudioPlayer {
    self.audioPlayer = nil;
    
    if (self.isCasting) {
        [self stopCastingVideo];
    }
    
    self.arabicAudioPlaying = NO;
    self.englishAudioPlaying = NO;
    self.worshipAudioPlaying = NO;
    self.surathAudioPlaying = NO;
    self.kurdishAudioPlaying = NO;
    self.alquddusAudioPlaying = NO;
    
    self.arabicButton.hidden = NO;
    self.englishButton.hidden = NO;
    self.worshipButton.hidden = NO;
    self.surathButton.hidden = NO;
    self.kurdushButton.hidden = NO;
    self.alquddusButton.hidden = NO;

    self.englishAudioPlayingIndicator.hidden = YES;
    self.arabicAudioPlayingIndicator.hidden = YES;
    self.worshipAudioPlayingIndicator.hidden = YES;
    self.surathAudioPlayingIndicator.hidden = YES;
    self.kurdishAudioPlayingIndicator.hidden = YES;
    self.alquddusAudioPlayingIndicator.hidden = YES;

    [self.arabicAudioButton setImage:self.playAudioImage forState:UIControlStateNormal];
    [self.englishAudioButton setImage:self.playAudioImage forState:UIControlStateNormal];
    [self.worshipAudio setImage:self.playAudioImage forState:UIControlStateNormal];
    [self.surathAudioButton setImage:self.playAudioImage forState:UIControlStateNormal];
    [self.kurdishAudioButton setImage:self.playAudioImage forState:UIControlStateNormal];
    [self.alquddusAudioButton setImage:self.playAudioImage forState:UIControlStateNormal];
    
}

#pragma mark -
#pragma mark "Upcoming shows" functions

- (void) resignSchedulesView:(UIBarButtonItem *)item {
    NSLog(@"Closing schedules view.");
    self.upcomingShowsData = [[NSMutableArray alloc] init];
    [self.currentScheduleView removeFromSuperview];
}

- (IBAction)upcomingShowsEnglishClick:(id)sender {
    
    UIView * view = [self buildViewForSchedule:self.englishScheduleFeedUrlString];
    
    if(view == nil) {
        NSLog(@"Error occurred while constructing view.");
        return;
    }
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0];
    [applicationLoadViewIn setType:kCATransitionMoveIn];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[view layer]addAnimation:applicationLoadViewIn forKey:kCATransitionMoveIn];
    
    [self.view addSubview:view];
}

- (IBAction)upcomingShowsArabicClick:(id)sender {

    UIView * view = [self buildViewForSchedule:self.arabicScheduleFeedUrlString];

    if(view == nil) {
        NSLog(@"Error occurred while constructing view.");
        return;
    }
    
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0];
    [applicationLoadViewIn setType:kCATransitionMoveIn];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[view layer]addAnimation:applicationLoadViewIn forKey:kCATransitionMoveIn];
    
    [self.view addSubview:view];
}

- (UIView *) buildViewForSchedule:(NSString *)feedUrl {
    
    UITableView * table = [self buildTableForSchedule:feedUrl];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 23)];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = UIColorFromRGB(0xe5e7eb);
    label.shadowOffset = CGSizeMake(0, 1);
    label.textColor = UIColorFromRGB(0x717880);
    label.text = @"Coming Up";
    label.font = [UIFont boldSystemFontOfSize:17.0];
    UIBarButtonItem *toolBarTitle = [[UIBarButtonItem alloc] initWithCustomView:label];
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                   style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(resignSchedulesView:)];
    
    NSArray *items = [[NSArray alloc] initWithObjects:button, toolBarTitle, nil];
    
    UIToolbar * toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, screenWidth, 40);
    [toolbar setItems:items];

    UIView *view = [[UIView alloc] initWithFrame: screenRect];
    
    [view addSubview:table];
    [view addSubview:toolbar];

    self.currentScheduleView = view;

    return view;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.upcomingShowsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"Cell";
    static int rowHeight = 90;
    static int imageWidth = 40;
    
    NSMutableDictionary * item = [self.upcomingShowsData objectAtIndex:indexPath.row];
    
    NSString * eventName = [item valueForKey:@"name"];
    NSString * eventDate = [item valueForKey:@"date"];
    NSString * eventStartTime = [item valueForKey:@"startTime"];
    NSString * eventEndTime = [item valueForKey:@"endTime"];
    NSString * timezone = [item valueForKey:@"timezone"];
    NSString * link = [item valueForKey:@"links"];
    
    NSLog(@"Rendering table cell for event name %@, %@ at %@ - %@ %@, %@", eventName, eventDate, eventStartTime, eventEndTime, timezone, link);
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.image=[UIImage imageNamed:@"calendar.png"];
    
    UIView * imageContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, rowHeight)];
    imageView.center = CGPointMake(imageWidth / 2, rowHeight / 2);
    [imageContainer addSubview:imageView];

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    
    UILabel *eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageWidth + 5, 0, screenWidth - imageWidth - 5, (rowHeight / 2) + 10)];
    [eventNameLabel setLineBreakMode:NSLineBreakByWordWrapping];
    eventNameLabel.numberOfLines = 3;
    eventNameLabel.textColor = [UIColor darkGrayColor];
    eventNameLabel.backgroundColor = [UIColor whiteColor];
    eventNameLabel.font = [UIFont fontWithName:@"Arial Rounded MT" size:(15.0)];
    eventNameLabel.text =  [[NSString alloc] initWithFormat:@"%@", eventName];

    UILabel *eventDateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageWidth + 5, (rowHeight / 2) + 10, screenWidth - imageWidth - 5, (rowHeight / 2) - 10)];
    [eventNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    eventDateTimeLabel.numberOfLines = 1;
    eventDateTimeLabel.textColor = [UIColor grayColor];
    eventDateTimeLabel.backgroundColor = [UIColor whiteColor];
    eventDateTimeLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    eventDateTimeLabel.text =  [[NSString alloc] initWithFormat:@"%@ %@ - %@", eventDate, eventStartTime, eventEndTime];

    [cell.contentView addSubview:eventNameLabel];
    [cell.contentView addSubview:eventDateTimeLabel];
    [cell.contentView addSubview:imageContainer];
    
    return cell;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    NSString * url = [[self.upcomingShowsData objectAtIndex:indexPath.row] valueForKey:@"link"];
    NSLog(@"Opening calendar URL %@", url);
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:url]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (NSDate *) parseDate:(NSString *) dateString {
    
    NSLog(@"Parsing date %@", dateString);
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"];
    
    NSString * cleanedUpDateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@"" options:0 range:NSMakeRange([dateString length] - 5, 5)];
    
    NSLog(@"Cleaned up date string: %@", cleanedUpDateString);
    
    return [dateFormatter dateFromString:cleanedUpDateString];
}

- (void) createDataArray:(NSDictionary *) json {
    NSDictionary * feed = [json objectForKey:@"feed"];
    NSArray * entries = [feed objectForKey:@"entry"];
    
    for (NSDictionary * entry in entries) {
        
        NSLog(@"Starting next entry...");
        
        NSString * title = [[entry objectForKey:@"title"] valueForKey:@"$t"];
        
        NSString * startDateString = [[entry objectForKey:@"gd$when"] valueForKey:@"startTime"][0];
        NSDate * startDate = [self parseDate:startDateString];

        NSString * endDateString = [[entry objectForKey:@"gd$when"] valueForKey:@"endTime"][0];
        NSDate * endDate = [self parseDate:endDateString];
        
        NSLog(@"Final, parsed dates: Start %@, End %@", startDate, endDate);
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM dd"];

        NSString * eventDate = [dateFormatter stringFromDate:startDate];

        NSDateFormatter * timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hh:mm a"];
        
        NSString * eventStartTime = [timeFormatter stringFromDate:startDate];
        NSString * eventEndTime = [timeFormatter stringFromDate:endDate];
        
        NSDateFormatter * timezoneFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"ZZZ"];
        
        NSString * timezone = [timezoneFormatter stringFromDate:startDate];
        
        NSArray * linkArray = [entry objectForKey:@"link"];
        NSString * link;
        
        for(NSDictionary * linkItem in linkArray) {
            
            if(![[linkItem objectForKey:@"type"] isEqual: @"text/html"]) {
                continue;
            }
            
            link = [linkItem objectForKey:@"href"];
            break;
        }
        
        NSLog(@"Adding item to data array: %@, %@, %@ - %@ %@, %@", title, eventDate, eventStartTime, eventEndTime, timezone, link);

        NSMutableDictionary * item = [[NSMutableDictionary alloc] init];
        [item setObject:title forKey:@"name"];
        [item setObject:eventDate forKey:@"date"];
        [item setObject:eventStartTime forKey:@"startTime"];
        [item setObject:eventEndTime forKey:@"endTime"];
        [item setObject:link forKey:@"link"];
        
        [self.upcomingShowsData addObject:item];
    }
    
}

- (UITableView *) buildTableForSchedule:(NSString *)feedUrl {
    
    NSURL *url = [[NSURL alloc]initWithString:feedUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    if(data != nil) {
        
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (error == nil) {
            NSLog(@"Result: %@", result);
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            [self createDataArray:json];
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
            return nil;
        }
    } else {
        NSLog(@"No data returned from %@!", feedUrl);
        return nil;
    }
    
    UITableView *table = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    
    table.dataSource = self;
    table.delegate = self;
    
    return table;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSInteger i = [sender tag];
    
    if(i != 10 && i != 11) {
        return;
    }
    
    DataTableViewController *vc = [segue destinationViewController];
    vc.sender = i;
    
}




#pragma mark Chromecast

- (IBAction)showChromecastPicker:(id)sender {
    if (self.selectedChromecast == nil) {
        // show error if no chromecasts found
        if (self.deviceScanner.devices.count < 1) {
            [self showError:@"No chromecasts available"];
            return;
        }
        
        // show picker
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Connect to Device"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil];
        
        for (GCKDevice *device in self.deviceScanner.devices) {
            [sheet addButtonWithTitle:device.friendlyName];
        }
        
        [sheet addButtonWithTitle:@"Cancel"];
        sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
        [sheet showInView:self.view];
    } else {
        // Gather stats from device.
        [self updateStatsFromDevice];
        
        NSString *friendlyName = [NSString stringWithFormat:@"Casting to %@", self.selectedChromecast.friendlyName];
        NSString *mediaTitle = [self.mediaInformation.metadata stringForKey:kGCKMetadataKeyTitle];
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:friendlyName
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:nil];
        if (mediaTitle != nil) {
            [sheet addButtonWithTitle:mediaTitle];
        }
        
        // Offer disconnect option
        [sheet addButtonWithTitle:@"Disconnect"];
        [sheet addButtonWithTitle:@"Cancel"];
        sheet.destructiveButtonIndex = sheet.numberOfButtons - 2;
        sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
        [sheet showInView:self.view];
    }
}

- (void)connectToDevice {
    if (self.selectedChromecast == nil)
        return;
    
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    self.deviceManager = [[GCKDeviceManager alloc] initWithDevice:self.selectedChromecast clientPackageName:[info objectForKey:@"CFBundleIdentifier"]];
    self.deviceManager.delegate = self;
    [self.deviceManager connect];
}

- (void)deviceDisconnected {
    self.mediaControlChannel = nil;
    self.deviceManager = nil;
    self.selectedChromecast = nil;
}

- (void)updateStatsFromDevice {
    if (self.mediaControlChannel && [self isCasting]) {
        _mediaInformation = self.mediaControlChannel.mediaStatus.mediaInformation;
    }
}

- (BOOL)isCasting {
    return (self.deviceManager && self.deviceManager.isConnected);
}

- (void)updateButtonStates {
    if ([self isCasting]) {
        //Show cast button in enabled state
        [self.chromecastButton setTintColor:[UIColor blueColor]];
    } else {
        //Show cast button in disabled state
        [self.chromecastButton setTintColor:[UIColor grayColor]];
        
    }
}

- (void)castVideo:(NSURL *)hlsUrl title:(NSString *)title {
    NSLog(@"Cast Video");
    
    //Show alert if not connected
    if (!self.deviceManager || !self.deviceManager.isConnected) {
        [self showError:@"Chromecast application is not connected properly"];
        return;
    }
    
    //Define Media metadata
    GCKMediaMetadata *metadata = [[GCKMediaMetadata alloc] init];
    [metadata setString:title forKey:kGCKMetadataKeyTitle];
    
    //define Media information
    GCKMediaInformation *mediaInformation =
    [[GCKMediaInformation alloc] initWithContentID:hlsUrl.absoluteString
                                        streamType:GCKMediaStreamTypeLive
                                       contentType:@"video/mp4"
                                          metadata:metadata
                                    streamDuration:0
                                        customData:nil];
    [_mediaControlChannel loadMedia:mediaInformation autoplay:TRUE playPosition:0];
}

- (void)stopCastingVideo {
    if (_mediaControlChannel != nil) {
        [_mediaControlChannel stop];
    }
}


#pragma mark - GCKDeviceScannerListener
- (void)deviceDidComeOnline:(GCKDevice *)device {
    NSLog(@"device found: %@", device.friendlyName);
}

- (void)deviceDidGoOffline:(GCKDevice *)device {
    NSLog(@"device lost: %@", device.friendlyName);
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.destructiveButtonIndex) {
        // disconnect button
        NSLog(@"Disconnecting device: %@", self.selectedChromecast.friendlyName);
        [self.deviceManager stopApplication];
        [self.deviceManager disconnect];
        [self deviceDisconnected];
    }
    else if (buttonIndex == actionSheet.cancelButtonIndex) {
        // nothing
    }
    else {
        // clicked a device or the current
        if (self.selectedChromecast == nil) {
            if (buttonIndex < self.deviceScanner.devices.count) {
                self.selectedChromecast = self.deviceScanner.devices[buttonIndex];
                NSLog(@"Selecting device: %@", self.selectedChromecast.friendlyName);
                [self connectToDevice];
            }
        }
    }
}

#pragma mark - GCKDeviceManagerDelegate

- (void)deviceManagerDidConnect:(GCKDeviceManager *)deviceManager {
    NSLog(@"connected!");
    [self.deviceManager launchApplication:kReceiverAppID relaunchIfRunning:YES];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager
didConnectToCastApplication:(GCKApplicationMetadata *)applicationMetadata
            sessionID:(NSString *)sessionID
  launchedApplication:(BOOL)launchedApplication {
    
    NSLog(@"application has launched");
    self.mediaControlChannel = [[GCKMediaControlChannel alloc] init];
    self.mediaControlChannel.delegate = self;
    [self.deviceManager addChannel:self.mediaControlChannel];
    [self.mediaControlChannel requestStatus];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager didFailToConnectToApplicationWithError:(NSError *)error {
    [self showError:error.description];
    [self deviceDisconnected];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager didFailToConnectWithError:(GCKError *)error {
    [self showError:error.description];
    [self deviceDisconnected];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager didDisconnectWithError:(GCKError *)error {
    NSLog(@"Received notification that device disconnected");
    
    if (error != nil) {
        [self showError:error.description];
    }
    
    [self deviceDisconnected];
}

- (void)deviceManager:(GCKDeviceManager *)deviceManager didReceiveStatusForApplication:(GCKApplicationMetadata *)applicationMetadata {
    self.applicationMetadata = applicationMetadata;
}


#pragma mark Helpers

- (void)showError:(NSString *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:error
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}


@end
