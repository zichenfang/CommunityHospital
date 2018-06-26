//
//  PPLoginIndexViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "PPLoginIndexViewController.h"
#import "PPWebViewController.h"
#import "PPLoginViewController.h"
#import "WxApi.h"



@interface PPLoginIndexViewController ()
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registBtn;

@end

@implementation PPLoginIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 25;
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [UIColor styleLightGreenColor].CGColor;
    
    self.registBtn.layer.masksToBounds = YES;
    self.registBtn.layer.cornerRadius = 25;
    self.registBtn.layer.borderWidth = 1;
    self.registBtn.layer.borderColor = [UIColor styleLightGreenColor].CGColor;
}

- (IBAction)login:(id)sender {
    PPLoginViewController *vc = [[PPLoginViewController alloc] init];
    vc.handler = self.handler;
    [self.navigationController pushViewController:vc animated:YES];
}
//患者注册
- (IBAction)regist:(id)sender {
    PPWebViewController *mainVC = [[PPWebViewController alloc] init];
    mainVC.url = URL_PATIENT_REGIST;
    mainVC.handler = ^(NSDictionary *info) {
      //注册成功后，跳转到登录页面
        [self login:nil];
    };
    [self.navigationController pushViewController:mainVC animated:YES];
}
- (IBAction)deal:(id)sender {
}
- (IBAction)wechatLogin:(id)sender {
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"zsm_jt";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}
@end
