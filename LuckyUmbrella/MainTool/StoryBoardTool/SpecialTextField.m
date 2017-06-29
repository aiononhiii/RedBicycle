//
//  SpecialTextField.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "SpecialTextField.h"

@implementation SpecialTextField

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {

        self.layer.shouldRasterize = YES;
        
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        self.inputAccessoryView = [self addToolbar];

    }
    
    return self;
    
}

- (UIView *)addToolbar {
    
    UIView *toolbar = [[UIView alloc]initWithFrame:CGRectMake(-2, 0, LGFScreenW + 4, 40)];
    
    toolbar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    toolbar.layer.borderWidth = 0.5;
    
    toolbar.backgroundColor = [UIColor whiteColor];
    
//    UIButton *prevItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, toolbar.width * 0.1, toolbar.height)];
//    
//    [prevItem setTitle:@"  <  " forState:UIControlStateNormal];
//    
//    [prevItem setTitleColor:LGFColor(255, 50, 100) forState:UIControlStateNormal];
//    
//    [prevItem addTarget:self action:@selector(numberkeyboard) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *nextItem = [[UIButton alloc]initWithFrame:CGRectMake(toolbar.width * 0.1, 0, toolbar.width * 0.1, toolbar.height)];
//    
//    [nextItem setTitle:@"  >  " forState:UIControlStateNormal];
//    
//    [nextItem setTitleColor:LGFColor(255, 50, 100) forState:UIControlStateNormal];
//    
//    [nextItem addTarget:self action:@selector(otherkeyboard) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *doneItem = [[UIButton alloc]initWithFrame:CGRectMake(toolbar.width * 0.8, 0, toolbar.width * 0.2, toolbar.height)];
    
    [doneItem setTitle:@"确定" forState:UIControlStateNormal];
    
    [doneItem setTitleColor:LGFColor(255, 50, 100) forState:UIControlStateNormal];
    
    [doneItem addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    
//    [toolbar addSubview:prevItem];
    
//    [toolbar addSubview:nextItem];
    
    [toolbar addSubview:doneItem];
    
    return toolbar;
    
}

-(void)textFieldDone{
    
    [self resignFirstResponder];
    
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
 阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
 */
-(void)setShadowOffset:(CGSize)shadowOffset{
    
    self.layer.shadowOffset = shadowOffset;
    
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
 阴影透明度
 */
-(void)setShadowOpacity:(float)shadowOpacity{
    
    self.layer.shadowOpacity = shadowOpacity;
    
}

@end
