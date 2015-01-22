//
//  MainBackDataLoader.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainBackDataLoader : NSObject

@property NSString* shangbaoOriginContentURLString;
@property NSString* newestInfoContentURLString;
@property NSString* localReportContentURLString;
@property NSString* pictureChengduContentURLString;

+(MainBackDataLoader*)getInstance;

-(void)loadMainPage;
-(void)analyseMainPage :(id)mainPageObj;

- (NSString*) getUrlFrom :(NSMutableDictionary*) dict andKey: (NSString*)key andBaseUrl: (NSString*) base;

@end
