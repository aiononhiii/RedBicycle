//
//  ScanCode.h
//  LuckyUmbrella
//
//  Created by apple on 2017/6/18.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@protocol ScanCodeView<NSObject>

/**
 跳到密码解锁页面
 */
- (void)ShowPasswordUnlocked:(NSString *)result;

/**
 跳到蓝牙解锁页面
 */
- (void)ShowBluetoothUnlocked:(NSString *)result;

/**
 点击手动输入回调
 */
- (void)ShowManualInput;

@end

@interface ScanCode : UIViewController

@property (nonatomic,weak) id <ScanCodeView>delegate;//代理方法传递数据

@end
