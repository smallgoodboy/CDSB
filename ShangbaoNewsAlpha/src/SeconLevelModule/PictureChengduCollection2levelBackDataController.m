//
//  PictureChengduCollection2levelBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduCollection2levelBackDataController.h"
#import "BackDataNode.h"

static PictureChengduCollection2levelBackDataController* pictureChengduCollection2levelBackDataControllerSigliton;

@implementation PictureChengduCollection2levelBackDataController

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
    id pictureChengduContentArrayObj = [(NSDictionary*)backDataObj objectForKey:@"content"];
    
    if(![pictureChengduContentArrayObj isKindOfClass:[NSArray class]]){
        return;
    }
    
    for(id i in (NSArray*)pictureChengduContentArrayObj){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        BackDataNode* node = [[BackDataNode alloc] init];
        [node fillNodeWithDict:i];
        [backDataArray addObject:node];
    }
    
    [self.frontCollectionView reloadData];
}

-(void)clearBackData{
    backDataArray = [[NSMutableArray alloc] init];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PictureChengduCollection2levelBackDataController *)getInstance{
    @synchronized(self){
        if (!pictureChengduCollection2levelBackDataControllerSigliton) {
            pictureChengduCollection2levelBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return pictureChengduCollection2levelBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!pictureChengduCollection2levelBackDataControllerSigliton) {
            pictureChengduCollection2levelBackDataControllerSigliton = [super allocWithZone:zone];
            return pictureChengduCollection2levelBackDataControllerSigliton;
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
