//
//  Payment.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "Payment.h"

@interface Payment ()

@end

@implementation Payment

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)ConfirmPayment:(UIButton *)sender {
    
    [self.delegate ShowMainSetView];
    
}

@end
