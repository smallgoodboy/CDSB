//
//  UserAlreadyLogedInViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"
#import "RoundImageView.h"

@interface UserAlreadyLogedInViewController : RootDecoratorViewController
- (IBAction)logOutClicked:(id)sender;
@property (weak, nonatomic) IBOutlet RoundImageView *userImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
- (IBAction)userChangeAvatarClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *userSettingTable;
@end
