//
//  BackDataBaseController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataBaseController.h"
#import "AFNetworking.h"
#import "PullRefreshTableViewController.h"
#import "MainBackDataLoader.h"
#import "PopOverHintManager.h"

#import "OfflineCacher.h"

@implementation BackDataBaseController{
    BOOL isRefreshingTableAndNotLoadingMore;
}

@synthesize moduleURLString;
@synthesize frontTableView;
@synthesize frontViewController;

-(void)initBackDataController : (id)frontViewControllerInstance tableView : (PullTableView*)tableview{
    frontViewController = frontViewControllerInstance;
    frontTableView = tableview;
}

-(void)reloadBackData{
    pageLoadednumber = 1;
    //[backDataArray removeAllObjects];
    isRefreshingTableAndNotLoadingMore = YES;
    [self loadBackData];
}

-(void)reloadBackData : (NSString*)moduleURLStringTemp{
    [self setModuleURLString:moduleURLStringTemp];
    if([(PullRefreshTableViewController*)frontViewController isViewAppearInTabBar]){
        pageLoadednumber = 1;
        [backDataArray removeAllObjects];
        [self loadBackData];
        isRefreshingTableAndNotLoadingMore = YES;
    }
}

-(void)reloadBackDataWithoutTestShow:(NSString *)moduleURLStringTemp{
    [self setModuleURLString:moduleURLStringTemp];
    pageLoadednumber = 1;
    //[backDataArray removeAllObjects];
    isRefreshingTableAndNotLoadingMore = YES;
    [self loadBackData];
}

-(void)loadOnePageMore{
    pageLoadednumber++;
    if(pageLoadednumber > pageTotalNumber){
        pageLoadednumber--;
        return;
    }
    isRefreshingTableAndNotLoadingMore = NO;
    [self loadBackData];
}

-(void)loadBackData{
    if(moduleURLString){
        if(isModuleUsePaging){
            [self getModuleServerData:[NSString stringWithFormat:@"%@/%d", moduleURLString, pageLoadednumber]];
        }else{
            [self getModuleServerData:moduleURLString];
        }
    }else{
        [[MainBackDataLoader getInstance] loadMainPage];
    }
}

-(void)getModuleServerData : (NSString*)contentURLString{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:contentURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [OfflineCacher cacheObj:responseObject forKey:contentURLString];
        NSLog(@"Modlue json got!");
        if(isRefreshingTableAndNotLoadingMore){
            [backDataArray removeAllObjects];
        }
        [self analyseModuleServerData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        pageLoadednumber--;
        NSLog(@"Error: %@", error);
        
        if(isRefreshingTableAndNotLoadingMore){
            [backDataArray removeAllObjects];
        }
        [self analyseModuleServerData:[OfflineCacher getObjForKey:contentURLString]];
    }];
}

-(void)analyseModuleServerData : (id)backDataObj{}

-(void)clearBackData{
    [backDataArray removeAllObjects];
    [self.frontTableView reloadData];
}


-(NSInteger)getSectionOrRowCount{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    
    return [backDataArray count];
}

-(NSInteger)getRowCountOfSection : (NSInteger)section{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    if(section >= [backDataArray count]){
        return 0;
    }
    if([backDataArray[section] isKindOfClass:[BackDataColumn class]]){
        return [(BackDataColumn*)backDataArray[section] getNodeCount];
    }else{
        return 0;
    }
}

-(BackDataNode*)getNodeInSection : (NSInteger)section andRow : (NSInteger)row{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    if(section >= [backDataArray count]){
        return nil;
    }
    if([backDataArray[section] isKindOfClass:[BackDataColumn class]]){
        return [(BackDataColumn*)backDataArray[section] getNodeAtOffset:row];
    }else{
        return nil;
    }
}

-(BackDataNode*)getNodeInRow : (NSInteger)row{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    if(row >= [backDataArray count]){
        return nil;
    }
    if([backDataArray[row] isKindOfClass:[BackDataNode class]]){
        return backDataArray[row];
    }else{
        return  nil;
    }
}

-(void)addAnSection : (BackDataColumn*)column{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    [backDataArray addObject:column];
}

-(void)addANode : (BackDataNode*)node{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    [backDataArray addObject:node];
}

-(NSString*)getColumnNameOfSection : (NSInteger)section{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    if(section >= [backDataArray count]){
        return nil;
    }
    if([backDataArray[section] isKindOfClass:[BackDataColumn class]]){
        return [(BackDataColumn*)backDataArray[section] channelNameString];
    }else{
        return nil;
    }
}
-(NSString*)getColumnEnglishNameOfSection : (NSInteger)section{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    if(section >= [backDataArray count]){
        return nil;
    }
    if([backDataArray[section] isKindOfClass:[BackDataColumn class]]){
        return [(BackDataColumn*)backDataArray[section] channelEnglishNameString];
    }else{
        return nil;
    }
}

@end
