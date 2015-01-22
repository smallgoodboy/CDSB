//
//  PullRefreshTableViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshTableViewController.h"

@interface PullRefreshTableViewController ()<PullTableViewDelegate>

@end

@implementation PullRefreshTableViewController{
    BOOL isFirstRefresh;
}

@synthesize frontPullTableViewBackCache;
@synthesize backDataBaseControllerInstance;


- (void)viewDidLoad {
    isFirstRefresh = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    frontPullTableViewBackCache.pullDelegate = self;
    
    frontPullTableViewBackCache.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    frontPullTableViewBackCache.pullBackgroundColor = [UIColor yellowColor];
    frontPullTableViewBackCache.pullTextColor = [UIColor blackColor];
    frontPullTableViewBackCache.pullLastRefreshDate = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh and load more methods

-(void)stopRefresh{
    frontPullTableViewBackCache.pullTableIsRefreshing = NO;
}

-(void)stopLoadMore{
    frontPullTableViewBackCache.pullTableIsLoadingMore = NO;
}

- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.
     
     */
    [backDataBaseControllerInstance reloadBackData];
    frontPullTableViewBackCache.pullLastRefreshDate = [NSDate date];
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:0.5];
}

- (void) loadMoreDataToTable
{
    /*
     
     Code to actually load more data goes here.
     
     */
    [backDataBaseControllerInstance loadOnePageMore];
    [self performSelector:@selector(stopLoadMore) withObject:nil afterDelay:0.5];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    
    [self refreshTable];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self loadMoreDataToTable];
}



-(BOOL)isViewAppearInTabBar{
    return isViewAppear;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![[[NSDate alloc] initWithTimeInterval:-3*60 sinceDate:[NSDate date]] laterDate:[frontPullTableViewBackCache pullLastRefreshDate]] || isFirstRefresh) {
        
        if(!frontPullTableViewBackCache.pullTableIsRefreshing) {
            frontPullTableViewBackCache.pullTableIsRefreshing = YES;
            [self refreshTable];
        }
        isFirstRefresh = NO;
    }
    isViewAppear = true;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    isViewAppear = false;
}



@end
