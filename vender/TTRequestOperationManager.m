//
//  MyNetWork.m
//  DressIn3D
//
//  Created by Timo on 15/9/19.
//  Copyright (c) 2015年 Timo. All rights reserved.
//

#import "TTRequestOperationManager.h"
#import "NSString+MyCustomString.h"
#import "TTUserInfoManager.h"
#import "Toast.h"

#define REQUEST_TIMEOUT 10

@interface TTRequestOperationManager()
@end

@implementation TTRequestOperationManager
+ (id)defaultManager
{
    static TTRequestOperationManager *manager;
    if (manager ==nil) {
        manager = [[TTRequestOperationManager alloc] init];
    }
    return manager;
}
//普通的POST传参方式
+ (void)POST:(NSString *)URLString Parameters:(NSMutableDictionary *)parameters Success:(void (^)(NSDictionary *responseJsonObject))mySuccess Failure:(void (^)(NSError *error))myFailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval =REQUEST_TIMEOUT;
    if (![URLString hasPrefix:@"http"]) {
        URLString = [NSString stringWithFormat:@"%@%@",kHTTP,URLString];
    }
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *cacheDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"URLString =%@ \n parameters =%@ \n %@ 's cacheDic  =%@\n ",URLString,parameters,[parameters string_ForKey:@"method"],cacheDic);
        mySuccess(cacheDic.noNullObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication].keyWindow makeToast:NSLocalizedString(@"error network", nil) duration:1.5 position:CSToastPositionCenter];
        NSLog(@"%@",error);
        if (myFailure) {
            myFailure(error);
        }
    }];

}
//普通的传参方式GET
+ (void)GET:(NSString *)URLString Parameters:(NSMutableDictionary *)parameters Success:(void (^)(NSDictionary *responseJsonObject))mySuccess Failure:(void (^)(NSError *error))myFailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval =REQUEST_TIMEOUT;
    if (![URLString hasPrefix:@"http"]) {
        URLString = [NSString stringWithFormat:@"%@%@",kHTTP,URLString];
    }
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *cacheDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"URLString =%@ \n parameters =%@ \n %@ 's cacheDic  =%@\n ",URLString,parameters,[parameters string_ForKey:@"method"],cacheDic);
        [TTRequestOperationManager logOtherData:responseObject];
        mySuccess(cacheDic.noNullObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication].keyWindow makeToast:NSLocalizedString(@"error network", nil) duration:1.5 position:CSToastPositionCenter];
        NSLog(@"%@",error);
        [TTRequestOperationManager logOtherError:error];
        if (myFailure) {
            myFailure(error);
        }
    }];

}
//上传data的post方法
+ (void)POST:(NSString *)URLString parameters:(NSMutableDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block Success:(void (^)(NSDictionary *responseJsonObject))mySuccess Failure:(void (^)(NSError *error))myFailure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval =REQUEST_TIMEOUT *2.5;
    if (![URLString hasPrefix:@"http"]) {
        URLString = [NSString stringWithFormat:@"%@%@",kHTTP,URLString];
    }
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress) {
        //
//        NSString *percent = [NSString stringWithFormat:@"%.0f%%",100.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount];
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        NSDictionary *cacheDic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        NSLog(@"URLString =%@ \n parameters =%@ \n %@ 's cacheDic  =%@\n ",URLString,parameters,[parameters string_ForKey:@"method"],cacheDic);
        mySuccess(cacheDic.noNullObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication].keyWindow makeToast:NSLocalizedString(@"error network", nil) duration:1.5 position:CSToastPositionCenter];
        NSLog(@"%@",error);
        if (myFailure) {
            myFailure(error);
        }
    }];
}
+ (void)logOtherError :(NSError *)error{
    if (error) {
        NSData * errorData= error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        if (errorData) {
            NSLog(@"com.alamofire.serialization.response.error.data == %@",[[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding]);
        }
        else{
            NSLog(@"eeeeeee %@",error);
        }
    }
}
+ (void)logOtherData :(NSData *)data{
//    if (data) {
//        NSLog(@"NSUTF8StringEncoding == %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    }
}
@end
