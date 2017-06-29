//
//  SpecialLabel.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "SpecialLabel.h"

@implementation SpecialLabel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.layer.shouldRasterize = YES;
        
        self.layer.rasterizationScale=[UIScreen mainScreen].scale;
        
    }
    
    return self;
    
}

/**
 控件圆角
 */
-(void)setCornerRadius:(CGFloat)cornerRadius{
    
    if (cornerRadius == 222.0) {
        
        self.layer.cornerRadius = (self.height * 0.95) / 2;
        
    } else {
        
        self.layer.cornerRadius = cornerRadius;
        
    }
    
}

/**
 边框颜色
 */
-(void)setBorderColor:(UIColor *)borderColor{
    
    self.layer.borderColor = borderColor.CGColor;
    
}

/**
 边框宽度
 */
-(void)setBorderWidth:(CGFloat)borderWidth{
    
    self.layer.borderWidth = borderWidth;
    
}

@end
