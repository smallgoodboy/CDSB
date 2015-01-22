//
//  PullRefreshViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-13.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"
#import "PullTableView.h"
#import "BackDataBaseController.h"
#import "RootDecoratorViewController.h"
#import "RootDecoratorTableViewController.h"


@interface PullRefreshViewController : RootDecoratorViewController{
    
    BOOL isViewAppear;
    
}

@property PullTableView* frontPullTableViewBackCache;
@property BackDataBaseController* backDataBaseControllerInstance;

-(BOOL)isViewAppearInTabBar;


@end
