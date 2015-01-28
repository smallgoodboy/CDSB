//
//  PopOverHintManager.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-13.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PopOverHintManager.h"
#import "StaticResourceManager.h"
#import "BDKNotifyHUD.h"
#import "RootTabBarController.h"

BOOL isPopoverShowing = NO;

@implementation PopOverHintManager

+(void)showPopover : (enum NetWorkStatusCode)type inView : (UIView*)viewToShow{
    /*if(!isPopoverShowing){
        isPopoverShowing = YES;
    }else{
        return;
    }*/
    BDKNotifyHUD *hud;
    switch (type) {
        case UpLoadSuccess:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"check-6x.png"] text:@"成功"];
            break;
            
        case UnknownError:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"未知错误"];
            break;
        case NetWorkDown:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"网络断开"];
            break;
        default:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"未知错误"];
            break;
    }
    // Create the HUD object; view can be a UIImageView, an icon... you name it
    hud.center = CGPointMake(viewToShow.center.x, viewToShow.center.y - 20);
    
    // Animate it, then get rid of it. These settings last 1 second, takes a half-second fade.
    [viewToShow addSubview:hud];
    [hud presentWithDuration:1.0f speed:0.5f inView:viewToShow completion:^{
        [hud removeFromSuperview];
        isPopoverShowing = NO;
    }];
}

+(void)showPopover : (enum NetWorkStatusCode)type{
    /*if(!isPopoverShowing){
        isPopoverShowing = YES;
    }else{
        return;
    }*/
    BDKNotifyHUD *hud;
    switch (type) {
        case UpLoadSuccess:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"check-6x.png"] text:@"成功"];
            break;
            
        case UnknownError:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"未知错误"];
            break;
        case NetWorkDown:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"网络断开"];
            break;
        case LikeClickSuccess:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"check-6x.png"] text:@"赞 成功"];
            break;
        default:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"未知错误"];
            break;
    }
    // Create the HUD object; view can be a UIImageView, an icon... you name it
    hud.center = CGPointMake(appShowingView.center.x, appShowingView.center.y - 20);
    
    // Animate it, then get rid of it. These settings last 1 second, takes a half-second fade.
    [appShowingView addSubview:hud];
    [hud presentWithDuration:1.0f speed:0.5f inView:appShowingView completion:^{
        [hud removeFromSuperview];
        isPopoverShowing = NO;
    }];
}

@end
