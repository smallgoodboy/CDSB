//
//  NewestInfoBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "NewestInfoBackDataController.h"
#import "NavigationContorllerManager.h"

static NewestInfoBackDataController* newestInfoBackDataControllerSigliton;

@implementation NewestInfoBackDataController

@synthesize notifyNewsIDInt;

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

+(NewestInfoBackDataController *)getInstance{
    @synchronized(self){
        if (!newestInfoBackDataControllerSigliton) {
            newestInfoBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return newestInfoBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!newestInfoBackDataControllerSigliton) {
            newestInfoBackDataControllerSigliton = [super allocWithZone:zone];
            return newestInfoBackDataControllerSigliton;
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
