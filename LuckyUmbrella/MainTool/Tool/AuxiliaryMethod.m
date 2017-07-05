//
//  AuxiliaryMethod.m
//  LuckyUmbrella
//
//  Created by LGF on 17/6/14.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "AuxiliaryMethod.h"

@implementation AuxiliaryMethod

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

+ (CAKeyframeAnimation *)ViewJitter{
    
    //创建抖动动画
    
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    
    keyAnimaion.keyPath = @"transform.rotation";
    
    keyAnimaion.values = @[@(-20 / 230.0 * M_PI),@(0),@(20 /230.0 * M_PI),@(0)];
    
    keyAnimaion.removedOnCompletion = NO;
    
    keyAnimaion.fillMode = kCAFillModeForwards;
    
    keyAnimaion.duration = 0.3;
    
    keyAnimaion.repeatCount = 1.0;
    
    return keyAnimaion;
    
}

+ (BOOL)LocateAuthorizationRequest:(id)SelfViewController{
    
    //如果未授权则请求
    
    if ([CLLocationManager locationServicesEnabled] == NO) {

        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"" message:@"请为手机开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
        
        [Alert addAction:[UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive handler:nil]];
        
        [Alert addAction:[UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if([LGFApplication canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                
                [LGFApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                
            }
            
        }]];
        
        [SelfViewController presentViewController:Alert animated:NO completion:nil];
        
        return YES;
        
    } else {
        
        if(LGFAuthorizationStatus == kCLAuthorizationStatusDenied || LGFAuthorizationStatus == kCLAuthorizationStatusRestricted) {
            
            if (SYSREM_VERSION(10.0)) {
                
                UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"" message:@"请为小红车开启定位服务" preferredStyle:UIAlertControllerStyleAlert];
                
                [Alert addAction:[UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive handler:nil]];
                
                [Alert addAction:[UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    if([LGFApplication canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                        
                        [LGFApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                        
                    }
                    
                }]];
                
                [SelfViewController presentViewController:Alert animated:NO completion:nil];
                
            }
            
            return YES;
            
        }
        
    }
    
    return NO;
    
}

+ (BOOL)CameraAuthorizationRequest:(id)SelfViewController{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    //如果未授权则请求
    
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"" message:@"扫描二维码请打开相机服务" preferredStyle:UIAlertControllerStyleAlert];
        
        [Alert addAction:[UIAlertAction actionWithTitle:@"残忍拒绝" style:UIAlertActionStyleDestructive handler:nil]];
        
        [Alert addAction:[UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if([LGFApplication canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                
                [LGFApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                
            }
            
        }]];
        
        [SelfViewController presentViewController:Alert animated:NO completion:nil];
        
        return YES;
    }
    
    return NO;
    
}

+ (UIViewController *)ShowView:(SpecialView *)View SelfVC:(id)SelfVC {
    
    if (View.alpha == 0) {
        
        UIViewController *VC = SelfVC;
        
        [VC.childViewControllers makeObjectsPerformSelector:@selector(willMoveToParentViewController:)];
        
        [VC.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
        
        [View.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        UIViewController *ViewSB = [MainSB instantiateViewControllerWithIdentifier:View.SetViewID];
        
        ViewSB.view.frame = View.bounds;
        
        [VC addChildViewController:ViewSB];
        
        [View addSubview:ViewSB.view];
        
        return ViewSB;
        
    }
    
    return nil;
    
}

@end
