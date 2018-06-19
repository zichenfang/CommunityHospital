//
//  PPLoginViewController.m
//  CommunityHospital
//
//  Created by 方子辰 on 2018/6/19.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "PPLoginViewController.h"

@interface PPLoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *login_password_Btn;
@property (strong, nonatomic) IBOutlet UIButton *login_Vcode_Btn;
@property (strong, nonatomic) IBOutlet UIView *passWordView;
@property (strong, nonatomic) IBOutlet UIView *VCodeView;
@property (strong, nonatomic) IBOutlet UIButton *forgetPasswordBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;


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

@end
