//
//  BackDataBaseController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PullTableView.h"
#import "BackDataNode.h"
#import "BackDataColumn.h"



@interface BackDataBaseController : NSObject{
    NSMutableArray* backDataArray;
    int pageTotalNumber;
    int pageLoadednumber;
    BOOL isModuleUsePaging;
}

@property NSString* moduleURLString;
@property PullTableView* frontTableView;
@property id frontViewController;

-(void)initBackDataController : (id)frontViewControllerInstance tableView : (PullTableView*)tableview;

-(void)reloadBackData;
-(void)reloadBackData : (NSString*)moduleURLStringTemp;
-(void)reloadBackDataWithoutTestShow:(NSString *)moduleURLStringTemp;
-(void)loadOnePageMore;
-(void)loadBackData;
-(void)getModuleServerData : (NSString*)contentURLString;
-(void)analyseModuleServerData : (id)backDataObj;

-(void)clearBackData;

-(NSInteger)getSectionOrRowCount;
-(NSInteger)getRowCountOfSection : (NSInteger)section;
-(BackDataNode*)getNodeInSection : (NSInteger)section andRow : (NSInteger)row;
-(BackDataNode*)getNodeInRow : (NSInteger)row;
-(void)addAnSection : (BackDataColumn*)column;
-(void)addANode : (BackDataNode*)node;

-(NSString*)getColumnNameOfSection : (NSInteger)section;
-(NSString*)getColumnEnglishNameOfSection : (NSInteger)section;

@end
