//
//  MainSet.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/23.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MainSet.h"

@interface MainSet ()

@end

@implementation MainSet

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/**
 主页二维码扫描
 */
- (IBAction)ScanCode:(UIButton *)sender {
    
    [self.delegate ShowScanCode];
    
}

/**
 点击用户图标 显示 账户详情一览
 */
- (IBAction)ShowAccount:(UIButton *)sender {
    
    [self.delegate ShowAccount];
    
}

/**
 点击礼物图标 显示 最新消息一览
 */
- (IBAction)ShowNews:(UIButton *)sender {
    
    [self.delegate ShowNews];
    
}

@end
