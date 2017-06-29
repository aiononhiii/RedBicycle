//
//  SpecialButton.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

IB_DESIGNABLE
@interface SpecialButton : UIButton

@property (nonatomic, strong) IBInspectable NSString *buttontype;

@property (nonatomic , assign) IBInspectable UIColor *borderColor;

@property (nonatomic , assign) IBInspectable CGFloat borderWidth;

@property (nonatomic , assign) IBInspectable CGFloat cornerRadius;

@property (nonatomic , assign) IBInspectable UIColor *shadowColor;

@property (nonatomic , assign) IBInspectable float shadowOpacity;

@property (nonatomic , assign) IBInspectable CGFloat shadowRadius;

@property (nonatomic , assign) IBInspectable CGSize shadowOffset;

-(void)setLGFEnabled:(BOOL)enabled;

@end
