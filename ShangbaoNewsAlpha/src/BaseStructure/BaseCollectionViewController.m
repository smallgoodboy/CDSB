//
//  BaseCollectionViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "MJRefresh.h"
#import "RootDecoratorNavigationController.h"
#import "StaticResourceManager.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController{
    BOOL isFirstRefresh;
    NSDate* lastRefreshDate;
}

@synthesize frontCollectionViewBackCache;
@synthesize backDataBaseControllerInstance;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    [(RootDecoratorNavigationController*)self.navigationController setActionTakeBeforeBack:self selector:@selector(clearTableBeforeBack)];
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    lastRefreshDate = [[NSDate alloc] initWithTimeIntervalSince1970:0];
    [self.collectionView addHeaderWithTarget:self action:@selector(collectionViewRefresh)];
    [self.collectionView addFooterWithTarget:self action:@selector(collectionViewLoadMore)];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectionViewRefresh{
    //NSLog(@"wawawa shuaxinla");
    lastRefreshDate = [NSDate date];
    [backDataBaseControllerInstance reloadBackData];
    [self.collectionView headerEndRefreshing];
}

-(void)collectionViewLoadMore{
    [backDataBaseControllerInstance loadOnePageMore];
    [self.collectionView footerEndRefreshing];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(BOOL)isViewAppearInTabBar{
    return isViewAppear;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //NSLog(@"%f",[lastRefreshDate timeIntervalSinceNow]);
    if ([lastRefreshDate timeIntervalSinceNow] <= AutoRefreshTimeIntervalSecondInt){
        isFirstRefresh = NO;
        [self.collectionView headerBeginRefreshing];
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
