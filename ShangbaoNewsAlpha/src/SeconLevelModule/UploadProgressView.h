//
//  UploadProgressView.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-13.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASProgressPopUpView.h"

@interface UploadProgressView : ASProgressPopUpView

-(void)initProgressWithButton : (UIBarButtonItem*)uploadButton;
-(void)setUpProgressWatcher : (NSProgress*)uploadPicProgress;
-(void)terminateProgressWatcher;
@end
