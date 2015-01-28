//
//  main.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "OfflineCacher.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        [OfflineCacher readCache];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
