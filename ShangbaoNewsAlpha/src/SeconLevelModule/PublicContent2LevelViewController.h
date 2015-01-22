//
//  PublicContent2LevelViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContentBackDataController.h"
#import "PullRefreshTableViewController.h"
#import "CuteFirstLevelNavigationBar.h"

@interface PublicContent2LevelViewController : PullRefreshTableViewController
@property (weak, nonatomic) IBOutlet PullTableView *frontPullRefreshTableView;
- (IBAction)backClicked:(id)sender;
@property (weak, nonatomic) IBOutlet CuteFirstLevelNavigationItem *topCuteNavigationItem;


@end
