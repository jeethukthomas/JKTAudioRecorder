//
//  ViewController.m
//  JKTAudioRecorder
//
//  Created by Jeethu on 11/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import "JKTAudioRecorder.h"

@interface JKTAudioRecorder ()

@end

@implementation JKTAudioRecorder

- (void)viewDidLoad
{
    [super viewDidLoad];
    _playBtn.hidden=YES;
    [_touchBtn.layer setCornerRadius:10];
    [_playBtn.layer setCornerRadius:50];
    
    _jkt=[[JKTAudioNotes alloc]init];
    _jkt.delegate=self;
    _jkt.audioLimit=5;
    [_jkt setJTKButton:_touchBtn];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)playFn:(id)sender {
    
    [_jkt playBack];
}

#pragma mark - JKT Delegates
- (void)finishedRecordingWithStatus:(BOOL)isSuccess andData:(NSData *)audio
{
    NSLog(@"finishedRecording %d",isSuccess);
[_touchBtn setHighlighted:NO];
    _playBtn.hidden=NO;
    _timeLabel.text=@"00:00";
}
- (void)finishedPlaying
{
     NSLog(@"finishedPlaying");
    [_playBtn setTitle:@"Play" forState:UIControlStateNormal];
}
-(void)startedRecording
{
    _playBtn.hidden=YES;
     NSLog(@"Started recording");
    [_touchBtn setHighlighted:YES];
}
-(void)startedPlayBack
{
    NSLog(@"Started recording");
    _playBtn.titleLabel.text=@"Pause";
    [_playBtn setTitle:@"Pause" forState:UIControlStateNormal];
}
-(void)pausedPlayBack
{
    NSLog(@"pausedPlayBack");
    [_playBtn setTitle:@"Play" forState:UIControlStateNormal];
}
-(void)resumePlayBack:(double)currentTime
{
    NSLog(@"resumePlayBack");
    [_playBtn setTitle:@"Pause" forState:UIControlStateNormal];
}
-(void)recordTime:(double)currentTime
{
    _timeLabel.text=[NSString stringWithFormat:@"%d",(int)currentTime];
}



@end
