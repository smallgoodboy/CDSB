//
//  UserCollectionTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserCollectionTableViewCell.h"

@implementation UserCollectionTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setContent : (BackDataNode*)node{
    self.newsTitleLabel.text = node.titleString;
    self.newsTimeLabel.text = node.time;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
