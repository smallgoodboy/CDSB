//
//  CommentBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-9.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "CommentBackDataController.h"
#import "AFNetworking.h"
#import "StaticResourceManager.h"
#import "CommentViewController.h"

static CommentBackDataController* commentBackDataControllerSigliton;


@implementation CommentBackDataController

-(id)init{
    if(self=[super init]){
        isModuleUsePaging = YES;
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
        [node fillCommentNodeWithDict:(NSDictionary *)i];
        
        [backDataArray addObject:node];
        
    }
    
    [self.frontTableView reloadData];
}

-(void)postNewComment : (NSString*)commentContent successHintTarget : (id)target successCall : (SEL)successCall{
    NSDictionary* dict = [self packCommentRequestDict:@"smallgoodboy" comment:commentContent];
    [self sendAFNetworkRequest:[self moduleURLString] andCommentDict:dict successHintTarget:target successCall:successCall];
}

-(NSDictionary*)packCommentRequestDict : (NSString*)userName comment : (NSString*)commentString{
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    commentString = (commentString == nil?@"":commentString);
    [dict setObject:commentString forKey:@"content"];
    userName = (userName == nil?@"":userName);
    [dict setObject:userName forKey:@"userName"];
    
    return dict;
}

-(void)sendAFNetworkRequest : (NSString*)urlString andCommentDict : (NSDictionary*)dict successHintTarget : (id)target successCall : (SEL)successCall{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:urlString parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [(CommentViewController*)target performSelector:successCall withObject:[NSString stringWithFormat:@"%d", UpLoadSuccess]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [(CommentViewController*)target performSelector:successCall withObject:[NSString stringWithFormat:@"%d", UnknownError]];
    }];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(CommentBackDataController *)getInstance{
    @synchronized(self){
        if (!commentBackDataControllerSigliton) {
            commentBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return commentBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!commentBackDataControllerSigliton) {
            commentBackDataControllerSigliton = [super allocWithZone:zone];
            return commentBackDataControllerSigliton;
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
