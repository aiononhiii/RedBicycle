//
//  ScanCode.m
//  LuckyUmbrella
//
//  Created by apple on 2017/6/18.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "ScanCode.h"
#import "XTimer.h"

@interface ScanCode ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *_captureSession;
    AVCaptureVideoPreviewLayer *_videoPreviewLayer;
    XTimer *ScanCodeTimer;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScanViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScanViewWidth;
@property (weak, nonatomic) IBOutlet UIImageView *ScanCodeImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ScanCodeImageHeight;
@property (weak, nonatomic) IBOutlet UIView *ScanView;
@end
@implementation ScanCode

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //判断相机权限是否打开
    
    if ([AuxiliaryMethod CameraAuthorizationRequest:self]) return;
    
    [self ScanViewAnimation];
    
    //添加扫描动画
    
    ScanCodeTimer = [XTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(ScanCodeImageAnimation) userInfo:nil repeats:true];
    
    //初始化扫描界面
    
    GLOBAL([self startReading];);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopReading];
    
}

- (void)dealloc {
    
    NSLog(@"二维码扫描页释放");
    
}

- (void)ScanViewAnimation {
    
    [UIView animateWithDuration:1.2 animations:^{
        
        _ScanView.alpha = 1.0;
        
        _ScanViewHeight.constant = self.view.height * 0.4;
        
        _ScanViewWidth.constant = self.view.width * 0.8;
        
        [self.view layoutIfNeeded];
        
    }];
    
}

- (void)ScanCodeImageAnimation {

    [UIView animateWithDuration:1.4 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        
        _ScanCodeImageHeight.constant = self.view.height * 0.43;
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 animations:^{
           
            _ScanCodeImage.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            _ScanCodeImage.alpha = 1.0;
            
            _ScanCodeImageHeight.constant = 0.0;
            
            [self.view layoutIfNeeded];
            
        }];
        
    }];

}

- (void)startReading {
    
    //获取 AVCaptureDevice 实例
    
    NSError * error;
    
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //初始化输入流
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        
        NSLog(@"AVCaptureDeviceInput: %@", [error localizedDescription]);
        
        return;
        
    }

    //创建会话

    _captureSession = [[AVCaptureSession alloc] init];

    //提高图片质量为1080P，提高识别效果

    _captureSession.sessionPreset = AVCaptureSessionPreset1280x720;

    //添加输入流

    [_captureSession addInput:input];

    //初始化输出流
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];

    //设置扫描范围
    
    captureMetadataOutput.rectOfInterest = CGRectMake(_ScanView.y/self.view.height,
                                                      _ScanView.x/self.view.width,
                                                      _ScanView.height/self.view.height,
                                                      _ScanView.width/self.view.width);
    
    //添加输出流
    
    [_captureSession addOutput:captureMetadataOutput];

    //创建dispatch queue.

    dispatch_queue_t dispatchQueue = dispatch_queue_create("ScanQRCodeQueue", NULL);
    
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    //设置元数据类型 AVMetadataObjectTypeQRCode
    
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    //创建输出对象
    
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [_videoPreviewLayer setFrame:self.view.layer.bounds];

    //开始会话
    
    MAIN(
         
         [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
         
         [_captureSession startRunning];
         
    );
    
    

}

- (void)stopReading {
    
    // 停止会话
    
    [ScanCodeTimer invalidate];
    
    [_captureSession stopRunning];
    
    _captureSession = nil;
    
}

#pragma AVCaptureMetadataOutputObjectsDelegate

/**
 二维码扫描回调
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        
        NSString *result;
        
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            result = metadataObj.stringValue;
            
        } else {
            
            NSLog(@"不是二维码");
            
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.delegate ShowPasswordUnlocked:result];
            
        });
        
        [self stopReading];
        
    }
    
}

/**
 点击手动输入回调
 */
- (IBAction)ManualInput:(UIButton *)sender {
    
    [self.delegate ShowManualInput];
    
}

@end
