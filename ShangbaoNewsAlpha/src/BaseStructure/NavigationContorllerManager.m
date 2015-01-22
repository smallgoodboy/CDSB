//
//  NavigationContorllerManager.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-21.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "NavigationContorllerManager.h"

static NavigationContorllerManager* navigationContorllerManagerSigliton;


@implementation NavigationContorllerManager

@synthesize shangbaoOrignViewControllerInstance;

-(id)init{
    if(self = [super init]){
        navControllerArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+(void)addANavigationController : (UINavigationController*)navController{
    [[NavigationContorllerManager getInstance] addNavC:navController];
}

-(void)addNavC : (UINavigationController*)navController{
    [navControllerArray addObject:navController];
}

+(void)getEveryNavControllerToFather{
    [[NavigationContorllerManager getInstance] navsToParents];
}

-(void)navsToParents{
    for(id i in navControllerArray){
        [(UINavigationController*)i popToRootViewControllerAnimated:NO];
    }
}

+(void)startAutoNavigation{
    [[NavigationContorllerManager getInstance] homePageNotifyProcess];
}

-(void)homePageNotifyProcess{
    [shangbaoOrignViewControllerInstance processNotifyIssue];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(NavigationContorllerManager *)getInstance{
    @synchronized(self){
        if (!navigationContorllerManagerSigliton) {
            navigationContorllerManagerSigliton = [[self alloc] init];
        }
    }
    return navigationContorllerManagerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!navigationContorllerManagerSigliton) {
            navigationContorllerManagerSigliton = [super allocWithZone:zone];
            return navigationContorllerManagerSigliton;
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
