//
//  PublicContent2LevelViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContent2LevelViewController.h"
#import "PublicContent2LevelBackDataController.h"
#import "StaticResourceManager.h"
#import "PublicContentWith0ImageTableViewCell.h"
#import "PublicContentWith1ImageTableViewCell.h"
#import "PublicContentWith3ImageTableViewCell.h"

#import "EssayContentViewController.h"

@interface PublicContent2LevelViewController ()<UITableViewDelegate, UITableViewDataSource>{
    PublicContent2LevelBackDataController* publicContent2LevelViewControllerInstance;
}


@end

@implementation PublicContent2LevelViewController



- (void)viewDidLoad {
    publicContent2LevelViewControllerInstance = [PublicContent2LevelBackDataController getInstance];
    [publicContent2LevelViewControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = publicContent2LevelViewControllerInstance;
    [super viewDidLoad];
    
    self.frontPullRefreshTableView.delegate = self;
    self.frontPullRefreshTableView.dataSource = self;
    
    //self.topCuteNavigationItem.title = navigationBarTitleString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [publicContent2LevelViewControllerInstance getSectionOrRowCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BackDataNode* node = [publicContent2LevelViewControllerInstance getNodeInRow:indexPath.row];
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
        cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier: PublicContentLoadMoreCellIdentifierStringStatic];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BackDataNode* node = [publicContent2LevelViewControllerInstance getNodeInRow:indexPath.row];
    if(node){
        if([node getImageNumber] >= 3){
            return 122;
        }else{
            return 87;
        }
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)backClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    NSInteger selectedRow = [[self.frontPullRefreshTableView indexPathForSelectedRow] row];
    if ([viewController isKindOfClass:[EssayContentViewController class]]){
        EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
        BackDataNode* node = [publicContent2LevelViewControllerInstance getNodeInRow:selectedRow];
        [essayViewController setUrlToOpen: [node getNodeArticleURL]];
    }

}
@end
