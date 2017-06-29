//
//  SpecialButton.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "SpecialButton.h"

@implementation SpecialButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        self.layer.shouldRasterize = YES;
        
        self.layer.rasterizationScale=[UIScreen mainScreen].scale;
        
        [self addTarget:self action:@selector(SelfButtonSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
    
}

-(void)SelfButtonSelect{
    
    if ([_buttontype isEqualToString:@"Flashlight"]) {//手电筒
        
        self.selected = !self.selected;
        
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if ([device hasTorch]) {
            
            [device lockForConfiguration:nil];
            
            if (self.selected) {
                
                self.layer.shadowOpacity = 1.0;
                
                [device setTorchMode:AVCaptureTorchModeOn];//手电筒打开
                
            } else {
                
                self.layer.shadowOpacity = 0.0;
                
                [device setTorchMode:AVCaptureTorchModeOff];//手电筒关闭
                
            }
            
            [device unlockForConfiguration];
            
        }
        
    }
    
}

-(void)setLGFEnabled:(BOOL)enabled{
    
    [self setEnabled:enabled];
    
    if (enabled) {
        
        self.layer.shadowOpacity = 1.0;
        
    } else {
        
        self.layer.shadowOpacity = 0.0;
        
    }
    
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

/**
 阴影颜色
 */
-(void)setShadowColor:(UIColor *)shadowColor{
    
    self.layer.shadowColor = shadowColor.CGColor;
    
}

/**
 阴影圆角
 */
-(void)setShadowRadius:(CGFloat)shadowRadius{
    
    if (shadowRadius == 222.0) {
        
        self.layer.shadowRadius = self.height / 2;
        
    } else {
        
        self.layer.shadowRadius = shadowRadius;
        
    }
    
}

/**
 阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
 */
-(void)setShadowOffset:(CGSize)shadowOffset{
    
    self.layer.shadowOffset = shadowOffset;
    
}

/**
 阴影透明度
 */
-(void)setShadowOpacity:(float)shadowOpacity{
    
    self.layer.shadowOpacity = shadowOpacity;
    
}

@end
