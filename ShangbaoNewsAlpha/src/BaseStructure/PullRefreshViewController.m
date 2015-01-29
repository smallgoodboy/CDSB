//
//  PullRefreshViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-13.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshViewController.h"
#import "RootDecoratorNavigationController.h"
#import "StaticResourceManager.h"

@interface PullRefreshViewController ()<PullTableViewDelegate>

@end

@implementation PullRefreshViewController{
    BOOL isFirstRefresh;
    NSDate* lastRefreshDate;
}

@synthesize frontPullTableViewBackCache;
@synthesize backDataBaseControllerInstance;


- (void)viewDidLoad {
    isFirstRefresh = YES;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [(RootDecoratorNavigationController*)self.navigationController setActionTakeBeforeBack:self selector:@selector(clearTableBeforeBack)];
    
    frontPullTableViewBackCache.pullDelegate = self;
    
    frontPullTableViewBackCache.pullArrowImage = [UIImage imageNamed:@"blackArrow"];
    frontPullTableViewBackCache.pullBackgroundColor = [UIColor yellowColor];
    frontPullTableViewBackCache.pullTextColor = [UIColor blackColor];
    lastRefreshDate = [[NSDate alloc] initWithTimeIntervalSince1970:0];
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
    lastRefreshDate = [NSDate date];
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
    if ([lastRefreshDate timeIntervalSinceNow] <= AutoRefreshTimeIntervalSecondInt) {
        if(!frontPullTableViewBackCache.pullTableIsRefreshing) {
            [self.frontPullTableViewBackCache setContentOffset:CGPointMake(0, 0) animated:NO];
            frontPullTableViewBackCache.pullTableIsRefreshing = YES;
            [self refreshTable];
        }
    }
    isViewAppear = true;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    isViewAppear = false;
}

-(void)clearTableBeforeBack{
    [backDataBaseControllerInstance clearBackData];
}


@end
