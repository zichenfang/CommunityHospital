//
//  DDLoginViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/23.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "DDLoginViewController.h"
#import "DDWebViewController.h"


@interface DDLoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation DDLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //默认显示导航栏（tabbar5个页签手动设置隐藏，其他不用动）
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}
//MARK:忘记密码
- (IBAction)forgetPassWord:(id)sender {
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = URL_DOCTOR_RESET_PASSWORD;
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:用户名密码登录
- (IBAction)login:(id)sender {

}
//MARK:人脸登录
- (IBAction)loginWithFace:(id)sender {
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = URL_DOCTOR_LOGIN_FACE;
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:注册
- (IBAction)regist:(id)sender {
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = URL_DOCTOR_REGIST;
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:微信登录
- (IBAction)loginWithWechat:(id)sender {
}

@end
