//
//  PublicContentWith3ImageTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PublicContentWith3ImageTableViewCell.h"
#import "StaticResourceManager.h"
#import "UIImageView+AFNetworking.h"

@implementation PublicContentWith3ImageTableViewCell

-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    self.newsTitleLabel.text = node.titleString;
    self.newsTimeLabel.text = node.time;
    self.newsHitsLabel.text = [NSString stringWithFormat:@"%d", node.clickNumber];
    [self.newsImageView1 setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:0]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
    [self.newsImageView2 setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:1]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
    [self.newsImageView3 setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:2]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
    //self.contentLabel.text = node.summaryString;
}

@end
