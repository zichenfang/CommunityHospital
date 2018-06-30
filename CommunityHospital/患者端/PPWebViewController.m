//
//  PPWebViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "PPWebViewController.h"
#import <WebKit/WebKit.h>
#import "PPLoginIndexViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "PPConversationViewController.h"

@interface PPWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) CALayer *progressLayer;
//网页加载失败时，显示此view
@property (strong, nonatomic) IBOutlet UIView *refershView;

@property (strong, nonatomic) IBOutlet UIView *testView;

@end

@implementation PPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    
    config.userContentController = [[WKUserContentController alloc] init];
    
//    [config.userContentController addScriptMessageHandler:self name:@"getUserMobileInfo"];
//    [config.userContentController addScriptMessageHandler:self name:@"setUserMobileInfo"];
//    [config.userContentController addScriptMessageHandler:self name:@"share"];
//    [config.userContentController addScriptMessageHandler:self name:@"jumpToWechatPay"];
//    [config.userContentController addScriptMessageHandler:self name:@"logOut"];
//    [config.userContentController addScriptMessageHandler:self name:@"getWechatUserInfo"];
    [config.userContentController addScriptMessageHandler:self name:@"login"];
    [config.userContentController addScriptMessageHandler:self name:@"registSuccess"];

    
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    //监控加载进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    UIView *progressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 3)];
    progressView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progressView];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor styleLightGreenColor].CGColor;
    [progressView.layer addSublayer:layer];
    self.progressLayer = layer;

    
//    //添加支付通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResped:) name:@"payResp" object:nil];
//    //添加微信登录通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authResped:) name:@"authResp" object:nil];
//    //添加网络通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeb) name:@"refreshWeb" object:nil];
    [self refreshWeb];
    
    [self.view bringSubviewToFront:self.testView];
    
}

- (IBAction)test_login:(id)sender {
    [self login];
}
- (IBAction)test_goIM:(id)sender {
    [self goIMWithTargetID:@""];
}

- (void)goIMWithTargetID :(NSString *)targetID{
    PPConversationViewController *chat = [[PPConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetID];
    //设置聊天会话界面要显示的标题
    chat.title = @"在线问诊";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.navigaitonBarHidden animated:YES];
}
//MARK:加载失败时点击刷新
- (IBAction)refreshWeb:(id)sender {
    [self refreshWeb];
}
- (void)refreshWeb{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    NSLog(@"%@",self.url);
}
- (void)test{
    [self.navigationController popViewControllerAnimated:NO];
    if (self.handler) {
        self.handler(@{});
    }
}
//MARK:JS
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message.name =%@",message.name);
    NSLog(@"message.body =%@",message.body);
    if ([message.name isEqualToString:@"login"]) {
        [self login];
    }
    //注册账号成功
    else if ([message.name isEqualToString:@"registSuccess"]){
        [self.navigationController popViewControllerAnimated:NO];
        if (self.handler) {
            self.handler(@{});
        }
    }
    //    [self.view makeToast:[NSString stringWithFormat:@"方法名：%@,\n 参数:%@",message.name,message.body]];
    
//    if ([message.name isEqualToString:@"getUserMobileInfo"]) {
//        [self ggetUserMobileInfo];
//        //#warning delete this
//        //        [self ggetWechatInfo];
//    }
//    else if ([message.name isEqualToString:@"setUserMobileInfo"]) {
//        [self ssetUserMobileInfoWithMessage:message];
//    }
//    //分享
//    else if ([message.name isEqualToString:@"share"]) {
//        [self shareWithMessage:message];
//    }
//    else if ([message.name isEqualToString:@"jumpToWechatPay"]) {
//        [self wechatPayWithMessage:message];
//    }
//    else if ([message.name isEqualToString:@"logOut"]) {
//        [TTUserInfoManager setAccount:@""];
//        [TTUserInfoManager setPassword:@""];
//        NSLog(@"phone:%@ --%@ ",[TTUserInfoManager account],[TTUserInfoManager token]);
//    }
//    else if ([message.name isEqualToString:@"getWechatUserInfo"]) {
//        [self ggetWechatInfo];
//    }
}


//alert 警告框
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"alert message:%@",message);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    self.refershView.hidden = YES;
    [self.view sendSubviewToBack:self.refershView];

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%s",__func__);
    NSLog(@"%@",error);
    self.refershView.hidden = NO;
    [self.view bringSubviewToFront:self.refershView];
}
//更新加载进度条线显示
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//MARK:登录
- (void)login{
    PPLoginIndexViewController *vc = [[PPLoginIndexViewController alloc] init];
    //登录成功之后的回调
    vc.handler = ^(NSDictionary *info) {
        NSLog(@"登录成功之后的回调");
        [self refreshWeb];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:微信登录

@end
