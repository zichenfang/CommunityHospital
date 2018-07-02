//
//  DDWebViewController.h
//  CommunityHospital
//
//  Created by 方子辰 on 2018/7/2.
//  Copyright © 2018年 方子辰. All rights reserved.
//

#import "TTBaseWebViewController.h"

@interface DDWebViewController : TTBaseWebViewController
//在线诊疗
@property (nonatomic,strong)TTBlock zaiXianZhenLiaoHandler;
//推荐药物
@property (nonatomic,strong)TTBlock tuiJianYaoWuHandler;
//就诊记录
@property (nonatomic,strong)TTBlock jiuZhenJiLuHandler;
//挂号
@property (nonatomic,strong)TTBlock guaHaoHandler;

@end
