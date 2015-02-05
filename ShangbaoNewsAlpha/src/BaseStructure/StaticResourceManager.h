//
//  StaticResourceManager.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//
#import <UIKit/UIKit.h>

static NSString* ShangbaoOriginNameKeyStringStatic = @"消费";
static NSString* NewestInfoNameKeyStringStatic = @"热点";
static NSString* LocalReportNameKeyStringStatic = @"本地";
static NSString* PictureChengduNameKeyStringStatic = @"快拍";

static NSString* ServerBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app";
static NSString* ImageServerBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01";
static NSString* ServerHomePageURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app/ios/start";
static NSString* PictureUploadURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app/{userID}/uploadpic";
static NSString* UserAvatarUploadURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/appuser/upload/avatar";
static NSString* PictureDescrierUploadURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app/sendarticle";
static NSString* UserInfoUploadURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/appuser/update/user";
static NSString* ArticleBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app/ios/articledetail";
static NSString* CommentBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app/ios";
static NSString* PhoneIdentifyBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/auth/phoneidentify";
static NSString* UserSignUpBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/auth/register";
static NSString* UserLoginBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/auth/login";
static NSString* UserInfoBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/appuser/userinfo";
static NSString* UserLogoutBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/j_spring_security_logout";
static NSString* PictureChengduActivityBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/app/ios/kuaipai/activity";
static NSString* UserCollectionOpsBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/appuser/collection/articles";
static NSString* UserPasswdModifyBaseURLStringStatic = @"http://120.27.47.167:8080/Shangbao01/appuser/update/passwd";


static NSString* ShangbaoOringinTableViewCellIdentifierStringStatic = @"ShangbaoOriginCell";
static NSString* ShangbaoOringinTableViewCellWith0ImageIdentifierStringStatic = @"ShangbaoOriginWith0ImageCell";
static NSString* NewestInfo1ImageTableViewCellIdentifierStringStatic = @"NewestInfoWith1ImageCell";
static NSString* PublicContent1ImageTableViewCellIdentifierStringStatic = @"PublicContentWith1ImageCell";
static NSString* PublicContent3ImageTableViewCellIdentifierStringStatic = @"PublicContentWith3ImageCell";
static NSString* PublicContent0ImageTableViewCellIdentifierStringStatic = @"PublicContentWith0ImageCell";
static NSString* PublicContentLoadMoreCellIdentifierStringStatic = @"PublicContentLoadMoreCell";
static NSString* PictureChengduTableViewCellIdentifierStringStatic = @"PictureChengduCell";
static NSString* SeperatorCellIdentifierStringStatic = @"SeperatorCell";
static NSString* CommentTableViewCellIdentifierStringStatic = @"CommentCell";
static NSString* UserCollectionTableViewCellIdentifierStringStatic = @"UserCollectionArticlesTableViewCell";

static NSString* OverAllPlaceHolderImageNameStringStatic = @"shangbao_logo_large.jpg";

static NSString* UserAlreadyLoginSegueNameStringStatic = @"UserAlreadyLogSegue";
static NSString* UserStatusLoginSegueNameStringStatic = @"UserStatusLoginSegue";
static NSString* UserStatusNotLoginSegueNameStringStatic = @"UserStatusNotLoginSegue";
static NSString* UserAdviseToLoginSegueNameStringStatic = @"AdviseUserToLoginSegue";
static NSString* PictureUploadSegueNameStringStatic = @"PictureUploadSegue";
static NSString* NewsNotifiedToShowSegueNameStringStatic = @"NotifiedToShowNewsSegue";
static NSString* EssayCommentToShowSegueNameStringStatic = @"EssayCommentSegue";

static NSString* CacheFileNameStringStatic = @"cacheData.plist";

const NSInteger AutoRefreshTimeIntervalSecondInt = -180;

enum NetWorkStatusCode{
    UpLoadSuccess,
    NetWorkDown,
    UnknownError,
    LikeClickSuccess
};

UIView* appShowingView;

