//
//  PictureUploader.m
//  ShangbaoNewsAlpha
//
//  Created by Yangyi on 15-1-8.
//  Copyright (c) 2015年 dslab. All rights reserved.
//

#import "PictureUploader.h"
#import "StaticResourceManager.h"
#import "AFNetworking.h"
#import "PictureUploadViewController.h"
#import "UserManager.h"


static PictureUploader* pictureUploaderSigliton;


@implementation PictureUploader

-(id)init{
    if(self = [super init]){
        operationQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}

/*-(void)uploadPicture : (UIImage*) imageReadyToUpload imageDescriberDict : (NSDictionary*)dict completeCall : (SEL)completeCall target : (id) target{
    NSData *imageData = UIImageJPEGRepresentation(imageReadyToUpload, 1.0);
    //把图片转换成imageDate格式
    //NSData *imageData = [NSData dataWithContentsOfURL:imageURLReadyToUpload];
    //建立请求对象
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] init];
    //设置请求路径
    [request setURL:[NSURL URLWithString:PictureUploadURLStringStatic]];
    //请求方式
    [request setHTTPMethod:@"POST"];
    //一连串上传头标签
    NSString *boundary = @"----WebKitFormBoundary6ecCvAMzW0i4dH35";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *s = @"Content-Disposition: form-data; name=\"file\"; filename=\"useruploaded.jpg\"\r\n";
    [body appendData:[[NSString stringWithString:s] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    //上传文件开始
    
    [NSURLConnection sendAsynchronousRequest:request queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            NSLog(@"Error: %@", connectionError);
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode] ;
                
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                //NSLog(@"HttpResponseCode:%d", responseCode);
                //NSLog(@"HttpResponseBody %@",responseString);
                if(responseCode >=200 && responseCode <=210){
                    [self uploadPictureDescribe:responseString pictureDescribeDict:dict];
                    [(PictureUploadViewController*)target performSelector:completeCall withObject:nil];
                }
            });
        }
    }];
    
    
}*/

-(void)uploadPictureWithAFntework:(UIImage *)imageReadyToUpload imageDescriberDict:(NSMutableDictionary *)dict completeCall:(SEL)completeCall target:(id)target{
    NSData *imageData = UIImageJPEGRepresentation(imageReadyToUpload, 1.0);
    
    NSString* urlToPost = [PictureUploadURLStringStatic stringByReplacingOccurrencesOfString:@"userID" withString:[NSString stringWithFormat:@"%ld", (long)[UserManager getInstance].userIDInt]];
    
    NSString* imageFileTypeString = [PictureUploader contentTypeForImageData:imageData];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlToPost parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat: @"fuckstd.%@", imageFileTypeString] mimeType:[NSString stringWithFormat:@"image/%@",imageFileTypeString]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            //NSLog(@"HttpResponseCode:%d", responseCode);
            NSLog(@"HttpResponseBody %@",responseString);
            [self uploadPictureDescribe:responseString pictureDescribeDict:dict completeCall:completeCall target:target];
            
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [((PictureUploadViewController*)target) performSelector:completeCall withObject:[NSString stringWithFormat:@"%d", NetWorkDown]];
    }];
}

-(NSProgress*)uploadPictureWithAFnteworkWithProgress:(UIImage *)imageReadyToUpload imageDescriberDict:(NSMutableDictionary *)dict completeCall:(SEL)completeCall target:(id)target{
    NSData *imageData = UIImageJPEGRepresentation(imageReadyToUpload, 1.0);
    
    NSString* imageFileTypeString = [PictureUploader contentTypeForImageData:imageData];
    /*AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:PictureUploadURLStringStatic parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat: @"fuckstd.%@", imageFileTypeString] mimeType:[NSString stringWithFormat:@"image/%@",imageFileTypeString]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            //NSLog(@"HttpResponseCode:%d", responseCode);
            NSLog(@"HttpResponseBody %@",responseString);
            [self uploadPictureDescribe:responseString pictureDescribeDict:dict completeCall:completeCall target:target];
            
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [((PictureUploadViewController*)target) performSelector:completeCall withObject:[NSString stringWithFormat:@"%d", NetWorkDown]];
    }];*/
    NSString* urlToPost = [PictureUploadURLStringStatic stringByReplacingOccurrencesOfString:@"{userID}" withString:[NSString stringWithFormat:@"%ld", (long)[UserManager getInstance].userIDInt]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlToPost parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat: @"fuckstd.%@", imageFileTypeString] mimeType:[NSString stringWithFormat:@"image/%@",imageFileTypeString]];
    } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSProgress *progress = nil;
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [((PictureUploadViewController*)target) performSelector:completeCall withObject:[NSString stringWithFormat:@"%d", NetWorkDown]];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                
                NSLog(@"HttpResponseBody %@",responseString);
                [self uploadPictureDescribe:responseString pictureDescribeDict:dict completeCall:completeCall target:target];
                
            });
        }
    }];
    
    [uploadTask resume];
    //[progress fractionCompleted];
    return progress;
}


-(void)uploadPictureDescribe : (NSString*)pictureURL pictureDescribeDict : (NSMutableDictionary*)dict completeCall:(SEL)completeCall target:(id)target{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [array addObject:pictureURL];
    [dict setObject:[NSArray arrayWithArray: array] forKey:@"picturesUrl"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:PictureDescrierUploadURLStringStatic parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        [((PictureUploadViewController*)target) performSelector:completeCall withObject:[NSString stringWithFormat:@"%d", UpLoadSuccess]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [((PictureUploadViewController*)target) performSelector:completeCall withObject:[NSString stringWithFormat:@"%d", UnknownError]];
    }];
}




+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return nil;
}


/*****************************************/
/*       For      Sigliton               */
/*****************************************/

+(PictureUploader *)getInstance{
    @synchronized(self){
        if (!pictureUploaderSigliton) {
            pictureUploaderSigliton = [[self alloc] init];
        }
    }
    return pictureUploaderSigliton;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (!pictureUploaderSigliton) {
            pictureUploaderSigliton = [super allocWithZone:zone];
            return pictureUploaderSigliton;
        }
    }
    return nil;
}


- (id)copyWithZone:(NSZone *)zone;{
    return self;
}

/*****************************************/
/*****************************************/

@end
