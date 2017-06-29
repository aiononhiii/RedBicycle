//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon afterDelay:(NSTimeInterval)afterDelay view:(UIView *)view
{
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = text;
    
    hud.bezelView.backgroundColor = [UIColor whiteColor];
    
    hud.label.textColor = [UIColor blackColor];
    
    hud.label.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
    
    // 不屏蔽触摸
    hud.userInteractionEnabled = NO;
    
    // 再设置模式
    hud.mode = MBProgressHUDModeText;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:afterDelay];
}

#pragma mark 显示错误信息

+ (void)showError:(NSString *)error afterDelay:(NSTimeInterval)afterDelay toView:(UIView *)view{
    [self show:error icon:@"error.png" afterDelay:afterDelay view:view];
}

+ (void)showSuccess:(NSString *)success afterDelay:(NSTimeInterval)afterDelay toView:(UIView *)view{

    [self show:success icon:@"success.png" afterDelay:afterDelay view:view];
}

#pragma mark 显示一些信息

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = message;
        
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.bezelView.backgroundColor = [UIColor whiteColor];
    
    hud.label.textColor = [UIColor blackColor];

    hud.label.font = [UIFont systemFontOfSize:15];
    
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", @"hud"]]];
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

//+ (void)showSuccess:(NSString *)success
//{
//    [self showSuccess:success toView:nil];
//}
//
//+ (void)showError:(NSString *)error
//{
//    [self showError:error toView:nil];
//}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
