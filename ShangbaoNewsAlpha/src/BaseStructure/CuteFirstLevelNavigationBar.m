//
//  CuteFirstLevelNavigationBar.m
//  ShangbaoNews
//
//  Created by Yangyi on 15-1-7.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "CuteFirstLevelNavigationBar.h"

@implementation CuteFirstLevelNavigationBar



- (void) awakeFromNib {
    [self initCuteNavigationBar];
}

-(void)initCuteNavigationBar{
    self.barTintColor = [UIColor colorWithRed:255/255.0f green:220/255.0f  blue:226/255.0f alpha:1.0f];
    NSLog(@"set called!!");
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

@implementation CuteFirstLevelNavigationItem

- (void) awakeFromNib {
    [self initCuteNavigationItem];
}

-(void)initCuteNavigationItem{
    self.title = @"成都商报";
    
}

@end
