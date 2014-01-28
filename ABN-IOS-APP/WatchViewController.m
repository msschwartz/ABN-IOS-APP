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

@implementation WatchViewController

- (void)viewDidLoad {
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.playAudioImage = [UIImage imageNamed:@"playAudioIPad.png"];
        self.stopAudioImage = [UIImage imageNamed:@"stopAudioIPad.png"];
    } else {
        self.playAudioImage = [UIImage imageNamed:@"playAudio.png"];
        self.stopAudioImage = [UIImage imageNamed:@"stopAudio.png"];
    }
    
    [self.arabicAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.englishAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.worshipAudio setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.surathAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];

    self.arabicHlsUrl = [NSURL URLWithString:@"http://abnarabic-live.hls.adaptive.level3.net/hls-live/abnarabic-live/_definst_/live.m3u8"];
    self.worshipHlsUrl = [NSURL URLWithString:@"http://abnworshipchannel-live.hls.adaptive.level3.net/hls-live/abnworshipchannel-live/_definst_/live.m3u8"];
    self.englishHlsUrl = [NSURL URLWithString:@"http://abnenglish-live.hls.adaptive.level3.net/hls-live/abnenglish-live/_definst_/live.m3u8"];
    self.surathHlsUrl = [NSURL URLWithString:@"http://live.surath.abnvideos.com/surath/live.m3u8"];
    
    NSString * scheduleFeedUrlTemplate = @"http://www.google.com/calendar/feeds/%@/public/full?alt=json&orderby=starttime&max-results=10&singleevents=true&sortorder=ascending&futureevents=true";
    
    self.englishScheduleFeedUrlString = [NSString stringWithFormat:scheduleFeedUrlTemplate, @"trinityabn@gmail.com"];
    self.arabicScheduleFeedUrlString = [NSString stringWithFormat:scheduleFeedUrlTemplate, @"1v9dhh74qeiuj9trbmihka9isc@group.calendar.google.com"];
    
    self.upcomingShowsData = [[NSMutableArray alloc] init];
    
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

- (IBAction)worshipButtonClick:(id)sender {
    
    [self stopAudioPlayer];
    
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:self.worshipHlsUrl];
    [self presentMoviePlayerViewControllerAnimated:self.player];
}

- (IBAction)surathButtonClick:(id)sender {
    [self stopAudioPlayer];
    
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:self.surathHlsUrl];
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

- (IBAction)worshipAudioButtonClick:(id)sender {
    
    if(self.worshipAudioPlaying) {
        [self stopAudioPlayer];
        return;
    }
    
    [self stopAudioPlayer];
    
    self.worshipButton.hidden = YES;
    self.worshipAudioPlayingIndicator.hidden = NO;
    
    [self.worshipAudio setBackgroundImage:self.stopAudioImage forState:UIControlStateNormal];
    
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
    
    [self.surathAudioButton setBackgroundImage:self.stopAudioImage forState:UIControlStateNormal];
    
    self.audioPlayer = [[AVPlayer alloc] initWithURL:self.surathHlsUrl];
    
    [self.audioPlayer play];
    
    self.surathAudioPlaying = YES;
}

-(void) stopAudioPlayer {
    self.audioPlayer = nil;
    
    self.arabicAudioPlaying = NO;
    self.englishAudioPlaying = NO;
    self.worshipAudioPlaying = NO;
    self.surathAudioPlaying = NO;
    
    self.arabicButton.hidden = NO;
    self.englishButton.hidden = NO;
    self.worshipButton.hidden = NO;
    self.surathButton.hidden = NO;

    self.englishAudioPlayingIndicator.hidden = YES;
    self.arabicAudioPlayingIndicator.hidden = YES;
    self.worshipAudioPlayingIndicator.hidden = YES;
    self.surathAudioPlayingIndicator.hidden = YES;

    [self.arabicAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.englishAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.worshipAudio setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    [self.surathAudioButton setBackgroundImage:self.playAudioImage forState:UIControlStateNormal];
    
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
    eventNameLabel.lineBreakMode = UILineBreakModeWordWrap;
    eventNameLabel.numberOfLines = 3;
    eventNameLabel.textColor = [UIColor darkGrayColor];
    eventNameLabel.backgroundColor = [UIColor whiteColor];
    eventNameLabel.font = [UIFont fontWithName:@"Arial Rounded MT" size:(15.0)];
    eventNameLabel.text =  [[NSString alloc] initWithFormat:@"%@", eventName];

    UILabel *eventDateTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageWidth + 5, (rowHeight / 2) + 10, screenWidth - imageWidth - 5, (rowHeight / 2) - 10)];
    eventDateTimeLabel.lineBreakMode = UILineBreakModeTailTruncation;
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

@end
