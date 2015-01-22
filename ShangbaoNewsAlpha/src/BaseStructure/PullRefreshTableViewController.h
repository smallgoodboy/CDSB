//
//  PullRefreshTableViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "BackDataBaseController.h"
#import "RootDecoratorViewController.h"
#import "RootDecoratorTableViewController.h"

@interface PullRefreshTableViewController : RootDecoratorTableViewController{
    
    BOOL isViewAppear;
    
}

@property PullTableView* frontPullTableViewBackCache;
@property BackDataBaseController* backDataBaseControllerInstance;

-(BOOL)isViewAppearInTabBar;

@end
