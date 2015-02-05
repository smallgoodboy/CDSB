//
//  NewestInfoBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataBaseController.h"
#import "PublicContentBackDataController.h"

@interface NewestInfoBackDataController : PublicContentBackDataController

@property NSInteger notifyNewsIDInt;

+(NewestInfoBackDataController *)getInstance;


-(void)setNotifyNewsId : (NSInteger)newsID;
-(void)getNotifyWhileRunning : (NSInteger)newsID;

@end
