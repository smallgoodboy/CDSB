//
//  OfflineCacher.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-27.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfflineCacher : NSObject{
    NSMutableDictionary* cachedDict;
}

+(OfflineCacher*)getInstance;

-(void)readDataFromDisk;
-(void)writeBackToDisk;

-(void)insertCacheDataForKey : (NSString*)key andValue : (id)contentDictObj;
-(id)readCachedDataForKey : (NSString*)key;

+(void)readCache;
+(void)cacheObj : (id)obj forKey : (NSString*)key;
+(id)getObjForKey : (NSString*)key;

@end
