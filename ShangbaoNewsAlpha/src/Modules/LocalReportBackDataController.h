//
//  LocalReportBackDataController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BackDataBaseController.h"
#import "PublicContentBackDataController.h"

@interface LocalReportBackDataController : PublicContentBackDataController

+(LocalReportBackDataController *)getInstance;
@end
