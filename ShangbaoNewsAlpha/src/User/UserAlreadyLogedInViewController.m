//
//  UserAlreadyLogedInViewController.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-15.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "UserAlreadyLogedInViewController.h"
#import "UserBackDataManager.h"
#import "StaticResourceManager.h"
#import "UserManager.h"
#import "UIImageView+AFNetworking.h"

@interface UserAlreadyLogedInViewController (){
    UserBackDataManager* userBackDataManagerInstance;
}

@end

@implementation UserAlreadyLogedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userBackDataManagerInstance = [UserBackDataManager getInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [userBackDataManagerInstance getUserInfoOfsuccessCallTarget:self successCall:@selector(getUserInfoAndShow:backObj:)];
}

-(void)getUserInfoAndShow  : (id)result backObj : (id)backObj{
    if([result integerValue] == UpLoadSuccess){
        if([backObj isKindOfClass:[NSDictionary class]]){
            [UserManager setContent:(NSDictionary*)backObj];
            [self setFrontUserInfo:[UserManager getInstance]];
        }
        
    }
    NSLog(@"获取失败");
}

-(void)setFrontUserInfo : (UserManager*)user{
    self.userNameLabel.text = user.userNameString;
    self.genderLabel.text = user.genderString;
    self.phoneNumberLabel.text = user.phoneNumberString;
    self.birthdayLabel.text = user.birthdayString;
    
    [self.userImageView setImageWithURL: [NSURL URLWithString : user.userImageURLString] placeholderImage:[UIImage imageNamed:OverAllPlaceHolderImageNameStringStatic]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logOutClicked:(id)sender {
    if(userBackDataManagerInstance == nil){
        userBackDataManagerInstance = [UserBackDataManager getInstance];
    }
    [userBackDataManagerInstance logOut];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
