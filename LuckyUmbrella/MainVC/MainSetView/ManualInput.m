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
    
    //键盘监听
    [LGFNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [LGFNotificationCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //添加输入框输入监听
    [_PlateNumberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [CATransaction setCompletionBlock: ^{
        
        [_PlateNumberTextField becomeFirstResponder];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [LGFNotificationCenter removeObserver:self];
    
}

- (void)dealloc {
    
    NSLog(@"手动输入页释放");
    
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

#pragma mark 键盘监听

- (void)keyboardWillShow:(NSNotification *)note {
    
    CGFloat keyBoardheight = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [self.delegate ShowManualInputWithKeyboardHeight:-self.view.height * 0.4 - keyBoardheight];
    
}

- (void)keyboardWillHide:(NSNotification *)note {
    
    [self.delegate ShowManualInput];
    
}

@end
