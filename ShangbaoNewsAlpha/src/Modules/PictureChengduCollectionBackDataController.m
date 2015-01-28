//
//  PictureChengduCollectionBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduCollectionBackDataController.h"

static PictureChengduCollectionBackDataController* pictureChengduCollectionBackDataControllerSigliton;


@implementation PictureChengduCollectionBackDataController

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
    
    [self.frontCollectionView reloadData];
}

-(NSString*)get1stImageOfSection : (NSInteger)section;{
    BackDataNode* node = [super getNodeInSection:section andRow:0];
    if(node){
        return [node getImageURLAtOffset:0];
    }else{
        return @"";
    }
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PictureChengduCollectionBackDataController *)getInstance{
    @synchronized(self){
        if (!pictureChengduCollectionBackDataControllerSigliton) {
            pictureChengduCollectionBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return pictureChengduCollectionBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!pictureChengduCollectionBackDataControllerSigliton) {
            pictureChengduCollectionBackDataControllerSigliton = [super allocWithZone:zone];
            return pictureChengduCollectionBackDataControllerSigliton;
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
