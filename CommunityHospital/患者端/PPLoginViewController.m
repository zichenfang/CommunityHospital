//
//  PPLoginViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "PPLoginViewController.h"
#import "PPWebViewController.h"

@interface PPLoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *login_password_Btn;
@property (strong, nonatomic) IBOutlet UIButton *login_Vcode_Btn;
@property (strong, nonatomic) IBOutlet UIView *passWordView;
@property (strong, nonatomic) IBOutlet UIView *VCodeView;
@property (strong, nonatomic) IBOutlet UIButton *forgetPasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *passWordTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;


@end

@implementation PPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn.frame = CGRectMake(0, 0, 60, 40);
//
//    btn.backgroundColor = [UIColor lightGrayColor];
//    [btn setImage:[UIImage imageNamed:@"system_back_green"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back_green"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];

    self.passWordView.hidden = NO;
    self.VCodeView.hidden = YES;
    self.forgetPasswordBtn.hidden = NO;
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 25;
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [UIColor styleLightGreenColor].CGColor;

}

- (IBAction)loginWithpassword:(id)sender {
    self.login_password_Btn.selected = YES;
    self.login_Vcode_Btn.selected = NO;
    self.passWordView.hidden = NO;
    self.VCodeView.hidden = YES;
    self.forgetPasswordBtn.hidden = NO;
    if ([self.phoneTF.text isValidateMobile] == NO) {
        [self.view makeToast:@"请输入11位手机号" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.passWordTF.text.absoluteString.length==0) {
        [self.view makeToast:@"请输入密码" duration:2 position:CSToastPositionCenter];
        return;
    }
    [self requestLoginWithPassword];
    
}
- (IBAction)loginWithVCode:(id)sender {
    self.login_password_Btn.selected = NO;
    self.login_Vcode_Btn.selected = YES;
    self.passWordView.hidden = YES;
    self.VCodeView.hidden = NO;
    self.forgetPasswordBtn.hidden = YES;
}
- (IBAction)loginWithFace:(id)sender {
    
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestLoginWithPassword{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.phoneTF.text forKey:@"userName"];
    [para setObject:self.passWordTF.text.absoluteString.md5_32Bit_String forKey:@"password"];
    [self.view makeToastActivity:CSToastPositionCenter];
    [TTRequestOperationManager POST:API_USER_LOGIN_WITH_PASSWORD Parameters:para Success:^(NSDictionary *responseJsonObject) {
        [self.view hideToastActivity];
        NSString *code = [responseJsonObject string_ForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            [self.view makeToast:@"登录成功" duration:2 position:CSToastPositionCenter];
            NSDictionary *userInfo = [responseJsonObject dictionary_ForKey:@"data"];
            [TTUserInfoManager setUserInfo:userInfo];
            [TTUserInfoManager setLogined:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_ConnectRongCloud object:nil];
            PPWebViewController *mainVC = [[PPWebViewController alloc] init];
            mainVC.url = @"http://www.qq.com/";
            [UIApplication sharedApplication].keyWindow.rootViewController = mainVC;
        }
        else{
            NSString *msg = [responseJsonObject string_ForKey:@"msg"];
            [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
        }
    } Failure:^(NSError *error) {
        [self.view hideToastActivity];
    }];
}
@end
