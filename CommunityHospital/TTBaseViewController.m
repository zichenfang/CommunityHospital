//
//  TTBaseViewController.m
//  SuiTu
//
//  Created by 殷玉秋 on 2017/5/13.
//  Copyright © 2017年 fff. All rights reserved.
//

#import "TTBaseViewController.h"

@implementation TTBaseViewController
- (id)init
{
    self = [super init];
    UIImage *backImage;
    //医生
    if (ROLE == 1){
        backImage = [UIImage imageNamed:@"system_back_green"];
    }
    //患者
    else{
        backImage = [UIImage imageNamed:@"system_back_gray"];
    }
    [[UINavigationBar appearance] setBackIndicatorImage:backImage];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:backImage];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(20, 0) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = barButtonItem;
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    //按钮，item颜色
    [self.navigationController.navigationBar setTintColor:[UIColor styleLightGreenColor]];
    //背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    //标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor darkGrayColor]}];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //默认显示导航栏（tabbar5个页签手动设置隐藏，其他不用动）
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
//是否旋转
-(BOOL)shouldAutorotate{
    return NO;
}
//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
@end
