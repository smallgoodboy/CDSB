//
//  UserSignUpViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserSignUpViewController.h"
#import "UserBackDataManager.h"
#import "StaticResourceManager.h"

@interface UserSignUpViewController (){
    UserBackDataManager* userBackDataManagerInstance;
    NSTimer* phoneIdentifyTimer;
    int phoneIdentifyCountDownint;
    UIColor* phoneIdentifyCodeButtonOriginColor;
    
    NSString* phoneIdentifyCodeString;
    NSString* phoneIdentifiedNumberString;
}

@end

@implementation UserSignUpViewController

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




- (IBAction)userSignUpClicked:(id)sender {
    NSString* phoneNumber = self.userPhoneNumberTextField.text;
    NSString* phoneIDNumber = self.userPhoneIdentifyCodeTextField.text;
    NSString* userName = self.userNameTextField.text;
    NSString* password = self.userPasswordTextField.text;
    NSString* password2 = self.userPasswordConfirmTextField.text;
    
    if(![password isEqualToString:password2]){
        return;
    }
    
    if((![phoneIdentifiedNumberString isEqualToString:phoneNumber]) || ![phoneIDNumber isEqualToString:phoneIdentifyCodeString]){
        return;
    }
    
    if([phoneIDNumber length] != 6){
        //NSLog(@"%d", [phoneIDNumber length]);
        return;
    }
    
    [self userSignUpWithPhone:phoneNumber userName:userName passWord:password];
}

-(void)userSignUpWithPhone : (NSString*)phoneNumber userName : (NSString*)username passWord : (NSString*)passWord{
    if(userBackDataManagerInstance == nil){
        userBackDataManagerInstance = [UserBackDataManager getInstance];
    }
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[NSNumber numberWithInt:[phoneNumber integerValue]] forKey:@"phone"];
    [dict setObject:username forKey:@"name"];
    [dict setObject:passWord forKey:@"passwd"];
    
    [userBackDataManagerInstance userSignUpWithInfo:dict successCallTarget:self successCall:@selector(userSignUpCallBack:backObj:)];
}

-(void)userSignUpCallBack : (id)result backObj : (id)backObj{
    if([result integerValue] == UpLoadSuccess){
        if([backObj isKindOfClass:[NSDictionary class]]){
            if([[(NSDictionary*)backObj objectForKey:@"resultCode"] integerValue] == 1){
                //注册成功
                NSLog(@"注册成功");
                return;
            }
        }
        
    }
    NSLog(@"注册失败");
}



- (IBAction)userPhoneNumberChechClicked:(id)sender {
    phoneIdentifyCodeButtonOriginColor = self.userPhoneIdentifyCodeButton.backgroundColor;
    [self enablePhoneIdentifyCodeButton:false];
    if(userBackDataManagerInstance == nil){
        userBackDataManagerInstance = [UserBackDataManager getInstance];
    }
    
    phoneIdentifyCountDownint = 60;
    phoneIdentifyTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeIdentifyButtonStatus) userInfo:nil repeats:YES];
    phoneIdentifiedNumberString = self.userPhoneNumberTextField.text;
    //[userBackDataManagerInstance queryPhoneNumberIdentifyCode:phoneIdentifiedNumberString successCallTarget:self successCall:@selector(phoneValidationGetSent:returnObj:)];
    NSMutableDictionary* testDict = [[NSMutableDictionary alloc] init];
    [testDict setObject:@"000000" forKey:@"ResultMsg"];
    [self phoneValidationGetSent:[NSString stringWithFormat:@"%d",UpLoadSuccess] returnObj:testDict];
}

-(void)enablePhoneIdentifyCodeButton : (BOOL)enable{
    if(enable){
        self.userPhoneIdentifyCodeButton.enabled = YES;
        [self.userPhoneIdentifyCodeButton setBackgroundColor:phoneIdentifyCodeButtonOriginColor];
    }else{
        self.userPhoneIdentifyCodeButton.enabled = NO;
        [self.userPhoneIdentifyCodeButton setBackgroundColor:[UIColor grayColor]];
    }
}

-(void)changeIdentifyButtonStatus{
    if(phoneIdentifyCountDownint < 1){
        [phoneIdentifyTimer invalidate];
        [self enablePhoneIdentifyCodeButton:true];
        self.userPhoneIdentifyCodeButton.titleLabel.text = @"发送验证码";
    }
    self.userPhoneIdentifyCodeButton.titleLabel.text = [NSString stringWithFormat:@"%d秒后重试", phoneIdentifyCountDownint--];
}


-(void)phoneValidationGetSent : (id)successOrNot returnObj : (id)returnObj{
    if([successOrNot integerValue] == UpLoadSuccess){
        if([returnObj isKindOfClass:[NSDictionary class]]){
            phoneIdentifyCodeString = [(NSDictionary*)returnObj objectForKey:@"ResultMsg"];
        }else{
            [self enablePhoneIdentifyCodeButton:true];
        }
    }else{
        [self enablePhoneIdentifyCodeButton:true];
        return;
    }
}

@end
