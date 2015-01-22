//
//  BackDataNode.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataNode.h"
#import "StaticResourceManager.h"

@implementation BackDataNode

@synthesize titleString;
@synthesize imageArray;
@synthesize summaryString;
@synthesize time;
@synthesize clickNumber;
@synthesize newsID;
@synthesize authorNameString;
@synthesize ariticleID;

@synthesize authorImageUrl;
@synthesize commentNumber;

-(id)init{
    if(self = [super init]){
        imageArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addAnImage : (NSString*)imageURLString{
    if(imageArray == nil){
        imageArray = [[NSMutableArray alloc] init];
    }
    [imageArray addObject:imageURLString];
}

-(NSString*)getImageURLAtOffset : (int)offset{
    if(imageArray == nil){
        imageArray = [[NSMutableArray alloc] init];
    }
    if([imageArray count] <= offset){
        return nil;
    }
    return imageArray[offset];
}

-(NSInteger)getImageNumber{
    if(imageArray == nil || [imageArray isKindOfClass:[NSNull class]]){
        imageArray = [[NSMutableArray alloc] init];
    }
    return [imageArray count];
}

-(NSString*)getNodeArticleURL{
    NSString* articleURL = [NSString stringWithFormat:@"%@/%ld",ArticleBaseURLStringStatic, (long)ariticleID];
    return articleURL;
}

-(NSString*)getCommentURL{
    NSString* commentURL = [NSString stringWithFormat:@"%@/%ld/%@", CommentBaseURLStringStatic, (long)ariticleID, @"comment"];
    return commentURL;
}

-(void)fillNodeWithDict:(id)dict{
    if((![dict isKindOfClass:[NSDictionary class]]) || dict == nil){
        return;
    }
    NSDictionary* d = (NSDictionary*)dict;
    titleString = [self getStringFromDict:d andKey:@"title"];
    authorNameString = [self getStringFromDict:d andKey:@"author"];
    summaryString = [self getStringFromDict:d andKey:@"summary"];
    authorImageUrl = [self getStringFromDict:d andKey:@"authorURL"];
    
    time = [self getDateFromInt:[self getNSLongLongIntegerFromDict:d andKey:@"time"]];

    clickNumber = [self getNSIntegerFromDict:d andKey:@"clicks"];
    newsID = [self getNSIntegerFromDict:d andKey:@"newsId"];
    ariticleID = [self getNSIntegerFromDict:d andKey:@"newsId"];
    commentNumber = [self getNSIntegerFromDict:d andKey:@"comments"];

    id imageArrayObj = [d objectForKey:@"picUrl"];
    if(imageArrayObj != nil && imageArrayObj != [NSNull null] && [imageArrayObj isKindOfClass:[NSArray class]]){
        for(id i in (NSArray*)imageArrayObj){
            [self addAnImage:i];
        }
    }else if([imageArrayObj isKindOfClass:[NSString class]]){
        [self addAnImage:[NSString stringWithFormat:@"%@/%@",ImageServerBaseURLStringStatic,imageArrayObj]];
    }
}

-(void)fillCommentNodeWithDict : (id)dict{
    if((![dict isKindOfClass:[NSDictionary class]]) || dict == nil){
        return;
    }
    NSDictionary* d = (NSDictionary*)dict;
    
    //time = [self getDateFromInt:[[self getStringFromDict:d andKey:@"time"] integerValue]];
    authorNameString = [self getStringFromDict:d andKey:@"userName"];
    summaryString = [self getStringFromDict:d andKey:@"content"];
    
    time = [self getDateFromInt:[self getNSLongLongIntegerFromDict:d andKey:@"time"]];
    ariticleID = [self getNSIntegerFromDict:d andKey:@"articleId"];
    
    id imageArrayObj = [d objectForKey:@"picUrl"];
    if(imageArrayObj != nil && imageArrayObj != [NSNull null] && [imageArrayObj isKindOfClass:[NSArray class]]){
        for(id i in (NSArray*)imageArrayObj){
            [self addAnImage:i];
        }
    }else if([imageArrayObj isKindOfClass:[NSString class]]){
        [self addAnImage:[NSString stringWithFormat:@"%@/%@",ImageServerBaseURLStringStatic,imageArrayObj]];
    }
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

-(id)getNSLongLongIntegerFromDict : (NSDictionary*)dict andKey : (NSString*)key{
    id res = [dict objectForKey:key];
    if(res == nil || res == NULL || [res isKindOfClass:[NSNull class]]){
        return 0;
    }
    
    return (id)res;
}

-(NSString*)getDateFromInt : (id)dateInt{
    long long timeSesond = [dateInt longLongValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeSesond/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return [dateFormatter stringFromDate:confromTimesp];
}

@end
