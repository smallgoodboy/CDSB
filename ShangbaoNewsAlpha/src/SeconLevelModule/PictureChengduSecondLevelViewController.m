//
//  PictureChengduSecondLevelViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-12.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduSecondLevelViewController.h"
#import "PictureChengduSecondLevelBackDataController.h"
#import "StaticResourceManager.h"
#import "PictureChengduTableViewCell.h"
#import "EssayContentViewController.h"

@interface PictureChengduSecondLevelViewController ()<UITableViewDelegate, UITableViewDataSource>{
    PictureChengduSecondLevelBackDataController* pictureChengduSecondLevelBackDataControllerInstance;
}


@end

@implementation PictureChengduSecondLevelViewController

- (void)viewDidLoad {
    

        pictureChengduSecondLevelBackDataControllerInstance = [PictureChengduSecondLevelBackDataController getInstance];

    [pictureChengduSecondLevelBackDataControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = pictureChengduSecondLevelBackDataControllerInstance;
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
    return [pictureChengduSecondLevelBackDataControllerInstance getSectionOrRowCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PictureChengduTableViewCell *cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:PictureChengduTableViewCellIdentifierStringStatic];
    BackDataNode* node = [pictureChengduSecondLevelBackDataControllerInstance getNodeInRow:indexPath.row];
    [cell setContent:node];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;
    viewController.hidesBottomBarWhenPushed = YES;
    //NSInteger selectedSection = [[self.frontPullRefreshTableView indexPathForSelectedRow] section];
    NSInteger selectedRow = [[self.frontPullRefreshTableView indexPathForSelectedRow] row];
    if ([viewController isKindOfClass:[EssayContentViewController class]]){
        EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
        BackDataNode* node = [pictureChengduSecondLevelBackDataControllerInstance getNodeInRow:selectedRow];
        [essayViewController setUrlToOpen: [node getNodeArticleURL]];
    }
    //NSLog(@"page open");
}



- (IBAction)backClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
