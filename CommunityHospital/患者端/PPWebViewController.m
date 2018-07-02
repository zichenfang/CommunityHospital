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

@property (strong, nonatomic) IBOutlet UIView *testView;

@end

@implementation PPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"login"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"registSuccess"];
    
//    //添加支付通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResped:) name:@"payResp" object:nil];
//    //添加微信登录通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authResped:) name:@"authResp" object:nil];
//    //添加网络通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeb) name:@"refreshWeb" object:nil];
    
    [self.view bringSubviewToFront:self.testView];
    
}

- (IBAction)test_login:(id)sender {
    [self login];
}
- (IBAction)test_goIM:(id)sender {
    [self goIMWithTargetID:@""];
}
- (IBAction)test_baogaodan:(id)sender {
    [self receivedBaoGaoDan:@"这是报告单"];
}
- (IBAction)test_jianKangShuJu:(id)sender {
    [self receivedJianKangShuJu:@"这是健康数据"];
}
- (void)goIMWithTargetID :(NSString *)targetID{
    PPConversationViewController *chat = [[PPConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetID];
    //设置聊天会话界面要显示的标题
    chat.title = @"在线问诊";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];

}

//MARK:加载失败时点击刷新
- (IBAction)refreshWeb:(id)sender {
    [self refreshWeb];
}
- (void)refreshWeb{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    NSLog(@"%@",self.url);
}

//MARK:JS
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
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

//MARK:报告单 回调
- (void)receivedBaoGaoDan :(NSString *)content{
    if (content) {
        if (self.baoGaoDanHandler) {
            self.baoGaoDanHandler(@{@"content":content});
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
//MARK:健康数据 回调
- (void)receivedJianKangShuJu :(NSString *)content{
    if (content) {
        if (self.jianKangShuJuHandler) {
            self.jianKangShuJuHandler(@{@"content":content});
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
