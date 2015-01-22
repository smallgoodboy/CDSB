//
//  CommentShowTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-9.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "CommentShowTableViewCell.h"
#import "StaticResourceManager.h"
#import "UIImageView+AFNetworking.h"

@implementation CommentShowTableViewCell

-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    self.userNameLabel.text = node.authorNameString;
    self.userCommentLabel.text = node.summaryString;
    self.timeLabel.text = node.time;
    [self.userPortraitImageView setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:0]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
    //self.contentLabel.text = node.summaryString;
}

@end
