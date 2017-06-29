//
//  PasswordUnlocked.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordUnlockedView<NSObject>

/**
 跳到骑行页面
 */
- (void)ShowRideInTheBike:(NSString *)result;

@end

@interface PasswordUnlocked : UIViewController

@property (nonatomic,weak) id <PasswordUnlockedView>delegate;//代理方法传递数据

@property (weak, nonatomic) IBOutlet UILabel *UnlockedBicycleNumber;//解锁自行车车牌号
@property (weak, nonatomic) IBOutlet UILabel *RideCountdown;//骑行倒计时
@end
