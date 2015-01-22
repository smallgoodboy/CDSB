//
//  UserSignUpViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"

@interface UserSignUpViewController : RootDecoratorViewController
@property (weak, nonatomic) IBOutlet UITextField *userPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPhoneIdentifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *userPhoneIdentifyCodeButton;
- (IBAction)userPhoneNumberChechClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordConfirmTextField;
@property (weak, nonatomic) IBOutlet UIButton *userSignUpButton;
- (IBAction)userSignUpClicked:(id)sender;

@end
