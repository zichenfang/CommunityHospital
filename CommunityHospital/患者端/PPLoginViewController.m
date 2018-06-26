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

@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property (nonatomic,assign) int leftCount;//验证码倒计时


@end

@implementation PPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"system_back_green"] style:UIBarButtonItemStylePlain target:self action:@selector(pop)];

    self.passWordView.hidden = NO;
    self.VCodeView.hidden = YES;
    self.forgetPasswordBtn.hidden = NO;
    if ([TTUserInfoManager account].length>1 || [TTUserInfoManager password].length>1) {
        self.phoneTF.text = [TTUserInfoManager account];
        self.passWordTF.text = [TTUserInfoManager password];
    }
    
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.layer.cornerRadius = 25;
    self.loginBtn.layer.borderWidth = 1;
    self.loginBtn.layer.borderColor = [UIColor styleLightGreenColor].CGColor;

}
//MARK:切换到用户名密码登录
- (IBAction)loginWithpassword:(id)sender {
    self.login_password_Btn.selected = YES;
    self.login_Vcode_Btn.selected = NO;
    self.passWordView.hidden = NO;
    self.VCodeView.hidden = YES;
    self.forgetPasswordBtn.hidden = NO;

    
}
//MARK:切换到短信验证码登录
- (IBAction)loginWithVCode:(id)sender {
    self.login_password_Btn.selected = NO;
    self.login_Vcode_Btn.selected = YES;
    self.passWordView.hidden = YES;
    self.VCodeView.hidden = NO;
    self.forgetPasswordBtn.hidden = YES;
}
//MARK:人脸登录
- (IBAction)loginWithFace:(id)sender {
    PPWebViewController *vc = [[PPWebViewController alloc] init];
    vc.url = URL_PATIENT_LOGIN_FACE;
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:点击登录按钮
- (IBAction)loginBtnTouched:(id)sender {
    [self.view endEditing:YES];
    //密码登录验证表单
    if (self.login_password_Btn.selected ==YES) {
//        if ([self.phoneTF.text isValidateMobile] == NO) {
//            [self.view makeToast:@"请输入11位手机号" duration:2 position:CSToastPositionCenter];
//            return;
//        }
        if (self.passWordTF.text.absoluteString.length==0) {
            [self.view makeToast:@"请输入密码" duration:2 position:CSToastPositionCenter];
            return;
        }
        [self requestLoginWithPassword];
    }
    //验证码登录验证表单
    else{
        
    }
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestLoginWithPassword{
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:self.phoneTF.text forKey:@"userName"];
    [para setObject:self.passWordTF.text.absoluteString forKey:@"password"];
    [self.view makeToastActivity:CSToastPositionCenter];
    self.view.userInteractionEnabled = NO;
    [TTRequestOperationManager GET:API_USER_LOGIN_WITH_PASSWORD Parameters:para Success:^(NSDictionary *responseJsonObject) {
        [self.view hideToastActivity];
        self.view.userInteractionEnabled = YES;
        NSString *code = [responseJsonObject string_ForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *userInfo = [responseJsonObject dictionary_ForKey:@"data"];
            [TTUserInfoManager setUserInfo:userInfo];
            [TTUserInfoManager setLogined:YES];
            [TTUserInfoManager setAccount:self.phoneTF.text];
            [TTUserInfoManager setPassword:self.passWordTF.text];
            [[NSNotificationCenter defaultCenter] postNotificationName:kNoti_ConnectRongCloud object:nil];
            if (self.handler) {
                self.handler(@{});
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            NSString *msg = [responseJsonObject string_ForKey:@"msg"];
            [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
        }
    } Failure:^(NSError *error) {
        [self.view hideToastActivity];
        self.view.userInteractionEnabled = YES;
    }];
}
//MARK:忘记密码
- (IBAction)forgetPassWord:(id)sender {
    PPWebViewController *vc = [[PPWebViewController alloc] init];
    vc.url = URL_PATIENT_RESET_PASSWORD;
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:获取验证码
- (IBAction)obtainMsgCode:(id)sender {
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    [para setObject:@"zz" forKey:@""];
    self.codeBtn.userInteractionEnabled = NO;
    [self.view makeToastActivity:CSToastPositionCenter];
    [TTRequestOperationManager GET:URL_PATIENT_GET_MSG_CODE Parameters:para Success:^(NSDictionary *responseJsonObject) {
        [self.view hideToastActivity];
        self.codeBtn.userInteractionEnabled = YES;
        NSString *code = [responseJsonObject string_ForKey:@"code"];
        if ([code isEqualToString:@"200"]) {
            [self.view makeToast:@"发送成功" duration:2 position:CSToastPositionCenter];
            [self startTimeLimit];
        }
        else{
            NSString *msg = [responseJsonObject string_ForKey:@"msg"];
            [self.view makeToast:msg duration:2 position:CSToastPositionCenter];
        }
    } Failure:^(NSError *error) {
        [self.view hideToastActivity];
        [self.view makeToast:@"发送失败" duration:2 position:CSToastPositionCenter];
        self.codeBtn.userInteractionEnabled = YES;
    }];
}
- (void)startTimeLimit{
    self.codeBtn.enabled = NO;
    self.leftCount = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(self.leftCount<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.codeBtn.enabled = YES;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.leftCount = self.leftCount-1;
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%d s",self.leftCount] forState:UIControlStateDisabled];
            });
        }
    });
    dispatch_resume(_timer);
}

@end
