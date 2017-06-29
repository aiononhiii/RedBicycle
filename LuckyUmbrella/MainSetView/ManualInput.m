//
//  ManualInput.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/22.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "ManualInput.h"

@interface ManualInput ()

@end

@implementation ManualInput

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_PlateNumberSubmit setLGFEnabled:NO];
    
    //添加输入框输入监听
    [_PlateNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [CATransaction setCompletionBlock: ^{
        
        [_PlateNumberTextField becomeFirstResponder];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)textFieldDidChange :(UITextField *)theTextField {
    
    [_PlateNumberSubmit setLGFEnabled:theTextField.text.length ? YES : NO];
    
}

/**
 点击解锁按钮
 */
- (IBAction)ClickUnlockButton:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    //请求接口
    
    [CATransaction setCompletionBlock: ^{
        
        [self.delegate ShowPasswordUnlocked:@""];
        
    }];
    
}
/**
 点击扫二维码
 */
- (IBAction)ShowScanCode:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    [CATransaction setCompletionBlock: ^{
        
        [self.delegate ShowScanCode];
        
    }];
    
}

- (IBAction)TapManualInputView:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
    
}

@end
