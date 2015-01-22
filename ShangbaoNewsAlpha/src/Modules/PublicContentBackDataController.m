//
//  PublicContentBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContentBackDataController.h"



@implementation PublicContentBackDataController

-(id)init{
    if(self=[super init]){
        isModuleUsePaging = NO;
    }
    return self;
}

-(void)analyseModuleServerData : (id)backDataObj{
    if([backDataObj isKindOfClass:[NSDictionary class]]){
        NSLog(@"Public content format right");
    }else{
        NSLog(@"Public content format wrong");
        return;
    }
    
    id publicContentContentArrayObj = [(NSDictionary*) backDataObj objectForKey:@"contentColumns"];
    if([publicContentContentArrayObj isKindOfClass:[NSArray class]] || publicContentContentArrayObj == nil){
        NSLog(@"Public content format right");
    }else{
        NSLog(@"Public content format wrong");
        return;
    }
    
    for(id i in (NSArray*)publicContentContentArrayObj){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        BackDataColumn* column = [[BackDataColumn alloc] init];
        [column fillColumnWithDict:i];
        [backDataArray addObject:column];
    }

    [self.frontTableView reloadData];
}




@end
