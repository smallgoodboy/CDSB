//
//  UserBackDataManager.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserBackDataManager.h"
#import "StaticResourceManager.h"
#import "AFNetworking.h"

static UserBackDataManager* userBackDataManagerSigliton;

@implementation UserBackDataManager


-(void)getPhoneIdentifyCode : (NSString*)phoneNumber successCallTarget : (id)target successCall : (SEL)successCall{
    NSString* urlString = [NSString stringWithFormat:@"%@/%@", PhoneIdentifyBaseURLStringStatic, phoneNumber];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UpLoadSuccess] withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UnknownError] withObject:error];
    }];
}

-(void)userSignUpWithInfo : (NSDictionary*)dict successCallTarget : (id)target successCall : (SEL)successCall{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:UserSignUpBaseURLStringStatic parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UpLoadSuccess] withObject:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UnknownError] withObject:error];
    }];
}

-(void)userloginWithUserDict : (NSDictionary*)dict successCallTarget : (id)target successCall : (SEL)successCall{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:UserLoginBaseURLStringStatic parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UpLoadSuccess] withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UnknownError] withObject:error];
    }];
}

-(void)getUserInfoOfsuccessCallTarget : (id)target successCall : (SEL)successCall{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:UserInfoBaseURLStringStatic parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UpLoadSuccess] withObject:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d",UnknownError] withObject:error];
    }];
}

-(BOOL)isUserLogin{
    return [self findLoginCookie];
}

-(void)logOut{
    [self logOutWithGet];
}

-(void)deleteCookies{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in cookieArray) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
    }
}

-(void)logOutWithGet{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:UserLogoutBaseURLStringStatic parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"退出成功");
        [self deleteCookies];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"退出失败");
        [self deleteCookies];
    }];
}


-(BOOL)findLoginCookie{
    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookieArray = [NSArray arrayWithArray:[cookieJar cookies]];
    for (id obj in cookieArray) {
        if([obj isKindOfClass:[NSHTTPCookie class]]){
            NSString* cookieName = [(NSHTTPCookie*)obj name];
            if([@"SPRING_SECURITY_REMEMBER_ME_COOKIE" isEqualToString:cookieName]){
                return true;
            }
        }
    }
    return false;
}


-(BOOL)queryPhoneNumberIdentifyCode : (NSString*)phoneNumber successCallTarget : (id)target successCall : (SEL)successCall{
    if(![self judgePhoneNumberValidation:phoneNumber]){
        return NO;
    }
    [self getPhoneIdentifyCode:phoneNumber successCallTarget:target successCall:successCall];
    return YES;
}

-(BOOL)judgePhoneNumberValidation : (NSString*)phoneNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    //网络运营商
    NSString* NI = @"^170\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestni = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NI];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES)
        || ([regextestni evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(UserBackDataManager *)getInstance{
    @synchronized(self){
        if (!userBackDataManagerSigliton) {
            userBackDataManagerSigliton = [[self alloc] init];
        }
    }
    return userBackDataManagerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!userBackDataManagerSigliton) {
            userBackDataManagerSigliton = [super allocWithZone:zone];
            return userBackDataManagerSigliton;
        }
    }
    return nil;
}


- (id)copyWithZone:(NSZone *)zone;{
    return self;
}

/*****************************************/
/*****************************************/

@end
