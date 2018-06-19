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
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"system_back"]];;
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"system_back"]];;
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = barButtonItem;
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    //按钮，item颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor styleBlackColor]] forBarMetrics:UIBarMetricsDefault];
    //标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor]}];
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
