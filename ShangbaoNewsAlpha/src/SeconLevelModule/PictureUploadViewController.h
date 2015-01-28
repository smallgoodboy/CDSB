//
//  PictureUploadViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootDecoratorViewController.h"
#import "UploadProgressView.h"

@interface PictureUploadViewController : RootDecoratorViewController
@property (weak, nonatomic) IBOutlet UIImageView *uploadImageView;
@property (weak, nonatomic) IBOutlet UINavigationItem *topCuteNavigationItem;
- (IBAction)backClicked:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)uploadImageClicked:(id)sender;

- (IBAction)selectImageClicked:(id)sender;

-(void)uploadComplete : (id)status;

@property (weak, nonatomic) IBOutlet UITextField *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *newsSummaryLabel;
@property (weak, nonatomic) IBOutlet UploadProgressView *uploadProgressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pictureUploadButtonItem;
@property (weak, nonatomic) IBOutlet UIPickerView *activityPickerView;

@end
