//
//  EssayToolPopoverSelectViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-29.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "JCGridMenuController.h"

@interface EssayToolPopoverSelectViewController : JCGridMenuController{
    id callBackTarget;
    
    SEL commentCallBack;
    SEL likeCallBack;
}

@property BOOL isPopMenuOpen;

-(void)initCallBackWithTarget : (id)target commentCallBack : (SEL)commentCallBackSEL likeCallBack : (SEL)likeCallBackSEL;
-(void)openPopMenu;

-(void)closePopMenu;

@end
