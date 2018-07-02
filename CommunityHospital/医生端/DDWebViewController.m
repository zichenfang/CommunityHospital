//
//  DDWebViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/7/2.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "DDWebViewController.h"
#import "DDConversationViewController.h"

@interface DDWebViewController ()<WKScriptMessageHandler>
@property (strong, nonatomic) IBOutlet UIView *testView;

@end

@implementation DDWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"login"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"registSuccess"];
    [self.view bringSubviewToFront:self.testView];
}
//MARK:JS
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    [super userContentController:userContentController didReceiveScriptMessage:message];
    NSLog(@"DDWeb message.name =%@",message.name);
    NSLog(@"DDWeb message.body =%@",message.body);
}

- (IBAction)test_goIM:(id)sender {
    [self goIMWithTargetID:@""];
}
- (IBAction)test_zaiXianZhenLiao:(id)sender {
    [self receivedZaiXianZhenLiao:@"这是在线诊疗"];
}
- (IBAction)test_tuiJianYaoWu:(id)sender {
    [self receivedTuiJianYaoWu:@"这是推荐药物"];
}
- (void)goIMWithTargetID :(NSString *)targetID{
    DDConversationViewController *chat = [[DDConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetID];
    //设置聊天会话界面要显示的标题
    chat.title = @"在线问诊";
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
    
}
//MARK:在线诊疗 回调
- (void)receivedZaiXianZhenLiao :(NSString *)content{
    if (content) {
        if (self.zaiXianZhenLiaoHandler) {
            self.zaiXianZhenLiaoHandler(@{@"content":content});
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
//MARK:推荐药物 回调
- (void)receivedTuiJianYaoWu :(NSString *)content{
    if (content) {
        if (self.tuiJianYaoWuHandler) {
            self.tuiJianYaoWuHandler(@{@"content":content});
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
//MARK:就诊记录 回调
- (void)receivedJiuZhenJiLu :(NSString *)content{
    if (content) {
        if (self.jiuZhenJiLuHandler) {
            self.jiuZhenJiLuHandler(@{@"content":content});
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
//MARK:挂号 回调
- (void)receivedGuaHao :(NSString *)content{
    if (content) {
        if (self.guaHaoHandler) {
            self.guaHaoHandler(@{@"content":content});
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
