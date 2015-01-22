//
//  RootDecoratorTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-14.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorTableViewCell.h"

@implementation RootDecoratorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
