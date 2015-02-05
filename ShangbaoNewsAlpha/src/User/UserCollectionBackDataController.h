//
//  UserCollectionBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataBaseController.h"

@interface UserCollectionBackDataController : BackDataBaseController

+(UserCollectionBackDataController *)getInstance;

-(void)collectAnArticle : (NSInteger)articleID withSuccessCallTarget : (id)target successCall : (SEL)successCall;
-(void)deleteCollectedArticle : (NSInteger)articleID withSuccessCallTarget : (id)target successCall : (SEL)successCall;

-(void)removeNodeAtIndex : (NSInteger)offset;

@end
