//
//  MainBackDataLoader.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "MainBackDataLoader.h"
#import "StaticResourceManager.h"
#import "AFNetworking.h"
#import "PopOverHintManager.h"
#import "ShangbaoOriginBackDataController.h"
#import "PictureChengduBackDataController.h"
#import "LocalReportBackDataController.h"
#import "NewestInfoBackDataController.h"

static MainBackDataLoader* mainBackDataLoaderSigliton;

@implementation MainBackDataLoader

@synthesize shangbaoOriginContentURLString;
@synthesize newestInfoContentURLString;
@synthesize localReportContentURLString;
@synthesize pictureChengduContentURLString;

-(void)loadMainPage{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:ServerHomePageURLStringStatic parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"main json got!");
        [[MainBackDataLoader getInstance] analyseMainPage: responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [PopOverHintManager showPopover:NetWorkDown];
        NSLog(@"Error: %@", error);
    }];
}

-(void)analyseMainPage:(id)mainPageObj{
    if([mainPageObj isKindOfClass:[NSDictionary class]]){
        NSLog(@"yes");
    }else{
        NSLog(@"no");
        return;
    }
    
    id arrayObj = [(NSDictionary* )mainPageObj objectForKey:@"channel"];
    if([arrayObj isKindOfClass:[NSArray class]]){
        NSLog(@"yes");
    }else{
        NSLog(@"no");
        return;
    }
    
    NSMutableDictionary* channelLookupDict = [[NSMutableDictionary alloc] init];
    for(id arrayContentObj in (NSArray*) arrayObj){
        if(![arrayContentObj isKindOfClass:[NSDictionary class]]){
            continue;
        }
        if(!([[((NSDictionary*)arrayContentObj) objectForKey:@"channelName"] isKindOfClass:[NSString class]]
             && [[((NSDictionary*)arrayContentObj) objectForKey:@"channelUrl"]  isKindOfClass:[NSString class]])){
            continue;
        }
        [channelLookupDict setValue:(NSString*)[((NSDictionary*)arrayContentObj) objectForKey:@"channelUrl"] forKey:(NSString*)[((NSDictionary*)arrayContentObj) objectForKey:@"channelName"]];
    }
    
    shangbaoOriginContentURLString = [self getUrlFrom:channelLookupDict andKey:ShangbaoOriginNameKeyStringStatic andBaseUrl:ServerBaseURLStringStatic];
    newestInfoContentURLString = [self getUrlFrom:channelLookupDict andKey:NewestInfoNameKeyStringStatic andBaseUrl:ServerBaseURLStringStatic];
    localReportContentURLString = [self getUrlFrom:channelLookupDict andKey:LocalReportNameKeyStringStatic andBaseUrl:ServerBaseURLStringStatic];
    pictureChengduContentURLString = [self getUrlFrom:channelLookupDict andKey:PictureChengduNameKeyStringStatic andBaseUrl:ServerBaseURLStringStatic];
    
    [[ShangbaoOriginBackDataController getInstance] reloadBackData:shangbaoOriginContentURLString];
    [[PictureChengduBackDataController getInstance] reloadBackData:pictureChengduContentURLString];
    [[LocalReportBackDataController getInstance] reloadBackData:localReportContentURLString];
    [[NewestInfoBackDataController getInstance] reloadBackData:newestInfoContentURLString];
}

- (NSString*) getUrlFrom :(NSMutableDictionary*) dict andKey: (NSString*)key andBaseUrl: (NSString*) base{
    id valueObj = [dict objectForKey:key];
    if(![valueObj isKindOfClass:[NSString class]]){
        return nil;
    }
    NSString * value = (NSString*)valueObj;
    value = [value stringByReplacingOccurrencesOfString:@"{phoneType}" withString:@"ios"];
    return [NSString stringWithFormat:@"%@%@", base, value];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(MainBackDataLoader *)getInstance{
    @synchronized(self){
        if (!mainBackDataLoaderSigliton) {
            mainBackDataLoaderSigliton = [[self alloc] init];
        }
    }
    return mainBackDataLoaderSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!mainBackDataLoaderSigliton) {
            mainBackDataLoaderSigliton = [super allocWithZone:zone]; 
            return mainBackDataLoaderSigliton;
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
