//
//  EssayContentViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "EssayContentViewController.h"
#import "AFNetworking.h"
#import "CommentViewController.h"
#import "CommentBackDataController.h"
#import "StaticResourceManager.h"
#import "UMSocial.h"

#import "PopOverHintManager.h"

@interface EssayContentViewController ()<UIWebViewDelegate>

@end

@implementation EssayContentViewController

@synthesize urlToOpen;
@synthesize articleID;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.essayShowWebView.delegate = self;
    
    //NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:urlToOpen]];
    //NSLog(@"%@", essayViewController.essayShowWebView);
    //[self.essayShowWebView loadRequest:request];
    [self loadServerArticle];
}

-(void)loadServerArticle{
    if(!urlToOpen){
        [self loadWebPage:nil];
        return;
    }
    
    NSArray* urlArray = [urlToOpen componentsSeparatedByString:@"/"];
    id articleidobj = urlArray[[urlArray count]-1];
    if(articleidobj == nil || [articleidobj isKindOfClass:[NSNull class]]){
        return;
    }
    articleID = [articleidobj integerValue];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlToOpen parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self loadWebPage:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self loadWebPage:nil];
    }];
}

-(void)loadWebPage : (id)webPageObj{
    NSString* dataToload;
    if(webPageObj == nil){
        dataToload = @"网络坏掉了";
    }else{
        dataToload = [[NSString alloc] initWithData:webPageObj encoding:NSUTF8StringEncoding];
    }
    /*if(![webPageObj isKindOfClass:[NSDictionary class]]){
        dataToload = @"服务器故障";
    }*/
    
    /*id dataTemp = [(NSDictionary*)webPageObj objectForKey:@"html"];
    if([dataTemp isKindOfClass:[NSString class]]){
        dataToload = [(NSString*)dataTemp stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        dataToload = @"未知错误";
    }*/
    //articleID = [[(NSDictionary*)webPageObj objectForKey:@"articleId"] integerValue];
    [self.essayShowWebView loadHTMLString:dataToload baseURL:nil];
}


- (IBAction)backClicked:(id)sender {
    if([self.essayShowWebView canGoBack]){
        [self.essayShowWebView goBack];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)likeClicked:(id)sender {
    [self putForLikeAnEssay];
}

-(void)putForLikeAnEssay{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager PUT:[NSString stringWithFormat:@"%@/%ld/%@", CommentBaseURLStringStatic, (long)articleID, @"like"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"zan le yi ge:%@", responseObject);
        [PopOverHintManager showPopover:LikeClickSuccess];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"shi bai le a");
        [PopOverHintManager showPopover:NetWorkDown];
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController* viewController = segue.destinationViewController;

    if([viewController isKindOfClass:[CommentViewController class]]){
        //CommentViewController* commentdLevelViewController = (CommentViewController*)viewController;
        
        //[publicContentSecondLevelViewController setNavigationBarTitleString:[publicContentBackDataControllerInstance getColumnNameOfSection:selectedSection]];
        [CommentBackDataController getInstance].moduleURLString = [NSString stringWithFormat:@"%@/%ld/%@", CommentBaseURLStringStatic, (long)articleID,@"comment"];
    }
    //NSLog(@"page open");
}

@end
