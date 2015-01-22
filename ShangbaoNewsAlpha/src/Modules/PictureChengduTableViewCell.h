//
//  PictureChengduTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackDataNode.h"
#import "RootDecoratorTableViewCell.h"

@interface PictureChengduTableViewCell : RootDecoratorTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsAuthorKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsAuthorValueLabel;

-(void)setContent : (BackDataNode*)node;
@end
