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
#import "UserBackDataManager.h"
#import "ShangbaoOriginBackDataController.h"
#import "UserManager.h"
#import "OfflineCacher.h"

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
    
    if([selectedModuleNameString isEqualToString:NewestInfoNameKeyStringStatic]){
        
        
        [[NavigationContorllerManager getInstance] setNotifyNavigationStartViewControllerInstance:self];
        
        [[UserManager getInstance] getUserInfo];
        if(![self processNotifyIssue]){
            [self adProcessor];
        }
    }
}

-(void)adProcessor{
    
    NSString* adImageName = @"advertisePic.jpg";
    //NSLog(@"%@", [imageObj class]);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取路径
    //1、参数NSDocumentDirectory要获取的那种路径
    NSArray*  paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //2、得到相应的Documents的路径
    NSString* documentDirectory = [paths objectAtIndex:0];
    
    //3、更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentDirectory stringByExpandingTildeInPath]];
    NSString *path = [documentDirectory stringByAppendingPathComponent:adImageName];
    
    NSString* formalPath = [OfflineCacher getObjForKey:@"adImagePath"];
    path = [formalPath stringByAppendingPathComponent:adImageName];
    UIImage* adImage = [UIImage imageWithContentsOfFile:path];
    
    
    CGRect adFrame = CGRectMake(0, 0, 320, 480);
    UIImageView* adImageView = [[UIImageView alloc] initWithFrame:adFrame];
    [adImageView setImage:adImage];
    [self.tabBarController.view addSubview:adImageView];
    
    [UIView animateWithDuration:2.0 animations:^{
        [adImageView setAlpha:0.99];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 animations:^{
            [adImageView setAlpha:0];
        } completion:^(BOOL finished){
            [adImageView removeFromSuperview];
        }];
    }];
    
}

-(BOOL)processNotifyIssue{
    if([(NewestInfoBackDataController*)publicContentBackDataControllerInstance notifyNewsIDInt] != -1){
        [self.navigationController.tabBarController setSelectedIndex:0];
        [self performSegueWithIdentifier:NewsNotifiedToShowSegueNameStringStatic sender:self];
        return true;
    }
    return false;
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
        if([self.frontPullRefreshTableView indexPathForSelectedRow]){
            [essayViewController setUrlToOpen: [node getNodeArticleURL]];
        }else{
            if([(NewestInfoBackDataController*)publicContentBackDataControllerInstance notifyNewsIDInt] != -1){
                EssayContentViewController* essayViewController = (EssayContentViewController*)viewController;
                [essayViewController setUrlToOpen: [NSString stringWithFormat:@"%@/%ld",ArticleBaseURLStringStatic, (long)[(NewestInfoBackDataController*)publicContentBackDataControllerInstance notifyNewsIDInt]]];
            }
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
