//
//  UserForgetPasswdViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-4.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"

@interface UserForgetPasswdViewController : RootDecoratorViewController
@property (weak, nonatomic) IBOutlet UITextField *userPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneIdentifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNewPasswdTextField;
- (IBAction)getPhoneIdentifyCodeClicked:(id)sender;
- (IBAction)resetPasswdClicked:(id)sender;


@end
