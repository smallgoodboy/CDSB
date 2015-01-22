//
//  PictureUploader.h
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PictureUploader : NSObject{
    NSOperationQueue *operationQueue;
}

+(PictureUploader *)getInstance;

//-(void)uploadPicture : (UIImage*) imageReadyToUpload imageDescriberDict : (NSMutableDictionary*)dict completeCall : (SEL)completeCall target : (id) target;
-(void)uploadPictureWithAFntework:(UIImage *)imageReadyToUpload imageDescriberDict:(NSMutableDictionary *)dict completeCall:(SEL)completeCall target:(id)target;
-(NSProgress*)uploadPictureWithAFnteworkWithProgress:(UIImage *)imageReadyToUpload imageDescriberDict:(NSMutableDictionary *)dict completeCall:(SEL)completeCall target:(id)target;

@end
