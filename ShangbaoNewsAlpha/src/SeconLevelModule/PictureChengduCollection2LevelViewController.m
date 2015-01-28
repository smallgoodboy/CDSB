//
//  PictureChengduCollection2LevelViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduCollection2LevelViewController.h"

#import "PictureChengduCollection2levelBackDataController.h"
#import "PictureChengdu2LevelCollectionViewCell.h"

#import "EssayContentViewController.h"

@interface PictureChengduCollection2LevelViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    PictureChengduCollection2levelBackDataController* pictureChengduCollection2levelBackDataControllerInstance;
    
}


@end

@implementation PictureChengduCollection2LevelViewController

- (void)viewDidLoad {
    pictureChengduCollection2levelBackDataControllerInstance = [PictureChengduCollection2levelBackDataController getInstance];
    [pictureChengduCollection2levelBackDataControllerInstance initBackDataController:self collectionView:self.frontCollectionView];
    super.frontCollectionViewBackCache = self.frontCollectionView;
    super.backDataBaseControllerInstance = pictureChengduCollection2levelBackDataControllerInstance;
    [super viewDidLoad];
    
    self.frontCollectionView.delegate = self;
    self.frontCollectionView.dataSource = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [pictureChengduCollection2levelBackDataControllerInstance getSectionOrRowCount];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PictureChengdu2LevelCollectionCell";
    PictureChengdu2LevelCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    BackDataNode* node = [pictureChengduCollection2levelBackDataControllerInstance getNodeInRow:indexPath.row];
    [cell setContent:node];
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}

/*-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [pictureChengduCollection2levelBackDataControllerInstance clearBackData];
    [self.frontCollectionView reloadData];
}*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    NSInteger selectedSection = [[self.frontCollectionView indexPathsForSelectedItems][0] section];
    NSInteger selectedRow = [[self.frontCollectionView indexPathsForSelectedItems][0] row];
    if ([viewController isKindOfClass:[EssayContentViewController class]]){
        EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
        BackDataNode* node = [pictureChengduCollection2levelBackDataControllerInstance getNodeInRow:selectedRow];
        [essayViewController setUrlToOpen: [node getNodeArticleURL]];
    }
    //NSLog(@"page open");
}

@end
