//
//  PublicContentWith0ImageTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContentWith0ImageTableViewCell.h"

@implementation PublicContentWith0ImageTableViewCell


-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    self.newsTitleLabel.text = node.titleString;
    self.newsHitsLabel.text = [NSString stringWithFormat:@"%d", node.clickNumber];
    self.newsSummaryLabel.text = node.summaryString;
    self.newsTimeLabel.text = node.time;

}
@end
