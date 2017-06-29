//
//  AuxiliaryMethod.h
//  LuckyUmbrella
//
//  Created by LGF on 17/6/14.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

#import <UIKit/UIKit.h>

@interface AuxiliaryMethod : NSObject

/**
 判断手势方向

 @param translationInView 滑动的控件
 @param EDistance 滑动有效范围
 @return 返回一个方向
 */
+ (NSString *)PanDirectionEstimation:(CGPoint)translationInView EDistance:(CGFloat)EDistance;

/**
 制作共用sectionview

 @param SectionHeight 传进来的section高度
 @param Text 传进来的section标题
 @return SectionvIEW
 */
+ (UIView *)MakeSectionViewWithHeight:(CGFloat)SectionHeight Text:(NSString*)Text;

/**
 region范围动态控制

 @param coordinates 经纬度数组
 @return MKCoordinateRegion 显示范围
 */
+ (MKCoordinateRegion)regionForAnnotations:(NSArray *)coordinates;

/**
 uiview 抖动动画

 @return 动画 CAKeyframeAnimation
 */
+ (CAKeyframeAnimation *)ViewJitter;
@end
