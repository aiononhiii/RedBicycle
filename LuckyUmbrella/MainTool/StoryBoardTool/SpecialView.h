//
//  SpecialView.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface SpecialView : UIView

@property (nonatomic, strong) IBInspectable NSString *SetViewID;

@property (nonatomic ,assign) IBInspectable UIColor *borderColor;

@property (nonatomic , assign) IBInspectable CGFloat borderWidth;

@property (nonatomic , assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic ,assign) IBInspectable UIColor *shadowColor;

@property (nonatomic , assign) IBInspectable float shadowOpacity;

@property (nonatomic , assign) IBInspectable CGFloat shadowRadius;

@property (nonatomic , assign) IBInspectable CGSize shadowOffset;

@end
