//
//  UserManager.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-12.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserManager.h"
#import "UserBackDataManager.h"
#import "StaticResourceManager.h"

static UserManager* userManagerSigliton;

@implementation UserManager

@synthesize nameString;
@synthesize userNameString;
@synthesize emailString;
@synthesize phoneNumberString;
@synthesize ageInt;
@synthesize genderString;
@synthesize userImageURLString;
@synthesize birthdayString;
@synthesize userIDInt;

-(void)getUserInfo{
    [[UserBackDataManager getInstance] getUserInfoOfsuccessCallTarget:self successCall:@selector(getUserInfoAndShow:backObj:)];
}

-(void)getUserInfoAndShow  : (id)result backObj : (id)backObj{
    if([result integerValue] == UpLoadSuccess){
        if([backObj isKindOfClass:[NSDictionary class]]){
            [UserManager setContent:(NSDictionary*)backObj];
            NSLog(@"用户获取成功！");
            return;
        }
        
    }
    NSLog(@"获取失败");
}

+(void)setContent : (NSDictionary*)dict{
    [[UserManager getInstance] fillUserInfo:dict];
}

-(void)fillUserInfo : (NSDictionary*)dict{
    nameString = [self getStringFromDict : dict andKey : @"name"];
    userNameString = [self getStringFromDict : dict andKey : @"username"];
    emailString = [self getStringFromDict : dict andKey : @"email"];
    phoneNumberString = [self getStringFromDict : dict andKey : @"phone"];
    //ageInt = [self getStringFromDict : dict andKey : @"name"];
    genderString = [self getStringFromDict : dict andKey : @"sex"];
    userImageURLString = [self getStringFromDict : dict andKey : @"avatar"];
    birthdayString = [self getStringFromDict : dict andKey : @"birthday"];
    //nameString = [self getStringFromDict : dict andKey : @"name"];
    
    userIDInt = [self getNSIntegerFromDict:dict andKey:@"uid"];
    ageInt = [self getNSIntegerFromDict:dict andKey:@"age"];
}

-(NSString*)getStringFromDict : (NSDictionary*)dict andKey : (NSString*)key{
    id res = [dict objectForKey:key];
    if(res == nil || res == NULL || [res isKindOfClass:[NSNull class]]){
        return @"";
    }
    if(![res isKindOfClass:[NSString class]]){
        return @"";
    }
    return (NSString*)res;
}

-(NSInteger)getNSIntegerFromDict : (NSDictionary*)dict andKey : (NSString*)key{
    id res = [dict objectForKey:key];
    if(res == nil || res == NULL || [res isKindOfClass:[NSNull class]]){
        return 0;
    }
    
    return [res integerValue];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(UserManager *)getInstance{
    @synchronized(self){
        if (!userManagerSigliton) {
            userManagerSigliton = [[self alloc] init];
        }
    }
    return userManagerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!userManagerSigliton) {
            userManagerSigliton = [super allocWithZone:zone];
            return userManagerSigliton;
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
