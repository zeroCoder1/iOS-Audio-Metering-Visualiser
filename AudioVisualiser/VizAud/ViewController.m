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



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"high" ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:soundPath];
    
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    
    
    if (error)
    {
        NSLog(@"Error in audioPlayer: %@", 
              [error localizedDescription]);
    } else {
        audioPlayer.delegate = self;
        [audioPlayer prepareToPlay];
        audioPlayer.meteringEnabled = YES;
        [audioPlayer play];
        //playTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(playTimer:) userInfo:nil repeats:YES];
        
        playTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(playTimer:)];
        [playTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

        
    }
    
    //audioPlayer.volume = 2;  
    _skipAudio.minimumValue = 0;
    _skipAudio.maximumValue = audioPlayer.duration;
    


    _progressView = [[SSProgressView alloc]initWithFrame:CGRectMake(5, 150,300, 300)];
    _progressView.percent = 0;
    _progressView.color=[UIColor whiteColor];
    [self.view addSubview:_progressView];
}





- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [audioPlayer play];
}




- (void)playTimer:(CADisplayLink *)timer{
    
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
    
    

    _progressView.percent = lowPassReslts*10;
    _progressView.textContent = [NSString stringWithFormat:@"%f", _progressView.percent];

    [_progressView setNeedsDisplay];


    
    [_imageView setFrame:CGRectMake(82, 20, 150, 150)];
    [_imageView setTransform:CGAffineTransformMakeScale(sizeImagePassReslts, sizeImagePassReslts)];
    
    
    _skipAudio.value = audioPlayer.currentTime; //for the skipper
    

    
    





    
    float minutes = floor(audioPlayer.currentTime/60);
    float seconds = audioPlayer.currentTime - (minutes * 60);
    
    float duration_minutes = floor(audioPlayer.duration/60);
    float duration_seconds = audioPlayer.duration - (duration_minutes * 60);
    
    NSString *timeInf = [[NSString alloc] initWithFormat:@"%0.00f:%0.00f / %0.00f:%0.00f",minutes, seconds, duration_minutes, duration_seconds];
    remTime.text = timeInf;
    
    
  

    
    
}

- (IBAction)skipAudioActn:(id)sender {
    
    _skipAudio.value = audioPlayer.currentTime ++;
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}







@end
