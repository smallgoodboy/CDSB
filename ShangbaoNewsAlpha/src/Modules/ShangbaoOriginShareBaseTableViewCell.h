//
//  ShangbaoOriginShareBaseTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-21.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorTableViewCell.h"
#import "BackDataNode.h"

@interface ShangbaoOriginShareBaseTableViewCell : RootDecoratorTableViewCell

@property BackDataNode* backNode;
@property UIViewController* viewControllerToShow;

-(void)initCellWithViewController : (UIViewController*)vController;
-(void)shareClicked;

@end
