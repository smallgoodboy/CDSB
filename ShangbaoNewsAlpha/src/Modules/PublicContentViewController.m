//
//  PublicContentViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContentViewController.h"
#import "StaticResourceManager.h"
#import "PublicContentBackDataController.h"
#import "LocalReportBackDataController.h"
#import "NewestInfoBackDataController.h"
#import "StaticResourceManager.h"

#import "PublicContentWith0ImageTableViewCell.h"
#import "PublicContentWith1ImageTableViewCell.h"
#import "PublicContentWith3ImageTableViewCell.h"

#import "PublicContent2LevelViewController.h"
#import "PublicContent2LevelBackDataController.h"

#import "EssayContentViewController.h"

#import "NavigationContorllerManager.h"

@interface PublicContentViewController ()<UITableViewDelegate, UITableViewDataSource>{
    PublicContentBackDataController* publicContentBackDataControllerInstance;
}


@end

@implementation PublicContentViewController

- (void)viewDidLoad {
    
    UINavigationController* navigationController = (UINavigationController*)self.parentViewController;
    NSString* selectedModuleNameString = navigationController.tabBarItem.title;
    if([selectedModuleNameString isEqualToString:NewestInfoNameKeyStringStatic]){
        publicContentBackDataControllerInstance = [NewestInfoBackDataController getInstance];
    }else if([selectedModuleNameString isEqualToString:LocalReportNameKeyStringStatic]){
        publicContentBackDataControllerInstance = [LocalReportBackDataController getInstance];
    }
    [publicContentBackDataControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = publicContentBackDataControllerInstance;
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
    return [publicContentBackDataControllerInstance getSectionOrRowCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [publicContentBackDataControllerInstance getRowCountOfSection:section]+2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BackDataNode* node = [publicContentBackDataControllerInstance getNodeInSection:indexPath.section andRow:indexPath.row];
    UITableViewCell* cell;
    if(node != nil){
        switch([node getImageNumber]){
            case 0:
                cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PublicContent0ImageTableViewCellIdentifierStringStatic];
                [(PublicContentWith0ImageTableViewCell*)cell setContent:node];
                break;
            case 2:
            case 1:
                cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PublicContent1ImageTableViewCellIdentifierStringStatic];
                [(PublicContentWith1ImageTableViewCell*)cell setContent:node];
                break;
            case 3:
                cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PublicContent3ImageTableViewCellIdentifierStringStatic];
                [(PublicContentWith3ImageTableViewCell*)cell setContent:node];
                break;
            default:
                if([node getImageNumber] >= 3){
                    cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PublicContent3ImageTableViewCellIdentifierStringStatic];
                    [(PublicContentWith3ImageTableViewCell*)cell setContent:node];
                    break;
                }
        }
    }else{
        if(indexPath.row == [publicContentBackDataControllerInstance getRowCountOfSection:indexPath.section]){
            cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier: PublicContentLoadMoreCellIdentifierStringStatic];
        }else{
            cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier: SeperatorCellIdentifierStringStatic];
        }
    }
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BackDataNode* node = [publicContentBackDataControllerInstance getNodeInSection: indexPath.section andRow:indexPath.row];
    if(node){
        if([node getImageNumber] == 3){
            return 115;
        }else{
            return 80;
        }
    }else{
        if(indexPath.row == [publicContentBackDataControllerInstance getRowCountOfSection:indexPath.section]){
            return 40;
        }else{
            return 15;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [publicContentBackDataControllerInstance getColumnNameOfSection:section];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    NSInteger selectedSection = [[self.frontPullRefreshTableView indexPathForSelectedRow] section];
    NSInteger selectedRow = [[self.frontPullRefreshTableView indexPathForSelectedRow] row];
    if([viewController isKindOfClass:[PublicContent2LevelViewController class]]){
        PublicContent2LevelViewController* publicContentSecondLevelViewController = (PublicContent2LevelViewController*)viewController;
        
        [publicContentSecondLevelViewController setNavigationBarTitleString:[publicContentBackDataControllerInstance getColumnNameOfSection:selectedSection]];
        
        [PublicContent2LevelBackDataController getInstance].moduleURLString = [NSString stringWithFormat:@"%@/%@", [publicContentBackDataControllerInstance moduleURLString], [publicContentBackDataControllerInstance getColumnEnglishNameOfSection:selectedSection]];
    }else if ([viewController isKindOfClass:[EssayContentViewController class]]){
        EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
        BackDataNode* node = [publicContentBackDataControllerInstance getNodeInSection:selectedSection andRow:selectedRow];
        [essayViewController setUrlToOpen: [node getNodeArticleURL]];
    }
    //NSLog(@"page open");
}

@end
