//
//  BackDataNode.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文章与评论公用数据结构
 **/

@interface BackDataNode : NSObject

@property NSString* titleString;
@property NSMutableArray* imageArray;
@property NSString* summaryString;
@property NSString* time;
@property NSInteger clickNumber;
@property NSInteger newsID;
@property NSString* authorNameString;
@property NSInteger ariticleID;
@property NSString* authorImageUrl;
@property NSInteger commentNumber;

-(void)addAnImage : (NSString*)imageURLString;
-(NSString*)getImageURLAtOffset : (int)offset;
-(NSInteger)getImageNumber;

-(void)fillNodeWithDict : (id)dict;
-(void)fillCommentNodeWithDict : (id)dict;

-(NSString*)getNodeArticleURL;

-(NSString*)getCommentURL;

@end
