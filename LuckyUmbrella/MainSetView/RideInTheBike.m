//
//  RideInTheBike.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "RideInTheBike.h"

@interface RideInTheBike ()
{
    XTimer *CenterTimer;
}
@end

@implementation RideInTheBike

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化计时中心
    CenterTimer = [XTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(RideInTheBikeRun) userInfo:nil repeats:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

}

/**
 结束行程
 */
- (IBAction)EndTheTrip:(UIButton *)sender {
    
    [CenterTimer invalidate];
    
    [self.delegate ShowPayment:@""];
    //    [self SetViewSetConstant:-_SetView.frame.size.height * 0.1 SetViewType:RideInTheBikePage];
    
}

/**
 显示 《安全保障》 详情
 */
- (IBAction)ShowSecurity:(UIButton *)sender {
}

/**
 骑行计时开启
 */
- (void)RideInTheBikeRun {
    
    int totalSeconds = [[_RidingTime.text componentsSeparatedByString:@":"][0] intValue] * 3600 + [[_RidingTime.text componentsSeparatedByString:@":"][1] intValue] * 60 + [[_RidingTime.text componentsSeparatedByString:@":"][2] intValue] + 1;
    
    _RidingTime.text = [NSString stringWithFormat:@"%02d:%02d:%02d",totalSeconds / 3600, (totalSeconds / 60) % 60, totalSeconds % 60];
    
}

@end
