//
//  ShangbaoOriginViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "ShangbaoOriginViewController.h"
#import "ShangbaoOriginBackDataController.h"
#import "StaticResourceManager.h"
#import "ShangbaoOriginTableViewCell.h"
#import "ShangbaoOriginWith0ImageTableViewCell.h"
#import "EssayContentViewController.h"
#import "IQKeyboardManager.h"
#import "UserBackDataManager.h"
#import "ShangbaoOriginShareBaseTableViewCell.h"

#import "NavigationContorllerManager.h"

#import "UserAlreadyLogedInViewController.h"
#import "UserLoginViewController.h"

#import "UserManager.h"

@interface ShangbaoOriginViewController ()<UITableViewDataSource, UITableViewDelegate>{
    ShangbaoOriginBackDataController* shangbaoOriginBackDataControllerInstance;
}


@end

@implementation ShangbaoOriginViewController

- (void)viewDidLoad {
    shangbaoOriginBackDataControllerInstance = [ShangbaoOriginBackDataController getInstance];
    [shangbaoOriginBackDataControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = shangbaoOriginBackDataControllerInstance;
    [super viewDidLoad];
    
    self.frontPullRefreshTableView.delegate = self;
    self.frontPullRefreshTableView.dataSource = self;
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 5;
    
    [NavigationContorllerManager addANavigationController:self.navigationController];
    [[NavigationContorllerManager getInstance] setShangbaoOrignViewControllerInstance:self];
    
    [[UserManager getInstance] getUserInfo];
    [self processNotifyIssue];
}

-(void)processNotifyIssue{
    if([shangbaoOriginBackDataControllerInstance notifyNewsIDInt] != -1){
        [self.navigationController.tabBarController setSelectedIndex:0];
        [self performSegueWithIdentifier:ShangbaoOriginNotifyToShowSegueNameStringStatic sender:self];
    }
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
    return [shangbaoOriginBackDataControllerInstance getSectionOrRowCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    BackDataNode* node = [shangbaoOriginBackDataControllerInstance getNodeInRow:indexPath.row];
    
    if(node.getImageNumber == 0){
        cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:ShangbaoOringinTableViewCellWith0ImageIdentifierStringStatic];
        [(ShangbaoOriginWith0ImageTableViewCell*)cell setContent:node];
    }else{
        cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:ShangbaoOringinTableViewCellIdentifierStringStatic];
        [(ShangbaoOriginTableViewCell*)cell setContent:node];
    }
    [(ShangbaoOriginShareBaseTableViewCell*)cell setViewControllerToShow:self];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    //NSInteger selectedSection = [[self.frontPullRefreshTableView indexPathForSelectedRow] section];
    viewController.hidesBottomBarWhenPushed = YES;
    NSIndexPath* indexPathOfClicked = [self.frontPullRefreshTableView indexPathForSelectedRow];
    if(indexPathOfClicked){
        NSInteger selectedRow = [indexPathOfClicked row];
        if ([viewController isKindOfClass:[EssayContentViewController class]]){
            EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
            BackDataNode* node = [shangbaoOriginBackDataControllerInstance getNodeInRow:selectedRow];
            [essayViewController setUrlToOpen: [node getNodeArticleURL]];
        }
    }else if([viewController isKindOfClass:[UserAlreadyLogedInViewController class]] ||[viewController isKindOfClass:[UserLoginViewController class]]){
        
    }else{
        if([shangbaoOriginBackDataControllerInstance notifyNewsIDInt] != -1){
            EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
            [essayViewController setUrlToOpen: [NSString stringWithFormat:@"%@/%ld",ArticleBaseURLStringStatic, (long)[shangbaoOriginBackDataControllerInstance notifyNewsIDInt]]];
        }
    }
    //NSLog(@"page open");
}
- (IBAction)userInfoClicked:(id)sender {
    if([[UserBackDataManager getInstance] isUserLogin]){
        [self performSegueWithIdentifier:UserStatusLoginSegueNameStringStatic sender:self];
    }else{
        [self performSegueWithIdentifier:UserStatusNotLoginSegueNameStringStatic sender:self];
    }
    
}
@end
