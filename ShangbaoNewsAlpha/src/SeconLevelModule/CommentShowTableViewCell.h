//
//  CommentShowTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-9.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootDecoratorTableViewCell.h"
#import "BackDataNode.h"

@interface CommentShowTableViewCell : RootDecoratorTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPortraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)setContent : (BackDataNode*)node;


@end
