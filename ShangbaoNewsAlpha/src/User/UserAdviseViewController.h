//
//  UserAdviseViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-4.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorViewController.h"

@interface UserAdviseViewController : RootDecoratorViewController
- (IBAction)userAdviseConfirmClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *userAdviceConfirmButton;

@end
