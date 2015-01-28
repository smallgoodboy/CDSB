//
//  PictureChengduActivityBackDataController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-25.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduActivityBackDataController.h"
#import "StaticResourceManager.h"
#import "AFNetworking.h"

static PictureChengduActivityBackDataController* pictureChengduActivityBackDataControllerSigliton;

@implementation PictureChengduActivityBackDataController

-(id)init{
    if(self = [super init]){
        backDataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)initBackDataController : (id)frontViewControllerInstance pickerView : (UIPickerView*)pickerView{
    self.frontViewController = frontViewControllerInstance;
    self.frontPickerView = pickerView;
}

-(PictureChengduActivityNode*)getNodeAtOffset : (NSInteger)offset{
    if(backDataArray == nil){
        return nil;
    }
    if([backDataArray count]<=offset){
        return nil;
    }
    return [backDataArray objectAtIndex:offset];
}

-(void)loadData{
    backDataArray = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:PictureChengduActivityBaseURLStringStatic parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@" ACT Modlue json got!");
        [self analyseModuleServerData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ACT Error: %@", error);
    }];
}

-(void)analyseModuleServerData : (id)responseObj{
    if(! [responseObj isKindOfClass:[NSDictionary class]]){
        return;
    }
    
    id activityArrayObj = [(NSDictionary*)responseObj objectForKey:@"activeList"];
    
    if(! [activityArrayObj isKindOfClass:[NSArray class]]){
        return;
    }
    
    for(id i in (NSArray*)activityArrayObj){
        if(![i isKindOfClass:[NSDictionary class]]){
            continue;
        }
        PictureChengduActivityNode* node = [[PictureChengduActivityNode alloc] init];
        [node setContent:(NSDictionary*)i];
        [backDataArray addObject:node];
    }
    
    [self.frontPickerView reloadAllComponents];
}

-(NSInteger)getNodesCount{
    if(backDataArray == nil){
        backDataArray = [[NSMutableArray alloc] init];
    }
    return [backDataArray count];
}

/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PictureChengduActivityBackDataController*)getInstance{
    @synchronized(self){
        if (!pictureChengduActivityBackDataControllerSigliton) {
            pictureChengduActivityBackDataControllerSigliton = [[self alloc] init];
        }
    }
    return pictureChengduActivityBackDataControllerSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!pictureChengduActivityBackDataControllerSigliton) {
            pictureChengduActivityBackDataControllerSigliton = [super allocWithZone:zone];
            return pictureChengduActivityBackDataControllerSigliton;
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
