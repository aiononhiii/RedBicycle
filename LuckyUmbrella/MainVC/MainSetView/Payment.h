//
//  Payment.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaymentView<NSObject>

/**
 跳到骑行页面
 */
- (void)ShowMainSetView;

@end

@interface Payment : UIViewController

@property (nonatomic,weak) id <PaymentView>delegate;//代理方法传递数据

@end
