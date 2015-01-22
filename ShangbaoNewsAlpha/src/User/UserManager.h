//
//  UserManager.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-12.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property NSString* nameString;
@property NSString* userNameString;
@property NSString* emailString;
@property NSString* phoneNumberString;
@property NSInteger ageInt;
@property NSString* genderString;
@property NSString* userImageURLString;
@property NSString* birthdayString;
@property NSInteger userIDInt;

+(UserManager *)getInstance;

+(void)setContent : (NSDictionary*)dict;
-(void)getUserInfo;

@end
