//
//  RootDecoratorNavigationController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-28.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootDecoratorNavigationController : UINavigationController{
    id actionTakenBeforeExitTarget;
    SEL actionTakenBeforeExitSEL;
}

-(void)setActionTakeBeforeBack : (id)target selector:(SEL)selector;

@end
