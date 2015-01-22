//
//  PopOverHintManager.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-13.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StaticResourceManager.h"
#import <UIKit/UIKit.h>

@interface PopOverHintManager : NSObject

+(void)showPopover : (enum NetWorkStatusCode)type inView : (UIView*)viewToShow;
+(void)showPopover : (enum NetWorkStatusCode)type;

@end
