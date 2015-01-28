//
//  PictureChengduCollectionBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackDataCollectionViewController.h"

@interface PictureChengduCollectionBackDataController : BackDataCollectionViewController

+(PictureChengduCollectionBackDataController*)getInstance;

-(NSString*)get1stImageOfSection : (NSInteger)section;

@end
