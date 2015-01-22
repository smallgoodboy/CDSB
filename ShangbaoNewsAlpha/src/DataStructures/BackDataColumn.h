//
//  BackDataColumn.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BackDataNode.h"

@interface BackDataColumn : NSObject{
    NSMutableArray* backDataNodeArray;
}

@property NSString* channelNameString;
@property NSString* channelEnglishNameString;

-(void)addANode : (BackDataNode*)node;
-(BackDataNode*)getNodeAtOffset : (NSInteger)offset;
-(NSInteger)getNodeCount;

-(void)fillColumnWithDict : (id)dict;

@end
