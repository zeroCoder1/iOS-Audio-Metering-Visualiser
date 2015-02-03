//
//  ViewController.m
//  VizAud
//
//  Created by Shrutesh on 14/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define DegreesToRadians(x) ((x) * M_PI / 180.0)
#define PI 3.14159

@interface ViewController ()

@end

@implementation ViewController


@synthesize remTime;


@synthesize imageView;
@synthesize customRangeBar;
@synthesize customRangeBar2;
@synthesize customRangeBar3;
@synthesize customRangeBar4;
@synthesize customRangeBar5;
@synthesize customRangeBar6;
@synthesize skipAudio;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"YOUR_AUDIO_FILE" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:soundPath];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    
    customRangeBar.numBars = 40;
    customRangeBar.minLimit = 0.05;
    customRangeBar.maxLimit = 1.00;
    customRangeBar.holdPeak = NO;
    customRangeBar.litEffect = NO;
    // UIColor *clrBar = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]; //if u want to make it 
    customRangeBar.normalBarColor = [UIColor greenColor];
    customRangeBar.warningBarColor = [UIColor yellowColor];;
    customRangeBar.dangerBarColor = [UIColor redColor];;
    customRangeBar.backgroundColor = [UIColor blackColor];
    customRangeBar.outerBorderColor = [UIColor clearColor];
    customRangeBar.innerBorderColor = [UIColor clearColor];
    
    
    
    
    customRangeBar2.numBars = 40;
    customRangeBar2.minLimit = 0.05;
    customRangeBar2.maxLimit = 1.00;
    customRangeBar2.holdPeak = NO;
    customRangeBar2.litEffect = NO;
    customRangeBar2.normalBarColor = [UIColor greenColor];
    customRangeBar2.warningBarColor = [UIColor yellowColor];;
    customRangeBar2.dangerBarColor = [UIColor redColor];;
    customRangeBar2.backgroundColor = [UIColor blackColor];
    customRangeBar2.outerBorderColor = [UIColor clearColor];
    customRangeBar2.innerBorderColor = [UIColor clearColor];
    
    
    customRangeBar3.numBars = 40;
    customRangeBar3.minLimit = 0.05;
    customRangeBar3.maxLimit = 1.00;
    customRangeBar3.holdPeak = NO;
    customRangeBar3.litEffect = NO;
    customRangeBar3.normalBarColor = [UIColor greenColor];
    customRangeBar3.warningBarColor = [UIColor yellowColor];;
    customRangeBar3.dangerBarColor = [UIColor redColor];;
    customRangeBar3.backgroundColor = [UIColor blackColor];
    customRangeBar3.outerBorderColor = [UIColor clearColor];
    customRangeBar3.innerBorderColor = [UIColor clearColor];
    
    customRangeBar4.numBars = 40;
    customRangeBar4.minLimit = 0.05;
    customRangeBar4.maxLimit = 1.00;
    customRangeBar4.holdPeak = NO;
    customRangeBar4.litEffect = NO;
    customRangeBar4.normalBarColor = [UIColor greenColor];
    customRangeBar4.warningBarColor = [UIColor yellowColor];;
    customRangeBar4.dangerBarColor = [UIColor redColor];;
    customRangeBar4.backgroundColor = [UIColor blackColor];
    customRangeBar4.outerBorderColor = [UIColor clearColor];
    customRangeBar4.innerBorderColor = [UIColor clearColor];
    
    customRangeBar5.numBars = 40;
    customRangeBar5.minLimit = 0.05;
    customRangeBar5.maxLimit = 1.00;
    customRangeBar5.holdPeak = NO;
    customRangeBar5.litEffect = NO;
    customRangeBar5.normalBarColor = [UIColor greenColor];
    customRangeBar5.warningBarColor = [UIColor yellowColor];;
    customRangeBar5.dangerBarColor = [UIColor redColor];;
    customRangeBar5.backgroundColor = [UIColor blackColor];
    customRangeBar5.outerBorderColor = [UIColor clearColor];
    customRangeBar5.innerBorderColor = [UIColor clearColor];
    
    customRangeBar6.numBars = 40;
    customRangeBar6.minLimit = 0.05;
    customRangeBar6.maxLimit = 1.00;
    customRangeBar6.holdPeak = NO;
    customRangeBar6.litEffect = NO;
    customRangeBar6.normalBarColor = [UIColor greenColor];
    customRangeBar6.warningBarColor = [UIColor yellowColor];;
    customRangeBar6.dangerBarColor = [UIColor redColor];;
    customRangeBar6.backgroundColor = [UIColor blackColor];
    customRangeBar6.outerBorderColor = [UIColor clearColor];
    customRangeBar6.innerBorderColor = [UIColor clearColor];

    
    
    
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", 
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        audioPlayer.meteringEnabled = YES;
        [audioPlayer play];
        playTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(playTimer:) userInfo:nil repeats:YES];
        
    }
    
    //audioPlayer.volume = 2;  
    skipAudio.minimumValue = 0;
    skipAudio.maximumValue = audioPlayer.duration;
    
    


}




- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [audioPlayer play];
}




- (void)playTimer:(NSTimer *)timer{
    
    [audioPlayer updateMeters];
    
    const double ALPHA = 1.05;
    const double ALPHA2 = 1.50;
    const double ALPHA3 = 0.05;
    
	double averagePowerForChannel = pow(10, (0.05 * [audioPlayer averagePowerForChannel:0]));
	lowPassReslts = ALPHA * averagePowerForChannel + (1.0 - ALPHA) * lowPassReslts;
	
    double averagePowerForChannel1 = pow(10, (0.05 * [audioPlayer averagePowerForChannel:1]));
	lowPassReslts1 = ALPHA * averagePowerForChannel1 + (1.0 - ALPHA) * lowPassReslts1;
	
    double peakPowerForChannel = pow(10, (0.05 * [audioPlayer peakPowerForChannel:0]));
	lowPassReslts2 = ALPHA2 * peakPowerForChannel + (1.0 - ALPHA2) * lowPassReslts2;
    
    double peakPowerForChannel1 = pow(10, (0.05 * [audioPlayer peakPowerForChannel:1]));
	lowPassReslts3 = ALPHA2 * peakPowerForChannel1 + (1.0 - ALPHA2) * lowPassReslts3;
    
    double sizeImage = pow(10, (0.05 * [audioPlayer averagePowerForChannel:1]));
	sizeImagePassReslts = ALPHA3 * sizeImage + (1.0 - ALPHA3) * sizeImagePassReslts;
    
    
	//if (lowPassReslts < 1.95)
    //	NSLog(@"Should animate here But HOW?? %f",lowPassReslts);
    
    
    customRangeBar.value = lowPassReslts2;
    customRangeBar2.value = lowPassReslts3;
    customRangeBar3.value = lowPassReslts;
    customRangeBar4.value = lowPassReslts;
    customRangeBar5.value = lowPassReslts3;
    customRangeBar6.value = lowPassReslts2;
    
   

    
    [imageView setFrame:CGRectMake(82, 20, 150, 150)];
    [imageView setTransform:CGAffineTransformMakeScale(sizeImagePassReslts, sizeImagePassReslts)];
    
    
    skipAudio.value = audioPlayer.currentTime; //for the skipper
    


    





    
    float minutes = floor(audioPlayer.currentTime/60);
    float seconds = audioPlayer.currentTime - (minutes * 60);
    
    float duration_minutes = floor(audioPlayer.duration/60);
    float duration_seconds = audioPlayer.duration - (duration_minutes * 60);
    
    NSString *timeInf = [[NSString alloc] initWithFormat:@"%0.00f:%0.00f / %0.00f:%0.00f",minutes, seconds, duration_minutes, duration_seconds];
    remTime.text = timeInf;
    
    
  

    
    
}

- (IBAction)skipAudioActn:(id)sender {
    
    skipAudio.value = audioPlayer.currentTime ++;
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}







@end
