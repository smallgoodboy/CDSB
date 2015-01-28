//
//  PictureChengduActivityNode.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-25.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduActivityNode.h"

@implementation PictureChengduActivityNode


@synthesize activityName;
@synthesize activitySummary;

-(void)setContent : (NSDictionary*)dict{
    activityName = [self getStringFromDict:dict andKey:@"activeName"];
    activitySummary = [self getStringFromDict:dict andKey:@"summary"];
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
@end
