//
//  ViewController.h
//  VizAud
//
//  Created by Shrutesh on 14/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "F3BarGauge.h"




@interface ViewController : UIViewController <AVAudioPlayerDelegate>{
    
    AVAudioPlayer *audioPlayer;
    NSTimer *playTimer;
    double lowPassReslts;
    double lowPassReslts1;
    double lowPassReslts2;
    double lowPassReslts3;
    double sizeImagePassReslts;
    
}

@property (retain, nonatomic) IBOutlet UILabel *remTime;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;


@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar2;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar3;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar4;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar5;
@property (retain, nonatomic) IBOutlet F3BarGauge *customRangeBar6;



@property (retain, nonatomic) IBOutlet UISlider *skipAudio;

- (IBAction)skipAudioActn:(id)sender;
- (void)playTimer:(NSTimer *)timer;

@end
