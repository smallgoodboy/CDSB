//
//  PictureChengduSecondLevelBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-12.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduSecondLevelBackDataController.h"

static PictureChengduSecondLevelBackDataController* pictureChengduSecondLevelBackDataControllerSigliton;


@implementation PictureChengduSecondLevelBackDataController

-(id)init{
    if(self=[super init]){
        isModuleUsePaging = YES;
    }
    return self;
}

-(void)analyseModuleServerData : (id)backDataObj{
    if(![backDataObj isKindOfClass:[NSDictionary class]]){
        return;
    }
    id pictureChengdu2LevelContentArrayObj = [(NSDictionary*)backDataObj objectForKey:@"content"];
    
    if(![pictureChengdu2LevelContentArrayObj isKindOfClass:[NSArray class]]){
        return;
    }
    
    pageTotalNumber = [[(NSDictionary*)backDataObj objectForKey:@"pageCount"] integerValue];
    
    for(id i in (NSArray*)pictureChengdu2LevelContentArrayObj){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        BackDataNode* node = [[BackDataNode alloc] init];
        [node fillNodeWithDict:i];
        [backDataArray addObject:node];
    }
    
    [self.frontTableView reloadData];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PictureChengduSecondLevelBackDataController*)getInstance{
    @synchronized(self){
        if (!pictureChengduSecondLevelBackDataControllerSigliton) {
            pictureChengduSecondLevelBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return pictureChengduSecondLevelBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!pictureChengduSecondLevelBackDataControllerSigliton) {
            pictureChengduSecondLevelBackDataControllerSigliton = [super allocWithZone:zone];
            return pictureChengduSecondLevelBackDataControllerSigliton;
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
