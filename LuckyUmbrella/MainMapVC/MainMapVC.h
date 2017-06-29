//
//  MainMapVC.h
//  LuckyUmbrella
//
//  Created by LGF on 17/6/7.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NonePage,
    MainSetPage,
    ScanCodePage,
    ManualInputPage,
    PasswordUnlockedPage,
    RideInTheBikePage,
    PaymentPage
} SetViewType;

@interface MainMapVC : UIViewController

@end
