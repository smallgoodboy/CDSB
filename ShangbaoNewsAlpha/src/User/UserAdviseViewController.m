//
//  UserAdviseViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-2-4.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserAdviseViewController.h"
#include<QuartzCore/CoreAnimation.h>

@interface UserAdviseViewController ()

@end

@implementation UserAdviseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)buttonP:(id)sender{
    [self buttonAnimation:sender];
}

- (CAAnimation *) animationRotate {
    NSInteger x = (arc4random() % 100) > 49 ? 0:1;
    NSInteger y = (arc4random() % 100) > 49 ? 0:1;
    NSInteger z = (arc4random() % 100) > 49 ? 0:1;
    if(x+y == 0){
        x = 1;
        y = 1;
    }
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation( (z==0 ? -1:1)*M_PI/2 , x, y, 0 );
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = 0.05;
    animation.autoreverses = YES;
    animation.cumulative = YES;
    animation.repeatCount = 40;
    animation.beginTime = 0;
    animation.delegate = self;
    return animation;
}

- (void)buttonAnimation:(id) sender{
    UIButton *theButton = sender;
    CAAnimation *myAnimationRotate = [self animationRotate];
    CAAnimationGroup* m_pGroupAnimation;
    m_pGroupAnimation = [CAAnimationGroup animation];
    m_pGroupAnimation.delegate = self;
    m_pGroupAnimation.removedOnCompletion = NO;
    m_pGroupAnimation.duration = 4;
    m_pGroupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    m_pGroupAnimation.repeatCount = 1;
    m_pGroupAnimation.fillMode = kCAFillModeForwards;
    m_pGroupAnimation.animations = [NSArray arrayWithObjects:myAnimationRotate, nil];
    [theButton.layer addAnimation:m_pGroupAnimation forKey:@"animationRotate"];

    [self performSelector:@selector(changeButtonTitle) withObject:nil afterDelay:2];
    NSLog(@"%@", [NSDate date]);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    NSLog(@"%@", [NSDate date]);
    //todo
}

-(void)changeButtonTitle{
    
    if([self.userAdviceConfirmButton.titleLabel.text isEqualToString:@"确定"]){
        [self.userAdviceConfirmButton setTitle:@"不定" forState:UIControlStateNormal];
    }else if([self.userAdviceConfirmButton.titleLabel.text isEqualToString:@"不定"]){
        [self.userAdviceConfirmButton setTitle:@"确定" forState:UIControlStateNormal];
    }
}

- (IBAction)userAdviseConfirmClicked:(id)sender {
    [self buttonAnimation:sender];
}
@end
