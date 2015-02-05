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
    SEL userCollectionCallBack;
    
    SEL weiboShareCallBack;
    SEL tencentWeiboShareCallBack;
    SEL wechatFrinedsShareCallBack;
    SEL wechatFriendsCircleCallBack;
}

@property BOOL isPopMenuOpen;

-(void)initCallBackWithTarget : (id)target commentCallBack : (SEL)commentCallBackSEL likeCallBack : (SEL)likeCallBackSEL userCollectionCallBack : (SEL)userCollectCallBackSEL;
-(void)initShareCallBackWeibo : (SEL)weiboShareCallBackSEL tencentWeibo : (SEL)tencentWeiboShareCallBackSEL wechatFriends : (SEL) wechatFrinedsShareCallBackSEL wechatFriendsCircel : (SEL) wechatFriendsCircleCallBackSEL;
-(void)openPopMenu;

-(void)closePopMenu;

@end
