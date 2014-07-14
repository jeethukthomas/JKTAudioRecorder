JKTAudioRecorder
================

Audio Message library
@jeethukthomas@icloud.com

import JKTAudioNotes.h

Set Delegate <JKTAudioNotesDelegate>

1 - JKTAudioNotes* jkt=[[JKTAudioNotes alloc]init];

2 - jkt.delegate=self;

3 - jkt.audioLimit=5; //optional

4 - [jkt setJTKButton:<BUTTON>];


After completing these steps you can perform voice message action with <BUTTON>.

Available delegate methods are

1 -  (void)finishedRecordingWithStatus:(BOOL)isSuccess andData:(NSData *)audio;

2 - (void)finishedPlaying;

3 - (void)startedRecording;

4 - (void)startedPlayBack;

5 - (void)pausedPlayBack;

6 - (void)resumePlayBack:(double)currentTime;

7 - (void)recordTime:(double)currentTime;

You can play the voice at the instance by calling [jkt playBack];
