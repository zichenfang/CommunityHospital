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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
