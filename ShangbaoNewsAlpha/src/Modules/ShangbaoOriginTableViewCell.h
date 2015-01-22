//
//  ShangbaoOriginTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackDataNode.h"
#import "RootDecoratorTableViewCell.h"
#import "ShangbaoOriginShareBaseTableViewCell.h"

@interface ShangbaoOriginTableViewCell : ShangbaoOriginShareBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsSummaryLabel;

@property (weak, nonatomic) IBOutlet UIImageView *newsUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsUserName;
@property (weak, nonatomic) IBOutlet UILabel *newsCommentNumberLabel;
- (IBAction)shareClicked:(id)sender;
-(void)setContent : (BackDataNode*)node;
@end
