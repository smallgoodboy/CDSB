//
//  AdvertisementManager.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-3.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "AdvertisementManager.h"
#import "Reachability.h"
#import "StaticResourceManager.h"
#import "AFNetworking.h"
#import "OfflineCacher.h"


static AdvertisementManager* advertisementManagerSigliton;

@implementation AdvertisementManager

-(void)tryToLoadAdImage : (id)adImageArrayObj{
    /*if(adImageArrayObj == nil || adImageArrayObj == NULL || [adImageArrayObj isKindOfClass:[NSNull class]]  || (![adImageArrayObj isKindOfClass:[NSArray class]])){
        return;
    }
    if(![self isNetworkStatusSupportAdLoad]){
        return;
    }
    if([(NSArray*)adImageArrayObj count] < 1){
        return;
    }
    
    NSString* adImageURL = [(NSArray*)adImageArrayObj objectAtIndex:0];
    [self downloadAdImage:adImageURL];*/
    [self downloadAdImage:nil];
}

-(void)downloadAdImage : (NSString*)imageUrl{
    /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://120.27.47.167:8080/Shangbao01/WEB-SRC/picture/crawlerPic/sim/20150202204729696IFENGGuoNei_2015020200010001.jpg" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self adImageSave:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@", error);
    }];*/
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://120.27.47.167:8080/Shangbao01/WEB-SRC/picture/crawlerPic/sim/20150202204729696IFENGGuoNei_2015020200010001.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [self adImageSave:filePath];
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

-(void)adImageSave : (NSURL*)imagePath{
    NSError* error;
    NSString* adImageName = @"advertisePic.jpg";
    //NSLog(@"%@", [imageObj class]);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    //1、参数NSDocumentDirectory要获取的那种路径
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //2、得到相应的Documents的路径
    NSString* documentDirectory = [paths objectAtIndex:0];
    
    NSString *path = [documentDirectory stringByAppendingPathComponent:adImageName];
    
    NSString* formalPath = [OfflineCacher getObjForKey:@"adImagePath"];
    [fileManager changeCurrentDirectoryPath:formalPath];
    
    if(imagePath == nil || path == nil){
        return;
    }
    
    if([fileManager fileExistsAtPath:adImageName]){
        [fileManager removeItemAtPath:adImageName error:nil];
    }
    
    if(![fileManager moveItemAtURL:imagePath toURL:[NSURL fileURLWithPath:path] error:&error]){
        NSLog(@"移动失败");
        NSLog(@"%@", error);
    }
    
    [OfflineCacher cacheObj:documentDirectory forKey:@"adImagePath"];
}

-(BOOL)isNetworkStatusSupportAdLoad{
    Reachability *r = [Reachability reachabilityWithHostName:ServerBaseURLStringStatic];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            NSLog(@"正在使用wifi网络");
            break;
        default:
            break;
    }
    return YES;
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(AdvertisementManager *)getInstance{
    @synchronized(self){
        if (!advertisementManagerSigliton) {
            advertisementManagerSigliton = [[self alloc] init];
        }
    }
    return advertisementManagerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!advertisementManagerSigliton) {
            advertisementManagerSigliton = [super allocWithZone:zone];
            return advertisementManagerSigliton;
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