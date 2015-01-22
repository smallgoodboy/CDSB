//
//  PublicContent2LevelBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContent2LevelBackDataController.h"

static PublicContent2LevelBackDataController* publicContent2LevelBackDataControllerSigliton;


@implementation PublicContent2LevelBackDataController

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
    
    pageTotalNumber = [[(NSDictionary*)backDataObj objectForKey:@"pageCount"] integerValue];
    if((int)[(NSDictionary*)backDataObj objectForKey:@"currentNo"] != pageLoadednumber){
        pageLoadednumber = [[(NSDictionary*)backDataObj objectForKey:@"currentNo"] integerValue];
    }
    
    id publicContentSecondContentArrayObj = [(NSDictionary*)backDataObj objectForKey:@"content"];
    if(![publicContentSecondContentArrayObj isKindOfClass:[NSArray class]]){
        return;
    }
    NSLog(@"Public Content back data almost ready!");
    for(id i in (NSArray*)publicContentSecondContentArrayObj){
        BackDataNode* node = [[BackDataNode alloc] init];
        [node fillNodeWithDict:i];
        [backDataArray addObject:node];
    }
    
    [self.frontTableView reloadData];
}


/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PublicContent2LevelBackDataController *)getInstance{
    @synchronized(self){
        if (!publicContent2LevelBackDataControllerSigliton) {
            publicContent2LevelBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return publicContent2LevelBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!publicContent2LevelBackDataControllerSigliton) {
            publicContent2LevelBackDataControllerSigliton = [super allocWithZone:zone];
            return publicContent2LevelBackDataControllerSigliton;
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
