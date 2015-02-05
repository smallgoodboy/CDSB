//
//  AdvertisementManager.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-3.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvertisementManager : NSObject

+(AdvertisementManager*)getInstance;

-(void)tryToLoadAdImage : (id)adImageArrayObj;

-(BOOL)isNetworkStatusSupportAdLoad;

@end
