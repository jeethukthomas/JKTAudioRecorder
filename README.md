JKTAudioRecorder
================

Audio Message library
@jeethukthomas@icloud.com

#import "JKTAudioNotes.h"

Set Delegate <JKTAudioNotesDelegate>

JKTAudioNotes* jkt=[[JKTAudioNotes alloc]init];
jkt.delegate=self;
jkt.audioLimit=5;
[jkt setJTKButton:<BUTTON>];


After completing these steps you can perform voice message action with <BUTTON>.

Available delegate methods are

- (void)finishedRecordingWithStatus:(BOOL)isSuccess andData:(NSData *)audio;
- (void)finishedPlaying;
-(void)startedRecording;
-(void)startedPlayBack;
-(void)pausedPlayBack;
-(void)resumePlayBack:(double)currentTime;
-(void)recordTime:(double)currentTime;

You can play the voice at the instance by calling [jkt playBack];
