//
//  ViewController.m
//  VizAud
//
//  Created by Shrutesh on 14/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize animBar;
@synthesize animbar1;
@synthesize animBar2;
@synthesize animBar3;
@synthesize volumeSlider;
@synthesize volLabel;
@synthesize result1Lbl;
@synthesize result2Lbl;
@synthesize result3Lbl;
@synthesize result4Lbl;
@synthesize imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"YOUR_SONG" ofType:@"MP3"]];
    
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
        playTimer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(playTimer:) userInfo:nil repeats:YES];
        
    }
    
    audioPlayer.volume = 2;
    volumeSlider.value = 2;
  

}

- (void)viewDidUnload
{
   // [self setAnimLabel:nil];
    [self setAnimBar:nil];
    [self setAnimbar1:nil];
    [self setAnimBar2:nil];
    [self setAnimBar3:nil];
    [self setVolumeSlider:nil];
    [self setVolLabel:nil];
    [self setResult1Lbl:nil];
    [self setResult2Lbl:nil];
    [self setResult3Lbl:nil];
    [self setResult4Lbl:nil];
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [audioPlayer play];
}

- (IBAction)volumeAction:(id)sender {
    
    audioPlayer.volume = volumeSlider.value;
    
    if (audioPlayer.volume == 0) {
        [volLabel setText:@"Muted"];
    }
    else if (audioPlayer.volume == 4) {
        [volLabel setText:@"Maxed"];
    }
    else {
        [volLabel setText:@"Volume"];
    }
    
}

- (void)playTimer:(NSTimer *)timer{
    [audioPlayer updateMeters];
    
    const double ALPHA = 1.05;
    const double ALPHA2 = 1.50;
     const double ALPHA3 = 0.01;
    
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
    

        
    animBar.progress = lowPassReslts;
    animbar1.progress = lowPassReslts1;
    animBar2.progress = lowPassReslts2;
    animBar3.progress = lowPassReslts3;
    
    [imageView setFrame:CGRectMake(82, 20, 150, 150)];


    [imageView setTransform:CGAffineTransformMakeScale(sizeImagePassReslts, sizeImagePassReslts)];

    

    [result1Lbl setText:[NSString stringWithFormat:@"%f",lowPassReslts]];
    [result2Lbl setText:[NSString stringWithFormat:@"%f",lowPassReslts1]];
    [result3Lbl setText:[NSString stringWithFormat:@"%f",lowPassReslts2]];
    [result4Lbl setText:[NSString stringWithFormat:@"%f",lowPassReslts3]];


}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)dealloc {
	[playTimer release];
	[audioPlayer release];
    [animBar release];
    [animbar1 release];
    [animBar2 release];
    [animBar3 release];
    [volumeSlider release];
    [volLabel release];
    [result1Lbl release];
    [result2Lbl release];
    [result3Lbl release];
    [result4Lbl release];
    [imageView release];
    [super dealloc];
}


@end
