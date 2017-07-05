//
//  PasswordUnlocked.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "PasswordUnlocked.h"

@interface PasswordUnlocked ()
{
    XTimer *CenterTimer;
}
@end

@implementation PasswordUnlocked

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化计时中心
    CenterTimer = [XTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(RideCountdownRun) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [CenterTimer invalidate];
    
}

- (void)dealloc {
    
    NSLog(@"密码解锁页释放");

}

/**
 准备骑行倒计时开启
 */
- (void)RideCountdownRun {
    
    _RideCountdown.text = [NSString stringWithFormat:@"%ds",[[_RideCountdown.text substringToIndex:2] intValue] - 1];
    
    if ([_RideCountdown.text isEqualToString:@"0s"]) {
        
        [CenterTimer invalidate];
        
        [self.delegate ShowRideInTheBike:@""];
        
    }
    
}

@end
