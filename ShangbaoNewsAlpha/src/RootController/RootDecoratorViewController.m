//
//  RootDecoratorViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-12.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"
#import "StaticResourceManager.h"
#import "RootDecoratorNavigationBar.h"

@implementation RootDecoratorViewController

@synthesize navigationBarTitleString;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    appShowingView = self.view;
}

-(void)viewWillAppear:(BOOL)animated{
    if(!navigationBarTitleString){
        navigationBarTitleString = @"成都商报";
    }
    self.navigationItem.title = navigationBarTitleString;
    self.navigationItem.leftBarButtonItem.title = @" ";
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        self.navigationController.navigationBar.tintColor = [RootDecoratorNavigationBar colorWithHexString:@"e62129"];
    } else {
        self.navigationController.navigationBar.barTintColor = [RootDecoratorNavigationBar colorWithHexString:@"e62129"];
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

-(BOOL)shouldAutorotate{
    return NO;
}

@end
