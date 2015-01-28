//
//  PictureChengduCollectionViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackDataColumn.h"

@interface PictureChengduCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsClassfyNameLabel;

-(void)setContent : (NSString*)columnName withImage : (NSString*)imageURL;
@end
