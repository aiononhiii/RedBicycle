//
//  LGFUploadImage.m
//  LuckyUmbrella
//
//  Created by totyu3 on 2017/6/30.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "LGFUploadImage.h"

static LGFUploadImage *UploadImage = nil;

@implementation LGFUploadImage

+ (LGFUploadImage *)shareUploadImage {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        UploadImage = [[LGFUploadImage alloc] init];
        
    });
    
    return UploadImage;
    
}

- (void)showActionSheetInFatherViewController:(id)SelfViewController SelectButton:(UIButton *)SelectButton{
    
    UploadImage.delegate = SelfViewController;
    
    UploadImageSelectButton = SelectButton;
    
    UIAlertController *CameraAlert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [CameraAlert addAction:[UIAlertAction actionWithTitle:@"从手机相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [UploadImage GoToPhotos:SelfViewController];
        
    }]];
    
    [CameraAlert addAction:[UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [UploadImage GoToCamera:SelfViewController];
        
    }]];
    
    [CameraAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [SelfViewController presentViewController:CameraAlert animated:YES completion:nil];
    
}

/**
 去相册取图片
 */
- (void)GoToPhotos:(id)SelfViewController {
    
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    
    imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePC.delegate = UploadImage;
    
    imagePC.allowsEditing = YES;
    
    [SelfViewController presentViewController:imagePC animated:YES completion:nil];
    
    
}

/**
 去相机拍摄图片
 */
- (void)GoToCamera:(id)SelfViewController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
        
        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        imagePC.delegate = UploadImage;
        
        imagePC.allowsEditing = YES;
        
        [SelfViewController presentViewController:imagePC animated:YES completion:nil];
        
    }else {
        
        [MBProgressHUD showSuccess:@"该设备没有照相机" afterDelay:1.0 toView:LGFLastView];
        
    }
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    /**
     *  获取到图片
     */
    if (UploadImage.delegate && [UploadImage.delegate respondsToSelector:@selector(uploadImageToServerWithImage:SelectButton:)]) {
        
        [UploadImage.delegate uploadImageToServerWithImage:image SelectButton:UploadImageSelectButton];
        
        if (UploadImageSelectButton) [UploadImageSelectButton setBackgroundImage:image forState:UIControlStateNormal];
        
    }
    
}

@end
