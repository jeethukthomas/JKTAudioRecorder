//
//  ViewController.h
//  JKTAudioRecorder
//
//  Created by Jeethu on 11/07/14.
//  Copyright (c) 2014 JKT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKTAudioNotes.h"

@interface JKTAudioRecorder : UIViewController <JKTAudioNotesDelegate>
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UIButton *touchBtn;
@property (strong, nonatomic) JKTAudioNotes *jkt;
- (IBAction)playFn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;


@end
