//
//  PublicContentViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshTableViewController.h"

@interface PublicContentViewController : PullRefreshTableViewController
@property (weak, nonatomic) IBOutlet PullTableView *frontPullRefreshTableView;
- (IBAction)userInfoClicked:(id)sender;
-(BOOL)processNotifyIssue;
@end
