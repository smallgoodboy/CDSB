//
//  OfflineCacher.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-27.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "OfflineCacher.h"
#import "StaticResourceManager.h"

static OfflineCacher* offlineCacherSigliton;

@implementation OfflineCacher

-(id)init{
    if(self = [super init]){
        cachedDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}


+(void)readCache{
    [[OfflineCacher getInstance] readDataFromDisk];
}

+(void)cacheObj : (id)obj forKey : (NSString*)key{
    [[OfflineCacher getInstance] insertCacheDataForKey:key andValue:obj];
}

+(id)getObjForKey : (NSString*)key{
    return [[OfflineCacher getInstance] readCachedDataForKey:key];
}

-(void)readDataFromDisk{
    cachedDict = [self readFile:CacheFileNameStringStatic];
}

-(void)writeBackToDisk{
    [self writeFile:CacheFileNameStringStatic content:cachedDict];
}

-(NSMutableDictionary*)readFile : (NSString*)fileName{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    //1、参数NSDocumentDirectory要获取的那种路径
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //2、得到相应的Documents的路径
    NSString* documentDirectory = [paths objectAtIndex:0];
    
    //3、更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];
    
    if(![fileManager fileExistsAtPath:fileName]){
        return [[NSMutableDictionary alloc] init];
    }else{
        NSData * data = [NSData dataWithContentsOfFile:path];
        //return [[NSMutableDictionary alloc] initWithContentsOfFile:path];
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

-(void)writeFile : (NSString*)fileName content: (NSMutableDictionary*)contentDict{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *error;
    //获取路径
    //1、参数NSDocumentDirectory要获取的那种路径
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //2、得到相应的Documents的路径
    NSString* documentDirectory = [paths objectAtIndex:0];
    //3、更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    
    //[fileManager removeItemAtPath:fileName error:nil];
    NSString *path = [documentDirectory stringByAppendingPathComponent:fileName];
    
    NSData * plistData = [NSKeyedArchiver archivedDataWithRootObject:contentDict];
    /*NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:contentDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];*/
    if(plistData) {
        [fileManager removeItemAtPath:fileName error:nil];
        [plistData writeToFile:path atomically:YES];
    }
    else {
        NSLog(@"error :%@", error);
    }
}

-(void)insertCacheDataForKey : (NSString*)key andValue : (id)contentDictObj{
    if(key == nil || contentDictObj == nil){
        return;
    }
    [cachedDict setObject:contentDictObj forKey:key];
    [self writeBackToDisk];
}

-(id)readCachedDataForKey : (NSString*)key{
    return [cachedDict objectForKey:key];
}


/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(OfflineCacher *)getInstance{
    @synchronized(self){
        if (!offlineCacherSigliton) {
            offlineCacherSigliton = [[self alloc] init];
        }
    }
    return offlineCacherSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!offlineCacherSigliton) {
            offlineCacherSigliton = [super allocWithZone:zone];
            return offlineCacherSigliton;
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
