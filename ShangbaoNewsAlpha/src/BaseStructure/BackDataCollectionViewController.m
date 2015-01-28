//
//  BackDataCollectionViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataCollectionViewController.h"
#import "BaseCollectionViewController.h"
#import "MainBackDataLoader.h"
#import "AFNetworking.h"
#import "OfflineCacher.h"

@implementation BackDataCollectionViewController{
    BOOL isRefreshingTableAndNotLoadingMore;
    NSInteger refreshTimeCounter;
}

@synthesize moduleURLString;
@synthesize frontCollectionView;
@synthesize frontViewController;

-(void)initBackDataController : (id)frontViewControllerInstance collectionView : (UICollectionView*)collectionView{
    frontViewController = frontViewControllerInstance;
    frontCollectionView = collectionView;
    
    refreshTimeCounter = 0;
}

-(void)reloadBackData{
    pageLoadednumber = 1;
    //[backDataArray removeAllObjects];
    isRefreshingTableAndNotLoadingMore = YES;
    [self loadBackData];
}

-(void)reloadBackData : (NSString*)moduleURLStringTemp{
    [self setModuleURLString:moduleURLStringTemp];
    if([(BaseCollectionViewController*)frontViewController isViewAppearInTabBar]){
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

//问题： 网卡的时候会所有的请求堆在一起，需要解决？
//是不是所有的网络请求都需要？
-(void)getModuleServerData : (NSString*)contentURLString{
    refreshTimeCounter++;
    NSInteger tempRefreshTimeCounter = refreshTimeCounter;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 3.0f;
    [manager GET:contentURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Modlue json got!");
        if(tempRefreshTimeCounter != refreshTimeCounter){
            return;
        }
        [OfflineCacher cacheObj:responseObject forKey:contentURLString];
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
    [self.frontCollectionView reloadData];
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
