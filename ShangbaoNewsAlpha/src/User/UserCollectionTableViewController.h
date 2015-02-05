//
//  UserCollectionTableViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshTableViewController.h"

@interface UserCollectionTableViewController : PullRefreshTableViewController

@property (weak, nonatomic) IBOutlet PullTableView *frontPullRefreshTableView;

@end
