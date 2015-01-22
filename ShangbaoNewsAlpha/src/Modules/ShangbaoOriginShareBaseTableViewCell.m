//
//  ShangbaoOriginShareBaseTableViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-21.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "ShangbaoOriginShareBaseTableViewCell.h"
#import "UMSocial.h"

@implementation ShangbaoOriginShareBaseTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initCellWithViewController : (UIViewController*)vController{
    self.viewControllerToShow = vController;
}

-(void)shareClicked{
    [UMSocialSnsService presentSnsIconSheetView:self.viewControllerToShow
                                         appKey:@"54c0647afd98c552ae000bd6"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,nil]
                                       delegate:self.viewControllerToShow];
}

@end
