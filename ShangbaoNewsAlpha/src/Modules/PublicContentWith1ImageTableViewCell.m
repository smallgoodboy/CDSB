//
//  PublicContentWith1ImageTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContentWith1ImageTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "StaticResourceManager.h"

@implementation PublicContentWith1ImageTableViewCell

-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    self.newsTitleLabel.text = node.titleString;
    self.newsHitsLabel.text = [NSString stringWithFormat:@"%d", node.clickNumber];
    self.newsSummaryLabel.text = node.summaryString;
    self.newsTimeLabel.text = node.time;
    [self.newsImageView setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:0]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
}

@end
