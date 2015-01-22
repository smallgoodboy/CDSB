//
//  CommentBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-9.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataBaseController.h"

@interface CommentBackDataController : BackDataBaseController

+(CommentBackDataController *)getInstance;

-(void)postNewComment : (NSString*)commentContent successHintTarget : (id)target successCall : (SEL)successCall;
@end
