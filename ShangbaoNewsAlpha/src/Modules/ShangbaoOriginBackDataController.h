//
//  ShangbaoOriginBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataBaseController.h"

@interface ShangbaoOriginBackDataController : BackDataBaseController

@property NSInteger notifyNewsIDInt;

+(ShangbaoOriginBackDataController *)getInstance;

-(void)setNotifyNewsId : (NSInteger)newsID;
-(void)getNotifyWhileRunning : (NSInteger)newsID;

@end
