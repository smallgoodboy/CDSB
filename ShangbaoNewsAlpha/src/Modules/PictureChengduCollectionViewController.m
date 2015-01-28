//
//  PictureChengduCollectionViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduCollectionViewController.h"
#import "PictureChengduCollectionBackDataController.h"
#import "PictureChengduCollectionViewCell.h"
#import "PictureChengduCollection2LevelViewController.h"
#import "PictureChengduCollection2levelBackDataController.h"

#import "UserBackDataManager.h"
#import "StaticResourceManager.h"
#import "NavigationContorllerManager.h"

@interface PictureChengduCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    PictureChengduCollectionBackDataController* pictureChengduCollectionBackDataControllerInstance;
}

@end

@implementation PictureChengduCollectionViewController

- (void)viewDidLoad {
    pictureChengduCollectionBackDataControllerInstance = [PictureChengduCollectionBackDataController getInstance];
    [pictureChengduCollectionBackDataControllerInstance initBackDataController:self collectionView:self.frontCollectionView];
    super.frontCollectionViewBackCache = self.frontCollectionView;
    super.backDataBaseControllerInstance = pictureChengduCollectionBackDataControllerInstance;
    [super viewDidLoad];
    
    self.frontCollectionView.delegate = self;
    self.frontCollectionView.dataSource = self;
    
    [NavigationContorllerManager addANavigationController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [pictureChengduCollectionBackDataControllerInstance getSectionOrRowCount];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"PictureChengduCollectionCell";
    PictureChengduCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setContent:[pictureChengduCollectionBackDataControllerInstance getColumnNameOfSection:indexPath.row] withImage:[pictureChengduCollectionBackDataControllerInstance get1stImageOfSection:indexPath.row] ];
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UIViewController* viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    
    //如果不是collection view的点击事件
    NSArray* indexPathArray = [self.frontCollectionView indexPathsForSelectedItems];
    if(indexPathArray == nil || [indexPathArray isKindOfClass:[NSNull class]] || [indexPathArray count] == 0){
        return;
    }
    NSIndexPath *nextIndexPath = [indexPathArray objectAtIndex:0];
    
    NSInteger selectedSection = nextIndexPath.section;
    NSInteger selectedRow = nextIndexPath.row;
    if([viewController isKindOfClass:[PictureChengduCollection2LevelViewController class]]){
        PictureChengduCollection2LevelViewController* pictureChengduCollection2LevelViewController = (PictureChengduCollection2LevelViewController*)viewController;
        
        //[ setNavigationBarTitleString:[publicContentBackDataControllerInstance getColumnNameOfSection:selectedSection]];
        [PictureChengduCollection2levelBackDataController getInstance].moduleURLString = [NSString stringWithFormat:@"%@/%@", [pictureChengduCollectionBackDataControllerInstance moduleURLString], [pictureChengduCollectionBackDataControllerInstance getColumnEnglishNameOfSection:selectedRow]];
        //NSLog(@"%@",[PictureChengduCollection2levelBackDataController getInstance].moduleURLString);
    }
}


- (IBAction)uploadClicked:(id)sender {
    if([[UserBackDataManager getInstance] isUserLogin]){
        [self performSegueWithIdentifier:PictureUploadSegueNameStringStatic sender:self];
    }else{
        [self performSegueWithIdentifier:UserAdviseToLoginSegueNameStringStatic sender:self];
    }
}
@end
