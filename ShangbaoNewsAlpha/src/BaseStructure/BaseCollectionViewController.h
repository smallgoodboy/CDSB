//
//  BaseCollectionViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackDataCollectionViewController.h"
#import "RootDecoratorCollectionViewController.h"

@interface BaseCollectionViewController : RootDecoratorCollectionViewController{
    
    BOOL isViewAppear;
    
}

@property UICollectionView* frontCollectionViewBackCache;
@property BackDataCollectionViewController* backDataBaseControllerInstance;

-(BOOL)isViewAppearInTabBar;

@end
