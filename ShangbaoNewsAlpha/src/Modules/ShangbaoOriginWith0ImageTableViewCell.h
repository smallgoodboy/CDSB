//
//  ShangbaoOriginWith0ImageTableViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorTableViewCell.h"
#import "BackDataNode.h"
#import "ShangbaoOriginShareBaseTableViewCell.h"

@interface ShangbaoOriginWith0ImageTableViewCell : ShangbaoOriginShareBaseTableViewCell


//@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsSummaryLabel;

@property (weak, nonatomic) IBOutlet UIImageView *newsUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsUserName;
@property (weak, nonatomic) IBOutlet UILabel *newsCommentNumberLabel;
-(void)setContent : (BackDataNode*)node;
- (IBAction)shareClicked:(id)sender;

@end
