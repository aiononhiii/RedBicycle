//
//  AuxiliaryMethod.m
//  LuckyUmbrella
//
//  Created by LGF on 17/6/14.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "AuxiliaryMethod.h"

@implementation AuxiliaryMethod

/**
 判断手势方向
 
 @param translationInView 滑动的控件
 @param EDistance 滑动有效范围
 @return 返回一个方向
 */
+ (NSString *)PanDirectionEstimation:(CGPoint)translationInView EDistance:(CGFloat)EDistance {
    
    CGFloat absX = fabs(translationInView.x);
    
    CGFloat absY = fabs(translationInView.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) < EDistance) return @"无效";
    
    if (absX > absY ) {
        
        if (translationInView.x < 0) {
            
            //向左滑动
            return @"左";
            
        }else{
            
            //向右滑动
            return @"左";
            
        }
        
    } else if (absY > absX) {
        
        if (translationInView.y < 0) {
            
            //向上滑动
            return @"上";
            
        }else{
            
            //向下滑动
            return @"下";
            
        }
        
    }
    
    return @"无效";
}

/**
 制作共用sectionview
 
 @param SectionHeight 传进来的section高度
 @param Text 传进来的section标题
 @return SectionvIEW
 */
+ (UIView *)MakeSectionViewWithHeight:(CGFloat)SectionHeight Text:(NSString *)Text {
    
    CGRect frame = CGRectMake(-2, 0, LGFScreenW + 4, SectionHeight);
    
    UIView *SectionView = [[UIView alloc]initWithFrame:frame];
    
    SectionView.layer.borderWidth = 1.0;
    
    SectionView.layer.borderColor = LGFColor(235, 235, 235).CGColor;
    
    SectionView.backgroundColor = LGFColor(250, 250, 250);
    
    CGRect labelframe = CGRectMake(SectionView.width * 0.05, SectionView.height / 4, SectionView.width * 0.9, SectionView.height / 2);
    
    UILabel *label = [[UILabel alloc]initWithFrame:labelframe];
    
    label.font = [UIFont systemFontOfSize:12];
    
    label.textColor = [UIColor blackColor];
    
    label.text = Text;
    
    [SectionView addSubview:label];
    
    return SectionView;
}

/**
 region范围动态控制
 
 @param coordinates 经纬度数组
 @return MKCoordinateRegion 显示范围
 */
+ (MKCoordinateRegion)regionForAnnotations:(NSArray *)coordinates {
    
    __block double minLat, maxLat;
    __block double minLon, maxLon;
    
    [coordinates enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        double latitude;//经度
        double longitude;//纬度
        
        if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSMutableDictionary class]]) {
            
            NSDictionary *coordinate = obj;
            
            latitude = [coordinate[@"latitude"] doubleValue];
            
            longitude = [coordinate[@"longitude"] doubleValue];
            
        } else {
            
            MKRouteStep *coordinate = obj;
            
            latitude = coordinate.polyline.coordinate.latitude;
            
            longitude = coordinate.polyline.coordinate.longitude;
            
        }

        if (idx == 0) {
            
            //以第一个坐标点做初始值
            minLat = latitude;
            maxLat = latitude;
            minLon = longitude;
            maxLon = longitude;
            
        }else{
            
            //对比筛选出最小纬度，最大纬度；最小经度，最大经度
            minLat = MIN(minLat, latitude);
            maxLat = MAX(maxLat, latitude);
            minLon = MIN(minLon, longitude);
            maxLon = MAX(maxLon, longitude);
            
        }
        
    }];
    
    CLLocationCoordinate2D centCoor;
    
    centCoor.latitude = (CLLocationDegrees)((maxLat + minLat) * 0.5f);
    
    centCoor.longitude = (CLLocationDegrees)((maxLon + minLon) * 0.5f);
    
    MKCoordinateSpan span;
    
    //计算地理位置的跨度
    span.latitudeDelta = (maxLat - minLat) * 1.5;
    
    span.longitudeDelta = (maxLon - minLon) * 1.5;
    
    //得出数据的坐标区域
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centCoor, span);
    
    return region;
    
}

/**
 uiview 抖动动画
 
 @return 动画 CAKeyframeAnimation
 */
+ (CAKeyframeAnimation *)ViewJitter{
    
    //创建抖动动画
    
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    
    keyAnimaion.keyPath = @"transform.rotation";
    
    keyAnimaion.values = @[@(-20 / 230.0 * M_PI),@(0),@(20 /230.0 * M_PI),@(0)];
    
    keyAnimaion.removedOnCompletion = NO;
    
    keyAnimaion.fillMode = kCAFillModeForwards;
    
    keyAnimaion.duration = 0.4;
    
    keyAnimaion.repeatCount = 1.0;
    
    return keyAnimaion;
    
}
@end
