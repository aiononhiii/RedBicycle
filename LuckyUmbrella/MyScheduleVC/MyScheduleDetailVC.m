//
//  MyScheduleDetailVC.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/27.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MyScheduleDetailVC.h"

@interface MyScheduleDetailVC ()
@property (weak, nonatomic) IBOutlet MKMapView *MyScheduleMapView;
@property (nonatomic, strong) NSArray <NSString*>*ScheduleCoordinateArray;
@end

@implementation MyScheduleDetailVC

-(NSArray *)ScheduleCoordinateArray{
    
    if (!_ScheduleCoordinateArray) {
        
        _ScheduleCoordinateArray = [NSArray arrayWithArray:_DataDict[@"coordinatearray"]];
        
    }
    
    return _ScheduleCoordinateArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D ScheduleCoordinates[self.ScheduleCoordinateArray.count];
    
   
    for (int i = 0; i < self.ScheduleCoordinateArray.count; i++) {
        
        ScheduleCoordinates[i] = [self GetCLLocationCoordinate2DWithDictionary:(NSDictionary*)self.ScheduleCoordinateArray[i]];
        
    }
    
    //添加路线遮盖
    
    MKPolyline *SchedulePolyline = [MKPolyline polylineWithCoordinates:ScheduleCoordinates count:self.ScheduleCoordinateArray.count];

    SchedulePolyline.title = @"行程路线";
                         
    [_MyScheduleMapView addOverlay:SchedulePolyline];
                                        
    //1.添加2个大头针
    MKPointAnnotation *fromAnno = [[MKPointAnnotation alloc]init];
                                        
    fromAnno.coordinate = [self GetCLLocationCoordinate2DWithDictionary:(NSDictionary*)self.ScheduleCoordinateArray[0]];
                                        
    fromAnno.title = @"起点";
                                        
    [_MyScheduleMapView addAnnotation:fromAnno];
    
    MKPointAnnotation *toAnno = [[MKPointAnnotation alloc]init];
                                        
    toAnno.coordinate = [self GetCLLocationCoordinate2DWithDictionary:(NSDictionary*)self.ScheduleCoordinateArray[self.ScheduleCoordinateArray.count - 1]];;
                                        
    toAnno.title = @"终点";
                                        
    [_MyScheduleMapView addAnnotation:toAnno];
    
    [_MyScheduleMapView setRegion:[AuxiliaryMethod regionForAnnotations:self.ScheduleCoordinateArray] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 放置 起点 终点 大头针
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MKPointAnnotation *)annotation {
    
    static NSString *placemarkIdentifier = @"PointAnnotation";
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]){
        
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:placemarkIdentifier];
        
        if([annotation.title isEqualToString:@"起点"]){
            
            annotationView.image = [UIImage imageNamed:@"ScheduleStartPoint"];
            
        } else if ([annotation.title isEqualToString:@"终点"]){
            
            annotationView.image = [UIImage imageNamed:@"ScheduleEndPoint"];
            
        }
        
        return annotationView;
        
    }
    
    return nil;
    
}
/**
 覆盖物的回调方法
 */
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if([overlay isKindOfClass:[MKPolyline class]]){
    
        //绘制行程路径
        
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        
        //线颜色
        
        render.strokeColor = LGFColorAlpha(255, 50, 100, 0.8);
        
        render.lineWidth = 3.0;
        
        return render;
        
    }
    
    return nil;
    
}


-(CLLocationCoordinate2D)GetCLLocationCoordinate2DWithDictionary:(NSDictionary*)CoordinateDict{
    
    CLLocationCoordinate2D ScheduleLocation = CLLocationCoordinate2DMake([CoordinateDict[@"latitude"] doubleValue], [CoordinateDict[@"longitude"] doubleValue]);
    
    return ScheduleLocation;
    
}

@end
