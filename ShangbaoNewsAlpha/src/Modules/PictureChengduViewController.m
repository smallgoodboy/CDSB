//
//  PictureChengduViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduViewController.h"
#import "PictureChengduBackDataController.h"
#import "StaticResourceManager.h"
#import "PictureChengduTableViewCell.h"
#import "PictureChengduSecondLevelBackDataController.h"
#import "PictureChengduSecondLevelViewController.h"
#import "EssayContentViewController.h"
#import "UserBackDataManager.h"
#import "NavigationContorllerManager.h"

@interface PictureChengduViewController ()<UITableViewDataSource, UITableViewDelegate>{
    PictureChengduBackDataController* pictureChengduBackDataControllerInstance;
}

@end


@implementation PictureChengduViewController

- (void)viewDidLoad {
    pictureChengduBackDataControllerInstance = [PictureChengduBackDataController getInstance];
    [pictureChengduBackDataControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = pictureChengduBackDataControllerInstance;
    [super viewDidLoad];
    
    self.frontPullRefreshTableView.delegate = self;
    self.frontPullRefreshTableView.dataSource = self;
    
    [NavigationContorllerManager addANavigationController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [pictureChengduBackDataControllerInstance getSectionOrRowCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [pictureChengduBackDataControllerInstance getRowCountOfSection:section]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell;
    BackDataNode* node = [pictureChengduBackDataControllerInstance getNodeInSection:indexPath.section andRow:indexPath.row];
    if(node != nil){
        cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PictureChengduTableViewCellIdentifierStringStatic];
        [(PictureChengduTableViewCell*)cell setContent:node];
    }else{
        cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PublicContentLoadMoreCellIdentifierStringStatic];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BackDataNode* node = [pictureChengduBackDataControllerInstance getNodeInSection: indexPath.section andRow:indexPath.row];
    if(node){
        return 120;
    }else{
        return 40;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [pictureChengduBackDataControllerInstance getColumnNameOfSection:section];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    NSInteger selectedSection = [[self.frontPullRefreshTableView indexPathForSelectedRow] section];
    NSInteger selectedRow = [[self.frontPullRefreshTableView indexPathForSelectedRow] row];
    if([viewController isKindOfClass:[PictureChengduSecondLevelViewController class]]){
        PictureChengduSecondLevelViewController* pictureChengdu2LevelViewController = (PictureChengduSecondLevelViewController*)viewController;
        
        //[ setNavigationBarTitleString:[publicContentBackDataControllerInstance getColumnNameOfSection:selectedSection]];
        [PictureChengduSecondLevelBackDataController getInstance].moduleURLString = [NSString stringWithFormat:@"%@/%@", [pictureChengduBackDataControllerInstance moduleURLString], [pictureChengduBackDataControllerInstance getColumnEnglishNameOfSection:selectedSection]];
    }else if ([viewController isKindOfClass:[EssayContentViewController class]]){
        EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
        BackDataNode* node = [pictureChengduBackDataControllerInstance getNodeInSection:selectedSection andRow:selectedRow];
        [essayViewController setUrlToOpen: [node getNodeArticleURL]];
    }
    //NSLog(@"page open");
}

- (IBAction)pictureUploadClicked:(id)sender {
    if([[UserBackDataManager getInstance] isUserLogin]){
        [self performSegueWithIdentifier:PictureUploadSegueNameStringStatic sender:self];
    }else{
        [self performSegueWithIdentifier:UserAdviseToLoginSegueNameStringStatic sender:self];
    }
}
@end
