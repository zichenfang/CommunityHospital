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
    [self.navigationController pushViewController:mainVC animated:YES];
}
- (IBAction)deal:(id)sender {
}
- (IBAction)wechatLogin:(id)sender {
}
@end
