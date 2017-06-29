//
//  SetView.m
//  LuckyUmbrella
//
//  Created by LGF on 17/6/9.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "SetView.h"

@implementation SetView


-(void)drawRect:(CGRect)rect{
    
    float SHeight;
    
    if ([_ViewName isEqualToString:@"MapSetView"]) {
        
        SHeight = self.frame.size.height / 3;
        
    } else {
        
        SHeight = self.frame.size.height / 3;
        
    }
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextMoveToPoint(context, 0, SHeight * 0.2);//圆弧的起始点
    
    CGContextAddQuadCurveToPoint(context, self.frame.size.width / 2, - SHeight * 0.2, self.frame.size.width, SHeight * 0.2);//画圆弧
    
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    
    CGContextAddLineToPoint(context, 0, self.frame.size.height);
    
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setFill];
    
    [[UIColor clearColor] setStroke];
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

@end
