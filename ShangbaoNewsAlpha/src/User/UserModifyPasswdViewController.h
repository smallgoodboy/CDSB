//
//  UserModifyPasswdViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-2.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"

@interface UserModifyPasswdViewController : RootDecoratorViewController

@property (weak, nonatomic) IBOutlet UITextField *userOldPasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNewPasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *userConfirmNewPasswdTextField;


@property (weak, nonatomic) IBOutlet UIButton *userAbandonPasswdModofyButton;
- (IBAction)abandonPasswdModifyClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *userPasswdModifyButton;
- (IBAction)modifyPasswdClicked:(id)sender;


@end
