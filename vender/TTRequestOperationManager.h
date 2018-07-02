//
//  MyNetWork.h
//  DressIn3D
//
//  Created by Timo on 15/9/19.
//  Copyright (c) 2015年 Timo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "JsonKillNull.h"
//数据请求地址
#define kHTTP @"http://bh.52pinka.com/"

//MARK: ●IS_MD5
//#define IS_MD5  0

//MARK: ●患者端登录（使用密码）
#define API_USER_LOGIN_WITH_PASSWORD  @"api/Login/GetUser"
//MARK: ●患者端微信登录
#define API_USER_WECHAT_LOGIN  @""
//MARK: ●患者端用户注册页面URL
#define URL_PATIENT_REGIST  @"http://bh.52pinka.com/m-Wap/Register"
//MARK: ●患者端主页面页面URL
#define URL_PATIENT_MAIN  @"http://bh.52pinka.com/m-Wap/Login/Entrance"//用来测试调起原生登录页面
//#define URL_PATIENT_MAIN  @"http://bh.52pinka.com/m-Wap/"
//MARK: ●患者端人脸登录页面URL
#define URL_PATIENT_LOGIN_FACE  @"http://www.baidu.com/"
//MARK: ●患者端找回密码页面URL
#define URL_PATIENT_RESET_PASSWORD  @"http://bh.52pinka.com/m-wap/login/ForgotPassword"
//MARK: ●患者验证码登录 获取验证码 API
#define URL_PATIENT_GET_MSG_CODE  @"api/Login/SendPhoneCheckCode"
//MARK: ●患者验证码登录 API
#define URL_PATIENT_LOGIN_VCODE  @"api/Login/getUser"
//MARK: ●患者端 报告单 URL
#define URL_PATIENT_BAOGAODAN  @"http://www.baidu.com/"
//MARK: ●患者端 健康数据 URL
#define URL_PATIENT_JIANKANGSHUJU @"http://www.baidu.com/"


//MARK: ●医生端用户注册页面URL
#define URL_DOCTOR_REGIST  @"https://ssl.zc.qq.com/v3/index-chs.html?from=pt"
//MARK: ●医生端主页面 页面URL
#define URL_DOCTOR_MAIN  @"https://www.baidu.com/"
//MARK: ●医生端人脸登录 页面URL
#define URL_DOCTOR_LOGIN_FACE  @"https://faceid.com/"
//MARK: ●医生端找回密码 页面URL
#define URL_DOCTOR_RESET_PASSWORD  @"https://aq.qq.com/cn2/index"
//MARK: ●医生端登录 API
#define URL_PATIENT_LOGIN_USERNAME_PASSWORD  @""




@interface TTRequestOperationManager : NSObject

+ (id)defaultManager;
//普通的POST传参方式
+ (void)POST:(NSString *)URLString Parameters:(NSMutableDictionary *)parameters Success:(void (^)(NSDictionary *responseJsonObject))mySuccess Failure:(void (^)(NSError *error))myFailure;
//get
+ (void)GET:(NSString *)URLString Parameters:(NSMutableDictionary *)parameters Success:(void (^)(NSDictionary *responseJsonObject))mySuccess Failure:(void (^)(NSError *error))myFailure;


//上传data的post方法
+ (void)POST:(NSString *)URLString parameters:(NSMutableDictionary *)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block Success:(void (^)(NSDictionary *responseJsonObject))mySuccess Failure:(void (^)(NSError *error))myFailure;


@end
