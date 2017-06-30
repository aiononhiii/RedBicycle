//
//  LGFUploadImage.h
//  LuckyUmbrella
//
//  Created by totyu3 on 2017/6/30.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LGFUPLOAD_IMAGE [LGFUploadImage shareUploadImage]

@protocol UploadImageDelegate <NSObject>

/**
 获取系统相册，拍照的图片

 @param image 图片
 */
- (void)uploadImageToServerWithImage:(UIImage *)image SelectButton:(UIButton *)SelectButton;

@end

@interface LGFUploadImage : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIButton *UploadImageSelectButton;
}
@property (nonatomic, weak) id <UploadImageDelegate> delegate;

/**
 调用系统相册，拍照
 */
- (void)showActionSheetInFatherViewController:(id)SelfViewController SelectButton:(UIButton *)SelectButton;

/**
 单列初始化
 */
+ (LGFUploadImage *)shareUploadImage;

@end
