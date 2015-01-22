//
//  UploadProgressView.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-13.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UploadProgressView.h"

@interface UploadProgressView (){
    NSProgress* uploadProgress;
    NSTimer *progressWatchTimer;
    UIBarButtonItem* pictureUploadButtonItem;
}

@end

@implementation UploadProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initProgressWithButton : (UIBarButtonItem*)uploadButton{
    pictureUploadButtonItem = uploadButton;
    self.hidden = YES;
    [self showPopUpViewAnimated:YES];
    
    self.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:15];
}

-(void)changeProgress{
    if(uploadProgress.fractionCompleted >= 1){
        [self terminateProgressWatcher];
    }
    self.progress = uploadProgress.fractionCompleted;
}

-(void)setUpProgressWatcher : (NSProgress*)uploadPicProgress{
    pictureUploadButtonItem.enabled = NO;
    self.progress = 0;
    self.alpha = 1;
    self.hidden = NO;
    uploadProgress = uploadPicProgress;
    progressWatchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeProgress) userInfo:nil repeats:YES];
}

-(void)terminateProgressWatcher{
    
    [progressWatchTimer invalidate];
    [self performSelector:@selector(hideProgressView) withObject:nil afterDelay:0.5];
}

-(void)hideProgressView{
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alpha = 0;
                         pictureUploadButtonItem.enabled = YES;
                     }];
    //self.hidden = YES;
}

@end
