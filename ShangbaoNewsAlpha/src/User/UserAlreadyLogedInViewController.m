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
#import "RootDecoratorTableViewCell.h"
#import "KxMenu.h"

@interface UserAlreadyLogedInViewController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    UserBackDataManager* userBackDataManagerInstance;
}

@end

@implementation UserAlreadyLogedInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userBackDataManagerInstance = [UserBackDataManager getInstance];
    
    self.userSettingTable.delegate = self;
    self.userSettingTable.dataSource = self;
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
            NSLog(@"用户信息显示成功");
            return;
        }
        
    }
    NSLog(@"获取失败");
}

-(void)setFrontUserInfo : (UserManager*)user{
    if([user.userNameString isEqualToString:self.userNameLabel.text]){
        return;
    }
    self.userNameLabel.text = user.userNameString;
    self.genderLabel.text = user.genderString;
    self.phoneNumberLabel.text = user.phoneNumberString;
    self.birthdayLabel.text = user.birthdayString;
    
    [self.userImageView setImageWithURL: [NSURL URLWithString : user.userImageURLString] placeholderImage:[UIImage imageNamed:@"icon_unLoginAvatar1.png"]];
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




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RootDecoratorTableViewCell* cell;
    switch (indexPath.row) {
        case 0:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCell0"];
            break;
        case 1:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCell1"];
            break;
        case 2:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCellDivider"];
            break;
        case 3:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCell2"];
            break;
        case 4:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCell3"];
            break;
        case 5:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCell4"];
            break;
        case 6:
            cell = [self.userSettingTable dequeueReusableCellWithIdentifier:@"UserSettingCell5"];
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return 100;
    }else if(indexPath.row == 2){
        return 7;
    }else{
        return 44;
    }
}


- (IBAction)userChangeAvatarClicked:(id)sender {
    NSArray *menuItems =
    @[
      
      [KxMenuItem menuItem:@"请选择"
                     image:nil
                    target:nil
                    action:NULL],
      
      [KxMenuItem menuItem:@"摄像头 拍摄"
                     image:nil
                    target:self
                    action:@selector(openCam)],
      
      [KxMenuItem menuItem:@"从照片中选择"
                     image:nil
                    target:self
                    action:@selector(openPics)]
      ];
    KxMenuItem *first = menuItems[0];
    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    first.alignment = NSTextAlignmentCenter;
    //[KxMenu setTintColor:[UIColor whiteColor]];
    [KxMenu showMenuInView:self.view
                  fromRect:[ UIScreen mainScreen ].applicationFrame
                 menuItems:menuItems];
}

/** image picker**/

- (void)openPics {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

-(void)openCam{
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera]) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.userImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [userBackDataManagerInstance uploadUserAvatar:image imageDescriberDict:nil completeCall:nil target:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
@end
