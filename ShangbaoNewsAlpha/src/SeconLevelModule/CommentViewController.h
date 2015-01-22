//
//  CommentViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-9.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PullRefreshViewController.h"

@interface CommentViewController : PullRefreshViewController
@property (weak, nonatomic) IBOutlet PullTableView *frontPullRefreshTableView;


- (IBAction)backClicked:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)sendCommentClicked:(id)sender;
- (IBAction)backViewTouched:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *commentFillTextfield;
@end
