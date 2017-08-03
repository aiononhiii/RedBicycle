//
//  DestinationSearchVC.h
//  LuckyUmbrella
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DestinationSearchVCDelegate<NSObject>
- (void)ShowDestination:(MKMapItem *)mapItem;
@end

@interface DestinationSearchVC : UIViewController
@property (nonatomic,weak) id <DestinationSearchVCDelegate>delegate;//代理方法传递数据
@property (assign, nonatomic) MKCoordinateRegion SuperRegion;
@end
