//
//  PPWebViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "TTBaseWebViewController.h"


@interface TTBaseWebViewController ()
@property (strong, nonatomic) IBOutlet UIButton *refreshBtn;

@property (strong, nonatomic) IBOutlet UIButton *mainBtn;

@end

@implementation TTBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.customNavigationTitle) {
        self.navigationItem.title = self.customNavigationTitle;
    }
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    config.preferences = [WKPreferences new];
    config.preferences.javaScriptEnabled = YES;
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    config.userContentController = [[WKUserContentController alloc] init];

    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    [self prepareProgressView];
    [self prepareLoadFaildView];

    [self backToMainWeb];
}

- (void)prepareProgressView{
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

}
- (void)prepareLoadFaildView{
    self.refershView = [[NSBundle mainBundle] loadNibNamed:@"WebLoadFaildView" owner:self options:nil][0];
    self.refershView.frame = self.view.bounds;
    [self.view addSubview:self.refershView];
    self.refershView.hidden = YES;
    UIButton *resreshBtn = [self.refershView viewWithTag:100];
    resreshBtn.layer.masksToBounds = YES;
    resreshBtn.layer.cornerRadius = 17.5;
    resreshBtn.layer.borderWidth = 1;
    resreshBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [resreshBtn addTarget:self action:@selector(refreshWeb) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backToMainBtn = [self.refershView viewWithTag:101];
    backToMainBtn.layer.masksToBounds = YES;
    backToMainBtn.layer.cornerRadius = 17.5;
    backToMainBtn.layer.borderWidth = 1;
    backToMainBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [backToMainBtn addTarget:self action:@selector(backToMainWeb) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.navigaitonBarHidden animated:YES];
}
- (void)refreshWeb{
    if (self.webView.URL) {
        [self.webView reload];
    }
    else{
        [self backToMainWeb];
    }
    NSLog(@"%@",self.webView.URL);
}
- (void)backToMainWeb{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

//MARK:JS
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
//    NSLog(@"baseWeb message.name =%@",message.name);
//    NSLog(@"baseWeb message.body =%@",message.body);
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
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"%s",__func__);
    NSLog(@"%@",error);
    self.refershView.hidden = NO;
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


@end
