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

@interface ViewController : UIViewController<AVAudioPlayerDelegate>{
    
    AVAudioPlayer *audioPlayer;
    NSTimer *playTimer;
    double lowPassReslts;
    double lowPassReslts1;
    double lowPassReslts2;
    double lowPassReslts3;
    double sizeImagePassReslts;
    
}


@property (retain, nonatomic) IBOutlet UIProgressView *animBar;
@property (retain, nonatomic) IBOutlet UIProgressView *animbar1;
@property (retain, nonatomic) IBOutlet UIProgressView *animBar2;
@property (retain, nonatomic) IBOutlet UIProgressView *animBar3;
@property (retain, nonatomic) IBOutlet UISlider *volumeSlider;

@property (retain, nonatomic) IBOutlet UILabel *volLabel;

@property (retain, nonatomic) IBOutlet UILabel *result1Lbl;
@property (retain, nonatomic) IBOutlet UILabel *result2Lbl;
@property (retain, nonatomic) IBOutlet UILabel *result3Lbl;
@property (retain, nonatomic) IBOutlet UILabel *result4Lbl;

@property (retain, nonatomic) IBOutlet UIImageView *imageView;




- (IBAction)volumeAction:(id)sender;

- (void)playTimer:(NSTimer *)timer;

@end
