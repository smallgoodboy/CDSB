//
//  RoundImageView.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RoundImageView.h"

@implementation RoundImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        int radius = frame.size.height<frame.size.width?frame.size.height/2:frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
    }
    return self;
}

-(id)init{
    if(self = [super init]){
        int radius = self.frame.size.height<self.frame.size.width?self.frame.size.height/2:self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
    }
    return self;
}

-(id)initWithImage:(UIImage *)image{
    if(self = [super initWithImage:image]){
        int radius = self.frame.size.height<self.frame.size.width?self.frame.size.height/2:self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        int radius = self.frame.size.height<self.frame.size.width?self.frame.size.height/2:self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = radius;
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

@end
