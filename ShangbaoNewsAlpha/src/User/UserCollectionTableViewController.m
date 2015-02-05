//
//  UserCollectionTableViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserCollectionTableViewController.h"
#import "UserCollectionBackDataController.h"
#import "EssayContentViewController.h"
#import "UserCollectionTableViewCell.h"
#import "StaticResourceManager.h"
#import "BackDataNode.h"

@interface UserCollectionTableViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UserCollectionBackDataController* userCollectionBackDataControllerInstance;
}

@end

@implementation UserCollectionTableViewController

- (void)viewDidLoad {
    userCollectionBackDataControllerInstance = [UserCollectionBackDataController getInstance];
    [userCollectionBackDataControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = userCollectionBackDataControllerInstance;
    [super viewDidLoad];
    
    self.frontPullRefreshTableView.delegate = self;
    self.frontPullRefreshTableView.dataSource = self;
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
    return [userCollectionBackDataControllerInstance getSectionOrRowCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCollectionTableViewCell *cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:UserCollectionTableViewCellIdentifierStringStatic];
    BackDataNode* node = [userCollectionBackDataControllerInstance getNodeInRow:indexPath.row];
    [cell setContent:node];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了删除");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BackDataNode* node = [userCollectionBackDataControllerInstance getNodeInRow:indexPath.row];
        [userCollectionBackDataControllerInstance deleteCollectedArticle:node.ariticleID withSuccessCallTarget:nil successCall:nil];
        [userCollectionBackDataControllerInstance removeNodeAtIndex:indexPath.row];
        [self.frontPullRefreshTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除收藏";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    NSInteger selectedRow = [[self.frontPullRefreshTableView indexPathForSelectedRow] row];
    if ([viewController isKindOfClass:[EssayContentViewController class]]){
        EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
        BackDataNode* node = [userCollectionBackDataControllerInstance getNodeInRow:selectedRow];
        //[essayViewController setUrlToOpen: @"http://120.27.47.167:8080/Shangbao01/app/ios/articledetail/1113"];
        [essayViewController setUrlToOpen: [node getNodeArticleURL]];
    }
    
}

@end
