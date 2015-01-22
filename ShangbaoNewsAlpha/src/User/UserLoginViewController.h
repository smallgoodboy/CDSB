//
//  UserLoginViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"

@interface UserLoginViewController : RootDecoratorViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)loginClicked:(id)sender;

@end
