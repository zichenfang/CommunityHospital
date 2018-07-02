//
//  DDConversationViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/7/2.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "DDConversationViewController.h"
#import "DDWebViewController.h"

@interface DDConversationViewController ()

@end

@implementation DDConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
    barButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    
    
    // Do any additional setup after loading the view.
    //移除掉原来自带的“拍摄”，“位置”
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:2];
    [self.chatSessionInputBarControl.pluginBoardView removeItemAtIndex:1];
    //更新“图片”按钮的图片
    [self.chatSessionInputBarControl.pluginBoardView updateItemAtIndex:0 image:[UIImage imageNamed:@"board_tupian"] title:@"照片"];
    //添加语音通话扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_yuyintonghua"] title:@"语音通话" tag:2000];
    //添加视频问诊扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_shipin"] title:@"视频问诊" tag:2001];
    //添加在线诊疗扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_zaixianzhenliao"] title:@"在线诊疗" tag:2002];
    //添加推荐药物扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_tuijianyaowu"] title:@"推荐药物" tag:2003];
    
    //添加就诊记录扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_jiuzhenjilu"] title:@"就诊记录" tag:2004];
    //添加挂号扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_guahao"] title:@"挂号" tag:2005];
    //添加发起评价扩张按钮
    [self.chatSessionInputBarControl.pluginBoardView insertItemWithImage:[UIImage imageNamed:@"board_pingjia"] title:@"发起评价" tag:2006];


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //默认显示导航栏（tabbar5个页签手动设置隐藏，其他不用动）
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    RCTextMessageCell *textCell = (RCTextMessageCell *)cell;
    if ([textCell isMemberOfClass:NSClassFromString(@"RCTextMessageCell")]) {
        textCell.textLabel.textColor = [UIColor whiteColor];
    }
}
- (void)didTapUrlInMessageCell:(NSString *)url model:(RCMessageModel *)model{
    //更改融云跳转URL方式，跳转到自己的web中
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pluginBoardView:(RCPluginBoardView *)pluginBoardView clickedItemWithTag:(NSInteger)tag{
    [super pluginBoardView:pluginBoardView clickedItemWithTag:tag];
    NSLog(@"%ld",tag);
    if (tag == 2000) {
        //语音通话
    }
    else if (tag == 2001){
        //视频问诊
    }
    else if (tag == 2002){
        //在线诊疗
        [self zaiXianZhenLiaoWeb];
    }
    else if (tag == 2003){
        //推荐药物
        [self tuiJianYaoWuWeb];
    }
    else if (tag == 2004){
        //就诊记录
        [self jiuZhenJiLuWeb];
    }
    else if (tag == 2005){
        //挂号
        [self guaHaoWeb];
    }
    else if (tag == 2006){
        //发起评价
        [self pingJia];
    }
}

//MARK:语音通话

//MARK:视频问诊


//MARK:在线诊疗
- (void)zaiXianZhenLiaoWeb{
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = @"";
    vc.customNavigationTitle = @"在线诊疗";
    vc.zaiXianZhenLiaoHandler = ^(NSDictionary *info) {
        NSLog(@"在线诊疗 :%@",info);
        NSString *content = [info objectForKey:@"content"];
        [self sendTextMessageContent:content Title:@"在线诊疗"];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//MARK:推荐药物
- (void)tuiJianYaoWuWeb{
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = @"";
    vc.customNavigationTitle = @"推荐药物";
    vc.tuiJianYaoWuHandler = ^(NSDictionary *info) {
        NSLog(@"推荐药物 :%@",info);
        NSString *content = [info objectForKey:@"content"];
        [self sendTextMessageContent:content Title:@"推荐药物"];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:就诊记录
- (void)jiuZhenJiLuWeb{
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = @"";
    vc.customNavigationTitle = @"就诊记录";
    vc.jiuZhenJiLuHandler = ^(NSDictionary *info) {
        NSLog(@"就诊记录 :%@",info);
        NSString *content = [info objectForKey:@"content"];
        [self sendTextMessageContent:content Title:@"就诊记录"];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:挂号
- (void)guaHaoWeb{
    DDWebViewController *vc = [[DDWebViewController alloc] init];
    vc.url = @"";
    vc.customNavigationTitle = @"挂号";
    vc.guaHaoHandler = ^(NSDictionary *info) {
        NSLog(@"挂号 :%@",info);
        NSString *content = [info objectForKey:@"content"];
        [self sendTextMessageContent:content Title:@"挂号"];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}
//MARK:发起评价
- (void)pingJia{
    RCRichContentMessage *richMsg = [RCRichContentMessage messageWithTitle:@"评价" digest:@"请对我的服务做出评价" imageURL:@"https://www.baidu.com/img/bd_logo1.png" url:@"https://www.baidu.com/" extra:nil];
    [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.targetId content:richMsg pushContent:@"评价" pushData:@"评价" success:^(long messageId) {
        NSLog(@"sendMessage success,messageId=%ld",messageId);
    } error:^(RCErrorCode nErrorCode, long messageId) {
        NSLog(@"sendMessage error,messageId=%ld",messageId);
    }];
}

- (void)sendTextMessageContent :(NSString *)content Title :(NSString *)title{
    RCTextMessage *txtMsg = [RCTextMessage messageWithContent:content];
    [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.targetId content:txtMsg pushContent:title pushData:title success:^(long messageId) {
        NSLog(@"sendMessage success,messageId=%ld",messageId);
    } error:^(RCErrorCode nErrorCode, long messageId) {
        NSLog(@"sendMessage error,messageId=%ld",messageId);
    }];
    
}
@end
