//
//  PictureChengduTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduTableViewCell.h"
#import "StaticResourceManager.h"
#import "UIImageView+AFNetworking.h"

@implementation PictureChengduTableViewCell

-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    self.newsAuthorKeyLabel.text = @"作者";
    self.newsAuthorValueLabel.text = node.authorNameString;
    [self.newsImageView setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:0]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
}

@end
