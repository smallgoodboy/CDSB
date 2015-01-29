//
//  EssayContentViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootDecoratorViewController.h"

@interface EssayContentViewController : RootDecoratorViewController

@property NSString* urlToOpen;
@property NSInteger articleID;

- (IBAction)backClicked:(id)sender;
- (IBAction)likeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *essayShowWebView;

-(void)loadServerArticle;
-(void)loadWebPage : (id)webPageObj;

- (IBAction)showPopMenuClicked:(id)sender;

@end
