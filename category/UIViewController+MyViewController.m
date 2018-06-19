//
//  UIViewController+MyViewController.m
//  WhaleShop
//
//  Created by 殷玉秋 on 2017/10/20.
//  Copyright © 2017年 HeiziTech. All rights reserved.
//

#import "UIViewController+MyViewController.h"

@implementation UIViewController (MyViewController)
- (void)presentToastAlertWithTitle :(NSString *)title Handler :(void(^)(void))handler{
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alerVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }]];
    [self presentViewController:alerVC animated:YES completion:nil];
}

- (void)presentAlertWithTitle :(NSString *)title Handler :(void(^)(void))handler Cancel :(void(^)(void))cancel{
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alerVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancel) {
            cancel();
        }
    }]];
    [alerVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }]];
    [self presentViewController:alerVC animated:YES completion:nil];
}
- (void)presentDestructiveAlertWithTitle :(NSString *)title Handler :(void(^)(void))handler{
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alerVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
    [alerVC addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (handler) {
            handler();
        }
    }]];
    [self presentViewController:alerVC animated:YES completion:nil];
}
@end
