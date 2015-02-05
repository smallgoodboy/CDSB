//
//  UserCollectionBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserCollectionBackDataController.h"
#import "StaticResourceManager.h"
#import "AFNetworking.h"
#import "UserBackDataManager.h"

static UserCollectionBackDataController* userCollectionBackDataControllerSigliton;


@implementation UserCollectionBackDataController

-(id)init{
    if(self=[super init]){
        isModuleUsePaging = YES;
        self.moduleURLString = UserCollectionOpsBaseURLStringStatic;
    }
    return self;
}

-(void)analyseModuleServerData : (id)backDataObj{
    if(![backDataObj isKindOfClass:[NSDictionary class]]){
        return;
    }
    pageTotalNumber = [[(NSDictionary*)backDataObj objectForKey:@"pageCount"] integerValue];
    
    id commentContentArrayObj = [(NSDictionary*)backDataObj objectForKey:@"content"];
    
    if(![commentContentArrayObj isKindOfClass:[NSArray class]]){
        return;
    }
    
    for(id i in (NSArray*)commentContentArrayObj){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        BackDataNode* node = [[BackDataNode alloc] init];
        [node fillNodeWithDict:(NSDictionary *)i];
        
        [backDataArray addObject:node];
        
    }
    
    [self.frontTableView reloadData];
}

-(void)collectAnArticle : (NSInteger)articleID withSuccessCallTarget : (id)target successCall : (SEL)successCall{
    if([[UserBackDataManager getInstance] isUserLogin]){
        [self postNewCollectionArticle:articleID withSuccessCallTarget:target successCall:successCall];
    }else{
        
    }
}

-(void)deleteCollectedArticle : (NSInteger)articleID withSuccessCallTarget : (id)target successCall : (SEL)successCall{
    if([[UserBackDataManager getInstance] isUserLogin]){
        [self deleteCollectionArticle:articleID withSuccessCallTarget:target successCall:successCall];
    }else{
        
    }
}

-(void)postNewCollectionArticle : (NSInteger)articleID withSuccessCallTarget : (id)target successCall : (SEL)successCall{
    NSString* urlString = [NSString stringWithFormat:@"%@/%ld", UserCollectionOpsBaseURLStringStatic, (long)articleID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(target != nil && successCall != nil){
            [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d", UpLoadSuccess]];
        }
        NSLog(@"collect successs");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(target != nil && successCall != nil){
            [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d", NetWorkDown]];
        }
        NSLog(@"collect fail");
    }];
}

-(void)deleteCollectionArticle : (NSInteger)articleID withSuccessCallTarget : (id)target successCall : (SEL)successCall{
    NSString* urlString = [NSString stringWithFormat:@"%@/%ld", UserCollectionOpsBaseURLStringStatic, (long)articleID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager DELETE:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(target != nil && successCall != nil){
            [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d", UpLoadSuccess]];
        }
        NSLog(@"delete collect successs");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(target != nil && successCall != nil){
            [target performSelector:successCall withObject:[NSString stringWithFormat:@"%d", NetWorkDown]];
        }
        NSLog(@"delete collect fail");
    }];
}

-(void)removeNodeAtIndex : (NSInteger)offset{
    if([backDataArray count]>offset){
        [backDataArray removeObjectAtIndex:offset];
    }
    
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(UserCollectionBackDataController *)getInstance{
    @synchronized(self){
        if (!userCollectionBackDataControllerSigliton) {
            userCollectionBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return userCollectionBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!userCollectionBackDataControllerSigliton) {
            userCollectionBackDataControllerSigliton = [super allocWithZone:zone];
            return userCollectionBackDataControllerSigliton;
        }
    }
    return nil;
}


- (id)copyWithZone:(NSZone *)zone;{
    return self;
}

/*****************************************/
/*****************************************/

@end
