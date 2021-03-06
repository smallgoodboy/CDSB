//
//  UserBackDataManager.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserBackDataManager : NSObject
+(UserBackDataManager*)getInstance;

-(BOOL)queryPhoneNumberIdentifyCode : (NSString*)phoneNumber successCallTarget : (id)target successCall : (SEL)successCall;
-(void)userSignUpWithInfo : (NSDictionary*)dict successCallTarget : (id)target successCall : (SEL)successCall;
-(void)userloginWithUserDict : (NSDictionary*)dict successCallTarget : (id)target successCall : (SEL)successCall;
-(void)getUserInfoOfsuccessCallTarget : (id)target successCall : (SEL)successCall;
-(void)modifyUserPasswdWithUserDict : (NSDictionary*)dict successCallTarget : (id)target successCall : (SEL)successCall;
-(NSProgress*)uploadUserAvatar:(UIImage *)imageReadyToUpload imageDescriberDict:(NSMutableDictionary *)dict completeCall:(SEL)completeCall target:(id)target;


-(BOOL)isUserLogin;
-(void)logOut;

-(BOOL)judgePhoneNumberValidation : (NSString*)phoneNumber;

@end
