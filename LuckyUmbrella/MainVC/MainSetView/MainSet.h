//
//  MainSet.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/23.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainSetView<NSObject>

/**
 点击礼物图标 显示 最新消息一览
 */
- (void)ShowNews;

/**
 点击用户图标 显示 账户详情一览
 */
- (void)ShowAccount;

/**
 点击扫二维码回调
 */
- (void)ShowScanCode;

@end

@interface MainSet : UIViewController

@property (nonatomic,weak) id <MainSetView>delegate;//代理方法传递数据

@property (weak, nonatomic) IBOutlet SpecialButton *ScanCodeButton;//开启二维码扫描

@property (weak, nonatomic) IBOutlet SpecialButton *AccountButton;//跳转用户信息

@property (weak, nonatomic) IBOutlet SpecialButton *NewNoticeButton;//跳转最新消息页面按钮

/**
 设置view动画更新
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SetViewTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NewLocationBottom;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SetViewMainViewMiddle;

@end
