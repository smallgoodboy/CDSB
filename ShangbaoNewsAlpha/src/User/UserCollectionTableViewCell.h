//
//  UserCollectionTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorTableViewCell.h"
#import "BackDataNode.h"

@interface UserCollectionTableViewCell : RootDecoratorTableViewCell

-(void)setContent : (BackDataNode*)node;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLabel;

@end
