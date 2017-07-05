//
//  BluetoothUnlocked.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "BluetoothUnlocked.h"

@interface BluetoothUnlocked ()

@end

@implementation BluetoothUnlocked

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    
    NSLog(@"蓝牙开锁页释放");
    
}

@end
