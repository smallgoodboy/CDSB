//
//  PictureChengduActivityNode.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-25.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureChengduActivityNode : NSObject

@property NSString* activityName;
@property NSString* activitySummary;

-(void)setContent : (NSDictionary*)dict;

@end
