//
//  ShangbaoOriginTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "ShangbaoOriginTableViewCell.h"
#import "StaticResourceManager.h"
#import "UIImageView+AFNetworking.h"

@implementation ShangbaoOriginTableViewCell

- (IBAction)shareClicked:(id)sender {
    [self shareClicked];
}

-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    [self setBackNode:node];
    self.newsTitleLabel.text = node.titleString;
    [self.newsImageView setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:0]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
    //@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
    self.newsTimeLabel.text = node.time;
    self.newsSummaryLabel.text = node.summaryString;
    
    //@property (weak, nonatomic) IBOutlet UIImageView *newsUserImageView;
    self.newsUserName.text = node.authorNameString;
    self.newsCommentNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)node.commentNumber];

}

@end
