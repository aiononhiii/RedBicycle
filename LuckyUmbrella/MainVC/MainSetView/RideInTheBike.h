//
//  RideInTheBike.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RideInTheBikeView<NSObject>

/**
 跳到付款页面
 */
- (void)ShowPayment:(NSString *)result;

@end

@interface RideInTheBike : UIViewController

@property (nonatomic,weak) id <RideInTheBikeView>delegate;//代理方法传递数据

@property (weak, nonatomic) IBOutlet UILabel *RidingTime;//骑行时间
@property (weak, nonatomic) IBOutlet UILabel *RidingCosts;//骑行费用
@property (weak, nonatomic) IBOutlet UILabel *TimeUnitDescription;//骑行时间单位说明
@end
