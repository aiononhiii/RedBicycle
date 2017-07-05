//
//  ManualInput.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManualInputView<NSObject>

/**
 跳到密码解锁页面
 */
- (void)ShowPasswordUnlocked:(NSString *)result;

/**
 点击扫二维码回调
 */
- (void)ShowScanCode;

/**
 如果隐藏键盘
 */
- (void)ShowManualInputWithKeyboardHeight:(CGFloat)KeyboardHeight;

/**
 如果开启键盘
 */
- (void)ShowManualInput;

@end

@interface ManualInput : UIViewController

@property (nonatomic,weak) id <ManualInputView>delegate;//代理方法传递数据

@property (weak, nonatomic) IBOutlet SpecialLabel *BillingInstructions;//计费说明

@property (weak, nonatomic) IBOutlet UILabel *ManualInputPrompt;//手动输入提示语

@property (weak, nonatomic) IBOutlet SpecialTextField *PlateNumberTextField;//手动输入text框

@property (weak, nonatomic) IBOutlet SpecialButton *PlateNumberSubmit;//手动输入提交

@end
