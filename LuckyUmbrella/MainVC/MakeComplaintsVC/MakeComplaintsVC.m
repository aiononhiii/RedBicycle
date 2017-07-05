//
//  MakeComplaintsVC.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/16.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MakeComplaintsVC.h"

#define RealHeight (self.tableView.height - 64)

@interface MakeComplaintsVC () <UploadImageDelegate>

@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeOne;//私锁私用
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeTwo;//车牌缺损
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeThree;//轮胎坏了
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeFour;//车锁坏了
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeFive;//违规乱停
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeSix;//密码不对
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeSeven;//刹车坏了
@property (weak, nonatomic) IBOutlet UIButton *MakeComplaintsTypeEight;//其他
@property (weak, nonatomic) IBOutlet UIButton *SubmitButton;//提交按钮
@property (weak, nonatomic) IBOutlet UITextField *LicensePlate;//车牌号
@property (weak, nonatomic) IBOutlet UITextField *Remarks;//备注

@property (weak, nonatomic) IBOutlet UIButton *CameraOne;
@property (weak, nonatomic) IBOutlet UIButton *CameraTwo;
@property (weak, nonatomic) IBOutlet UIButton *CameraThree;
@property (weak, nonatomic) IBOutlet UIButton *CameraFour;

@property (nonatomic, strong) NSArray<UIButton *> *CameraArray;//相机图片数组
@property (nonatomic, strong) NSArray<UIButton *> *MakeComplaintsTypeButtonArray;//吐槽按钮数组
@property (nonatomic, strong) NSMutableArray<NSString *> *MakeComplaintsTypeArray;//吐槽数组
@end

@implementation MakeComplaintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _MakeComplaintsTypeButtonArray = @[_MakeComplaintsTypeOne, _MakeComplaintsTypeTwo, _MakeComplaintsTypeThree, _MakeComplaintsTypeFour, _MakeComplaintsTypeFive, _MakeComplaintsTypeSix, _MakeComplaintsTypeSeven, _MakeComplaintsTypeEight];
    
    _CameraArray = @[_CameraOne,_CameraTwo,_CameraThree,_CameraFour];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)CameraClick:(UIButton *)sender {
    
    [LGFUPLOAD_IMAGE showActionSheetInFatherViewController:self SelectButton:sender];

}

-(void)uploadImageToServerWithImage:(UIImage *)image SelectButton:(UIButton *)SelectButton{

    if (SelectButton == _CameraOne) {
        
        [_CameraTwo setHidden:NO];
        
    } else if (SelectButton == _CameraTwo) {
        
        [_CameraThree setHidden:NO];
        
    } else if (SelectButton == _CameraThree) {
        
        [_CameraFour setHidden:NO];
        
    }
    
}

- (IBAction)MakeComplaintsTypeClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    sender.layer.borderWidth = sender.selected ? 0.0 : 0.3;

    [_SubmitButton setEnabled:NO];
    
    [_MakeComplaintsTypeButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.selected) {
            
            [_SubmitButton setEnabled:YES];
            
        }
        
    }];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 2) {
        
        return RealHeight * 0.1;
        
    } else if (indexPath.row == 1) {
        
        return RealHeight * 0.3;
        
    } else if (indexPath.row == 3) {
        
        return RealHeight * 0.16;
        
    } else if (indexPath.row == 4) {
        
        return RealHeight * 0.06;
        
    } else if (indexPath.row == 7) {
        
        return RealHeight * 0.12;
        
    }
    
    return RealHeight * 0.08;
    
}

@end
