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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ConfirmPayment:(UIButton *)sender {
    
    [self.delegate ShowMainSetView];
    
}

@end
