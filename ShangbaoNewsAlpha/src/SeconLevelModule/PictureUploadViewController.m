//
//  PictureUploadViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureUploadViewController.h"
#import "PictureUploader.h"
#import "KxMenu.h"
#import "BDKNotifyHUD.h"
#import "StaticResourceManager.h"
#import "PictureChengduActivityBackDataController.h"
#import "PictureChengduActivityNode.h"


@interface PictureUploadViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    NSProgress* uploadProgress;
    NSTimer *progressWatchTimer;
    PictureChengduActivityBackDataController* pictureChengduActivityBackDataControllerInstance;
}

@end

@implementation PictureUploadViewController

- (void)viewDidLoad {
    pictureChengduActivityBackDataControllerInstance = [PictureChengduActivityBackDataController getInstance];
    [pictureChengduActivityBackDataControllerInstance initBackDataController:self pickerView:self.activityPickerView];
    [pictureChengduActivityBackDataControllerInstance loadData];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.activityPickerView.delegate = self;
    self.activityPickerView.dataSource = self;
    
    self.newsSummaryLabel.delegate = self;
    [self.uploadProgressView initProgressWithButton:self.pictureUploadButtonItem];
}

- (void)openPics {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

-(void)openCam{
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

- (IBAction)selectImageClicked:(id)sender {
    //[self openPics];
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"请选择"
                     image:nil
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"摄像头 拍摄"
                     image:nil
                    target:self
                    action:@selector(openCam)],
      
      [KxMenuItem menuItem:@"从照片中选择"
                     image:nil
                    target:self
                    action:@selector(openPics)]
      ];
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    //[KxMenu setTintColor:[UIColor whiteColor]];
    [KxMenu showMenuInView:self.view
                  fromRect:[ UIScreen mainScreen ].applicationFrame
                 menuItems:menuItems];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    self.uploadImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)backClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender{
    
    [self.newsSummaryLabel resignFirstResponder];//通知文本失去第一响应者状态
    [self.newsTitleLabel resignFirstResponder];
}

- (IBAction)uploadImageClicked:(id)sender {
    UIImage* uploadImage = self.uploadImageView.image;
    NSMutableDictionary* uploadDict = [[NSMutableDictionary alloc] init];
    [uploadDict setObject:[self.newsTitleLabel text] forKey:@"title"];
    [uploadDict setObject:[self.newsSummaryLabel text] forKey:@"summary"];
    NSInteger row=[self.activityPickerView selectedRowInComponent:0];
    NSMutableArray* channelArray = [[NSMutableArray alloc] init];
    PictureChengduActivityNode* node = [pictureChengduActivityBackDataControllerInstance getNodeAtOffset:row ];
    if(node == nil){
    }else{
        [channelArray addObject:[node activityName]];
    }
    [uploadDict setObject:channelArray forKey:@"channel"];
    /**for test only **/
    uploadProgress = [[PictureUploader getInstance] uploadPictureWithAFnteworkWithProgress:uploadImage imageDescriberDict:uploadDict completeCall:@selector(uploadComplete:) target:self];
    [self.uploadProgressView setUpProgressWatcher : uploadProgress];
}



-(void)uploadComplete : (id)status{
    [self.uploadProgressView terminateProgressWatcher];
    switch([status integerValue]){
        case UpLoadSuccess:
            [self showPopover:1];
            break;
        case UnknownError:
            [self showPopover:2];
            break;
        case NetWorkDown:
            [self showPopover:3];
            break;
    }
}

-(void)showPopover : (int)type{
    BDKNotifyHUD *hud;
    switch (type) {
        case 1:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"check-6x.png"] text:@"成功"];
            break;
            
        default:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"失败"];
            break;
    }
    // Create the HUD object; view can be a UIImageView, an icon... you name it
    hud.center = CGPointMake(self.view.center.x, self.view.center.y - 20);
    
    // Animate it, then get rid of it. These settings last 1 second, takes a half-second fade.
    [self.view addSubview:hud];
    [hud presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
        [hud removeFromSuperview];
    }];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
         [self.newsSummaryLabel resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark Picker Date Source Methods

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pictureChengduActivityBackDataControllerInstance getNodesCount];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    PictureChengduActivityNode* node = [pictureChengduActivityBackDataControllerInstance getNodeAtOffset:row];
    return [node activityName];
}
@end
