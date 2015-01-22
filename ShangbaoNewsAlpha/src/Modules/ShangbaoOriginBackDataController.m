//
//  ShangbaoOriginBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "ShangbaoOriginBackDataController.h"
#import "NavigationContorllerManager.h"

static ShangbaoOriginBackDataController* shangbaoOriginBackDataControllerSigliton;


@implementation ShangbaoOriginBackDataController

@synthesize notifyNewsIDInt;

-(id)init{
    if(self=[super init]){
        isModuleUsePaging = YES;
    }
    return self;
}

-(void)analyseModuleServerData : (id)backDataObj{
    if([backDataObj isKindOfClass:[NSDictionary class]]){
        NSLog(@"Shangbao origin format right");
    }else{
        NSLog(@"Shangbao origin format wrong");
        return;
    }
    
    pageTotalNumber = [[(NSDictionary*)backDataObj objectForKey:@"pageCount"] integerValue];
    id shangbaoOriginContentArrayObj = [(NSDictionary*) backDataObj objectForKey:@"content"];
    if([shangbaoOriginContentArrayObj isKindOfClass:[NSArray class]] || shangbaoOriginContentArrayObj == nil){
        NSLog(@"Shangbao origin content format right");
    }else{
        NSLog(@"Shangbao origin content format wrong");
        return;
    }
    
    NSArray* shangbaoOriginContentArray = (NSArray*)shangbaoOriginContentArrayObj;
    
    for(id i in shangbaoOriginContentArray){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        BackDataNode* node = [[BackDataNode alloc] init];
        [node fillNodeWithDict:(NSDictionary *)i];
        
        [backDataArray addObject:node];
    }
    [self.frontTableView reloadData];
}

-(void)setNotifyNewsId : (NSInteger)newsID{
    [self setNotifyNewsIDInt:newsID];
}

-(void)getNotifyWhileRunning : (NSInteger)newsID{
    [NavigationContorllerManager getEveryNavControllerToFather];
    [self setNotifyNewsIDInt:newsID];
    [NavigationContorllerManager startAutoNavigation];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(ShangbaoOriginBackDataController *)getInstance{
    @synchronized(self){
        if (!shangbaoOriginBackDataControllerSigliton) {
            shangbaoOriginBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return shangbaoOriginBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!shangbaoOriginBackDataControllerSigliton) {
            shangbaoOriginBackDataControllerSigliton = [super allocWithZone:zone];
            return shangbaoOriginBackDataControllerSigliton;
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
