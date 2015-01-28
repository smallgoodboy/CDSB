//
//  RootDecoratorNavigationController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-28.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "RootDecoratorNavigationController.h"
#import "PictureChengduCollection2LevelViewController.h"
#import "PublicContent2LevelViewController.h"

@interface RootDecoratorNavigationController ()

@end

@implementation RootDecoratorNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        
        viewController.navigationItem.leftBarButtonItem =[self customLeftBackButton];
        [viewController.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    } 
}

-(UIBarButtonItem*)customLeftBackButton{
    
    UIImage *image=[UIImage imageNamed:@"back.png"];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
    //[backItem setTintColor:[UIColor whiteColor]];
    
    return backItem;
}

-(void)popself{
    UIViewController* vc = self.visibleViewController;
    if(actionTakenBeforeExitSEL != nil && actionTakenBeforeExitTarget != nil && ([self.visibleViewController isKindOfClass:[PictureChengduCollection2LevelViewController class]] || [self.visibleViewController isKindOfClass:[PublicContent2LevelViewController class]])){
        [actionTakenBeforeExitTarget performSelector:actionTakenBeforeExitSEL withObject:nil];
    }
    [self popViewControllerAnimated:YES];
    //NSLog(@"BACK LA");
}

-(void)setActionTakeBeforeBack : (id)target selector:(SEL)selector{
    actionTakenBeforeExitSEL = selector;
    actionTakenBeforeExitTarget = target;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
