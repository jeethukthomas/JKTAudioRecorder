//
//  JKTAudioNotes.h
//  JKTAudioRecorder
//
//  Created by Jeethu on 11/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@protocol JKTAudioNotesDelegate;
@interface JKTAudioNotes : NSObject<AVAudioRecorderDelegate, AVAudioPlayerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, weak) id<JKTAudioNotesDelegate> delegate;
@property (retain, nonatomic)AVAudioRecorder *audioRecorder;
@property (retain, nonatomic) AVAudioPlayer *audioPlayer;
@property (retain, nonatomic) NSTimer *pressTimer;
@property int audioLimit;
@property BOOL isAudioPaused;
-(void)playBack;
-(void)setJTKButton:(UIButton*)button;
@end
@protocol JKTAudioNotesDelegate<NSObject>
- (void)finishedRecordingWithStatus:(BOOL)isSuccess andData:(NSData*)audio;
- (void)finishedPlaying;
- (void)startedRecording;
- (void)startedPlayBack;
- (void)pausedPlayBack;
- (void)resumePlayBack:(double)currentTime;
- (void)recordTime:(double)currentTime;
@end