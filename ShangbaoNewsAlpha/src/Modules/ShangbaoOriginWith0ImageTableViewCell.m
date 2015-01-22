//
//  ShangbaoOriginWith0ImageTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "ShangbaoOriginWith0ImageTableViewCell.h"
#import "BackDataNode.h"
#import "StaticResourceManager.h"
#import "UIImageView+AFNetworking.h"

@implementation ShangbaoOriginWith0ImageTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setContent : (BackDataNode*)node{
    if(node == nil){
        return;
    }
    [self setBackNode:node];
    self.newsTitleLabel.text = node.titleString;
    //[self.newsImageView setImageWithURL: [NSURL URLWithString : [node getImageURLAtOffset:0]] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
    //@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
    self.newsTimeLabel.text = node.time;
    self.newsSummaryLabel.text = node.summaryString;
    
    //@property (weak, nonatomic) IBOutlet UIImageView *newsUserImageView;
    self.newsUserName.text = node.authorNameString;
    self.newsCommentNumberLabel.text = [NSString stringWithFormat:@"%ld", (long)node.commentNumber];
    
}

- (IBAction)shareClicked:(id)sender {
    [self shareClicked];
}

@end
