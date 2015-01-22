//
//  BackDataColumn.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataColumn.h"

@implementation BackDataColumn

@synthesize channelNameString;
@synthesize channelEnglishNameString;

-(id)init{
    if(self = [super init]){
        backDataNodeArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addANode : (BackDataNode*)node{
    if(backDataNodeArray == nil){
        backDataNodeArray = [[NSMutableArray alloc] init];
    }
    [backDataNodeArray addObject:node];
}

-(BackDataNode*)getNodeAtOffset : (NSInteger)offset{
    if(backDataNodeArray == nil){
        backDataNodeArray = [[NSMutableArray alloc] init];
    }
    if([backDataNodeArray count] <= offset){
        return nil;
    }
    return backDataNodeArray[offset];
}

-(NSInteger)getNodeCount{
    if(backDataNodeArray == nil){
        backDataNodeArray = [[NSMutableArray alloc] init];
    }
    return [backDataNodeArray count];
}

-(void)fillColumnWithDict : (id)dict{
    if(![dict isKindOfClass:[NSDictionary class]]){
        return;
    }
    channelNameString = [(NSDictionary*)dict objectForKey:@"columnName"];
    channelEnglishNameString = [(NSDictionary*)dict objectForKey:@"columnEnglishName"];
    id nodeArrayObj = [(NSDictionary*)dict objectForKey:@"content"];
    if([nodeArrayObj isKindOfClass:[NSArray class]]){
        for(id i in (NSArray*)nodeArrayObj){
            BackDataNode* node = [[BackDataNode alloc] init];
            [node fillNodeWithDict:i];
            [self addANode:node];
        }
    }
}

@end
