//
//  MBProgressHUD+MJ.h
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (MJ)
+ (void)showError:(NSString *)error afterDelay:(NSTimeInterval)afterDelay toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success afterDelay:(NSTimeInterval)afterDelay toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

//+ (void)showSuccess:(NSString *)success;
//+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
