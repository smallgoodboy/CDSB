//
//  PictureChengduCollectionViewController.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-24.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface PictureChengduCollectionViewController : BaseCollectionViewController
@property (strong, nonatomic) IBOutlet UICollectionView *frontCollectionView;
- (IBAction)uploadClicked:(id)sender;

@end
