//
//  PictureChengduActivityBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-25.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureChengduActivityNode.h"
#import <UIKit/UIKit.h>

@interface PictureChengduActivityBackDataController : NSObject{
    NSMutableArray* backDataArray;
}

@property UIPickerView* frontPickerView;
@property id frontViewController;

+(PictureChengduActivityBackDataController*)getInstance;
-(void)initBackDataController : (id)frontViewControllerInstance pickerView : (UIPickerView*)pickerView;

-(PictureChengduActivityNode*)getNodeAtOffset : (NSInteger)offset;
-(void)loadData;
-(NSInteger)getNodesCount;

@end
