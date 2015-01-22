//
//  PublicContentWith1ImageTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackDataNode.h"
#import "RootDecoratorTableViewCell.h"

@interface PublicContentWith1ImageTableViewCell : RootDecoratorTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsHitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLabel;

-(void)setContent : (BackDataNode*)node;
@end
