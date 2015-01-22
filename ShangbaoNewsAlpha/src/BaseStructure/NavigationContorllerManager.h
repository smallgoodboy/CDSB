//
//  NavigationContorllerManager.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-21.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ShangbaoOriginViewController.h"

@interface NavigationContorllerManager : NSObject{
    NSMutableArray* navControllerArray;
}

@property ShangbaoOriginViewController* shangbaoOrignViewControllerInstance;

+(NavigationContorllerManager *)getInstance;

+(void)addANavigationController : (UINavigationController*)navController;
+(void)getEveryNavControllerToFather;
+(void)startAutoNavigation;

@end
