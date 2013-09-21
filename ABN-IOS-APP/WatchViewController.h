//
//  WatchViewController.h
//  ABN-IOS-APP
//
//  Created by Gorial, Sam on 9/12/13.
//  Copyright (c) 2013 Gorial, Sam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"

@interface WatchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (strong, nonatomic) MPMoviePlayerViewController *player;

@end
