//
//  PictureChengdu2LevelCollectionViewCell.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackDataNode.h"

@interface PictureChengdu2LevelCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;


-(void)setContent : (BackDataNode*)node;
@end
