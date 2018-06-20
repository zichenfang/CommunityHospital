//
//  AppDelegate.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "AppDelegate.h"
#import "WxApi.h"
#import "PPLoginIndexViewController.h"
#import "PPWebViewController.h"
#import <RongIMKit/RongIMKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [[RCIM sharedRCIM] initWithAppKey:RongCloudKey];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectRongCloudIM) name:kNoti_ConnectRongCloud object:nil];
    /*ROLE* 1:医生；2:患者。请前往Targets-BuildSetting-Preprocessor中设置*/
    //医生
    if (ROLE == 1){
        [WXApi registerApp:WechatAppID_Docotrs];

        if ([TTUserInfoManager logined] == YES) {
            
        }
        else{
            
        }
    }
    //患者
    else{
        [WXApi registerApp:WechatAppID_Patients];
        if ([TTUserInfoManager logined] == YES) {
            PPWebViewController *vc = [[PPWebViewController alloc] init];
            self.window.rootViewController = vc;
        }
        else{
            PPLoginIndexViewController *vc = [[PPLoginIndexViewController alloc] init];
            self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
        }
    }
    
    
    return YES;
}
- (void)connectRongCloudIM{
    NSString *rongToken = [[TTUserInfoManager userInfo] string_ForKey:@"rongToken"];
    rongToken = @"";
    [[RCIM sharedRCIM] connectWithToken:rongToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}



@end
