//
//  PictureChengduSecondLevelViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-12.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshTableViewController.h"

@interface PictureChengduSecondLevelViewController : PullRefreshTableViewController

- (IBAction)backClicked:(id)sender;
@property (weak, nonatomic) IBOutlet PullTableView *frontPullRefreshTableView;
@end
