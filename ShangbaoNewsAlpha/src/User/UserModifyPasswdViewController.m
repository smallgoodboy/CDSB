//
//  UserModifyPasswdViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-2.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserModifyPasswdViewController.h"
#import "UserBackDataManager.h"
#import "StaticResourceManager.h"

@interface UserModifyPasswdViewController ()

@end

@implementation UserModifyPasswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)abandonPasswdModifyClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)modifyPasswdClicked:(id)sender {
    NSString* oldPasswdString = self.userOldPasswdTextField.text;
    NSString* newPasswdString = self.userNewPasswdTextField.text;
    NSString* newPasswdConfirm = self.userConfirmNewPasswdTextField.text;
    if(![newPasswdConfirm isEqualToString:newPasswdString]){
        NSLog(@"密码不一致");
    }
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:oldPasswdString forKey:@"oldPasswd"];
    [dict setObject:newPasswdString forKey:@"newPasswd"];
    
    [[UserBackDataManager getInstance] modifyUserPasswdWithUserDict:dict successCallTarget:self successCall:@selector(userPasswdModifyCallBack:backObj:)];
}

-(void)userPasswdModifyCallBack : (id)result backObj : (id)backObj{
    if([result integerValue] == UpLoadSuccess){
        NSLog(@"%@", [[NSString alloc] initWithData:backObj  encoding:NSUTF8StringEncoding]);
        return;
        
    }
    NSLog(@"密码修改失败");
}
@end
