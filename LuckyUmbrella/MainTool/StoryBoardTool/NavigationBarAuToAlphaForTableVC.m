//
//  NavigationBarAuToAlphaForTableVC.m
//  LuckyUmbrella
//
//  Created by apple on 2017/7/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#define offsetToShow 100.0//滑动多少就完全显示

#import "NavigationBarAuToAlphaForTableVC.h"

@interface NavigationBarAuToAlphaForTableVC ()

@end

@implementation NavigationBarAuToAlphaForTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置一张空的图片
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1.0];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat alpha = 1 - (offsetToShow - scrollView.contentOffset.y) / offsetToShow;
    
    if (alpha <= 1.1 && alpha >= 0) [self setNavSubViewsAlpha:alpha];
    
}

- (void)setNavSubViewsAlpha:(CGFloat)alpha {
    NSLog(@"%f",alpha);
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1 - alpha green:1 - alpha blue:1 - alpha alpha:1.0]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:1 - alpha green:1 - alpha blue:1 - alpha alpha:1.0]}];
    
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

@end
