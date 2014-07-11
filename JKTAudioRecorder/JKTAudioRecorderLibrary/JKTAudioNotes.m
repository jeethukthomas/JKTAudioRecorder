//
//  JKTAudioNotes.m
//  JKTAudioRecorder
//
//  Created by Jeethu on 11/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import "JKTAudioNotes.h"
#import "JKTAudioRecorder.h"
@implementation JKTAudioNotes
int timeCount;
-(id)init
{
    self = [super init];
    if (self) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
        [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        [recordSetting setValue:[NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[self getFileName] settings:recordSetting error:nil];
        _audioRecorder.delegate = self;
        _audioRecorder.meteringEnabled = YES;
        [_audioRecorder prepareToRecord];
    }
    return self;
}

-(void)setJTKButton:(UIButton*)button
{
    [button addTarget:self action:@selector(stopRecording)
     forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(recordSound)
     forControlEvents:UIControlEventTouchDown];
}

-(NSURL*)getFileName
{
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],[NSString stringWithFormat:@"jeethukthomas_audio.m4a"],
                               nil];
    return [NSURL fileURLWithPathComponents:pathComponents];
}
-(void)playBack
{
    if (!_audioRecorder.recording){
        
        if (_audioPlayer.playing) {
            _isAudioPaused=TRUE;
            [_audioPlayer pause];
            id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
            if ([strongDelegate respondsToSelector:@selector(pausedPlayBack)])
            {
                [strongDelegate pausedPlayBack];
            }
        }
        else if (_isAudioPaused)
        {
            [_audioPlayer play];
            id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
            if ([strongDelegate respondsToSelector:@selector(resumePlayBack:)])
            {
                [strongDelegate resumePlayBack:_audioPlayer.currentTime];
            }
            
        }
        else
        {
            
            _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioRecorder.url error:nil];
            [_audioPlayer setDelegate:self];
            [_audioPlayer play];
            
            id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
            if ([strongDelegate respondsToSelector:@selector(startedPlayBack)])
            {
                [strongDelegate startedPlayBack];
            }
        }
    }
}
-(void)stopRecording
{
    if (_audioRecorder.recording){
        int recordDuration=_audioRecorder.currentTime;
        [_audioRecorder stop];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];
        if(recordDuration<2)
        {
            [_audioRecorder deleteRecording];
        }
    }
    if([_pressTimer isValid])
    {
        [_pressTimer invalidate];
    }
}
-(void)timerSetup
{
    id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(recordTime:)])
    {
        [strongDelegate recordTime:_audioRecorder.currentTime+1];
    }
    timeCount++;
    if(timeCount>_audioLimit)
    {
        [self stopRecording];
        return;
    }
}
-(void)recordSound
{
    _isAudioPaused=NO;
    timeCount=0;
    if(_audioLimit)
    {
        _pressTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSetup) userInfo:nil repeats:YES];
    }
    if (_audioPlayer.playing) {
        [_audioPlayer stop];
    }
    if (!_audioRecorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        // Start recording
        [_audioRecorder record];
        
        id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
        if ([strongDelegate respondsToSelector:@selector(startedRecording)])
        {
            [strongDelegate startedRecording];
        }
    }
}
-(void)audioPlayerDidFinishPlaying: (AVAudioPlayer *)player successfully:(BOOL)flag
{
    id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
    if ([strongDelegate respondsToSelector:@selector(finishedPlaying)])
    {
        [strongDelegate finishedPlaying];
    }
}
-(void)audioRecorderDidFinishRecording: (AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    if(flag)
    {
        NSData *data=[NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@",[self getFileName]]];
        id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
        if ([strongDelegate respondsToSelector:@selector(finishedRecordingWithStatus:andData:)])
        {
            [strongDelegate finishedRecordingWithStatus:YES andData:data];
        }
    }
    else
    {
        id<JKTAudioNotesDelegate> strongDelegate = self.delegate;
        if ([strongDelegate respondsToSelector:@selector(finishedRecordingWithStatus:andData:)])
        {
            [strongDelegate finishedRecordingWithStatus:NO andData:nil];
        }
    }
}
@end
