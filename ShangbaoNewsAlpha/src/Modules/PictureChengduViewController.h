//
//  PictureChengduViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshTableViewController.h"

@interface PictureChengduViewController : PullRefreshTableViewController
@property (weak, nonatomic) IBOutlet PullTableView *frontPullRefreshTableView;
- (IBAction)pictureUploadClicked:(id)sender;

@end
