//
//  CommentViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-9.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentBackDataController.h"
#import "CommentShowTableViewCell.h"
#import "StaticResourceManager.h"
#import "BDKNotifyHUD.h"

@interface CommentViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>{
    CommentBackDataController* commentBackDataControllerInstance;
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    commentBackDataControllerInstance = [CommentBackDataController getInstance];
    [commentBackDataControllerInstance initBackDataController:self tableView:self.frontPullRefreshTableView];
    super.frontPullTableViewBackCache = self.frontPullRefreshTableView;
    super.backDataBaseControllerInstance = commentBackDataControllerInstance;
    [super viewDidLoad];
    
    self.frontPullRefreshTableView.delegate = self;
    self.frontPullRefreshTableView.dataSource = self;
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillEndShow:) name:UIKeyboardWillHideNotification object:nil];
    self.commentFillTextfield.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentBackDataControllerInstance getSectionOrRowCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentShowTableViewCell *cell = [self.frontPullRefreshTableView dequeueReusableCellWithIdentifier:CommentTableViewCellIdentifierStringStatic];
    BackDataNode* node = [commentBackDataControllerInstance getNodeInRow:indexPath.row];
    [cell setContent:node];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*-(void)keyboardWillShow:(NSNotification *)notification
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        NSInteger offset =self.view.frame.size.height-keyboardBounds.origin.y;//+64.0;
        CGRect listFrame = CGRectMake(0, -offset, self.view.frame.size.width,self.view.frame.size.height);
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        //处理移动事件，将各视图设置最终要达到的状态
        
        self.view.frame=listFrame;
        
        [UIView commitAnimations];
        
    }
}

-(void)keyboardWillEndShow:(NSNotification *)notification
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        CGRect listFrame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
        [UIView beginAnimations:@"anim" context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:0.3];
        //处理移动事件，将各视图设置最终要达到的状态
        
        self.view.frame=listFrame;
        
        [UIView commitAnimations];
        
    }
}*/

- (IBAction)backClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textFiledReturnEditing:(id)sender {
    [(UIResponder*)sender resignFirstResponder];
}

-(void)commentResultReceiver : (id)resultType{
    BDKNotifyHUD *hud;
    switch ([resultType integerValue]) {
        case UpLoadSuccess:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"check-6x.png"] text:@"发表成功"];
            break;
            
        default:
            hud = [BDKNotifyHUD notifyHUDWithImage:[UIImage imageNamed:@"x-6x.png"] text:@"失败"];
            break;
    }
    // Create the HUD object; view can be a UIImageView, an icon... you name it
    hud.center = CGPointMake(self.view.center.x, self.view.center.y - 20);
    
    // Animate it, then get rid of it. These settings last 1 second, takes a half-second fade.
    [self.view addSubview:hud];
    [hud presentWithDuration:1.0f speed:0.5f inView:self.view completion:^{
        [hud removeFromSuperview];
    }];
}

- (IBAction)sendCommentClicked:(id)sender {
    [commentBackDataControllerInstance postNewComment:[self.commentFillTextfield text] successHintTarget:self successCall:@selector(commentResultReceiver:)];
}

- (IBAction)backViewTouched:(id)sender {
    [self.commentFillTextfield resignFirstResponder];
}

@end
