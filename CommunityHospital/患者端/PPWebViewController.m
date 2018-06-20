//
//  PPWebViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "PPWebViewController.h"
#import <WebKit/WebKit.h>

@interface PPWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;

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
    
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
//    //添加支付通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResped:) name:@"payResp" object:nil];
//    //添加微信登录通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authResped:) name:@"authResp" object:nil];
//    //添加网络通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeb) name:@"refreshWeb" object:nil];
    [self refreshWeb];
}

- (void)refreshWeb{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}


@end
