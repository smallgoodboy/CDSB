//
//  PictureChengduCollectionViewCell.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureChengduCollectionViewCell.h"
#import "StaticResourceManager.h"
#import "UIImageView+AFNetworking.h"

@implementation PictureChengduCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setContent : (NSString*)columnName withImage : (NSString*)imageURL{
    self.newsClassfyNameLabel.text = columnName;
    
    [self.newsImageView setImageWithURL: [NSURL URLWithString : imageURL] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
}

@end
