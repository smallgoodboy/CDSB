//
//  UserLoginViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserLoginViewController.h"
#import "AFNetworking.h"
#import "StaticResourceManager.h"
#import "UserBackDataManager.h"

@interface UserLoginViewController (){
    UserBackDataManager* userBackDataManagerInstance;
}

@end

@implementation UserLoginViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidDisappear:animated];
    /*if([self findLoginCookie]){
        [self performSegueWithIdentifier:UserAlreadyLoginSegueNameStringStatic sender:[self parentViewController]];
    }*/
}

- (void)viewDidLoad {
    [super viewDidLoad];
    userBackDataManagerInstance = [UserBackDataManager getInstance];
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

- (IBAction)loginClicked:(id)sender {
    [self login];
}

-(void)login{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    NSString* userName = self.userNameTextField.text;
    NSString* password = self.userPasswordTextField.text;
    [self packUserName_or_PhoneNumber_or_EmailAddress:userName intoDict:dict];
    [dict setObject:password forKey:@"passwd"];

    [userBackDataManagerInstance userloginWithUserDict:dict successCallTarget:self successCall:@selector(loginRequestSentFinished:backObj:)];
}

-(void)loginRequestSentFinished : (id)result backObj : (id)backObj{
    if([result integerValue] == UpLoadSuccess){
        if([backObj isKindOfClass:[NSDictionary class]]){
            if([[(NSDictionary*)backObj objectForKey:@"resultCode"] integerValue] == 1){
                //注册成功
                NSLog(@"登陆成功");
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
        }
        
    }
    NSLog(@"登陆失败");
}

-(void)logout{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in cookieArray) {
        [cookieJar deleteCookie:obj];
    }
}

-(void)packUserName_or_PhoneNumber_or_EmailAddress : (NSString*)unkownThing intoDict : (NSMutableDictionary*)dict{
    if([userBackDataManagerInstance judgePhoneNumberValidation:unkownThing]){
        [dict setObject:[NSNumber numberWithInt:[unkownThing integerValue]] forKey:@"phone"];
    }else if([unkownThing rangeOfString:@"@"].length > 0){
        [dict setObject:unkownThing forKey:@"email"];
    }else{
        [dict setObject:unkownThing forKey:@"name"];
    }
}



/*-(void)fuckTest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://202.115.17.218:8080/Shangbao01/channel/channels" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"cccc");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ssss");
    }];
}

-(void)readCookie{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in cookieArray) {
        NSLog(@"%@", obj);
    }
}*/


@end
