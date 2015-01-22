//
//  PictureChengduBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduBackDataController.h"

static PictureChengduBackDataController* pictureChengduBackDataControllerSigliton;


@implementation PictureChengduBackDataController

-(id)init{
    if(self=[super init]){
        isModuleUsePaging = NO;
    }
    return self;
}

-(void)analyseModuleServerData : (id)backDataObj{
    if(![backDataObj isKindOfClass:[NSDictionary class]]){
        return;
    }
    id pictureChengduContentArrayObj = [(NSDictionary*)backDataObj objectForKey:@"contentColumns"];
    
    if(![pictureChengduContentArrayObj isKindOfClass:[NSArray class]]){
        return;
    }
    
    for(id i in (NSArray*)pictureChengduContentArrayObj){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        BackDataColumn* column = [[BackDataColumn alloc] init];
        [column fillColumnWithDict:i];
        [backDataArray addObject:column];
    }
    
    [self.frontTableView reloadData];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PictureChengduBackDataController *)getInstance{
    @synchronized(self){
        if (!pictureChengduBackDataControllerSigliton) {
            pictureChengduBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return pictureChengduBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!pictureChengduBackDataControllerSigliton) {
            pictureChengduBackDataControllerSigliton = [super allocWithZone:zone];
            return pictureChengduBackDataControllerSigliton;
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
