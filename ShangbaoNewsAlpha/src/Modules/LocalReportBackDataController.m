//
//  LocalReportBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "LocalReportBackDataController.h"

static LocalReportBackDataController* localReportBackDataControllerSigliton;

@implementation LocalReportBackDataController

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(LocalReportBackDataController *)getInstance{
    @synchronized(self){
        if (!localReportBackDataControllerSigliton) {
            localReportBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return localReportBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!localReportBackDataControllerSigliton) {
            localReportBackDataControllerSigliton = [super allocWithZone:zone];
            return localReportBackDataControllerSigliton;
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
