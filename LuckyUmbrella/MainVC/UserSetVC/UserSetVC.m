//
//  UserSetVC.m
//  LuckyUmbrella
//
//  Created by totyu3 on 2017/6/30.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "UserSetVC.h"

@interface UserSetVC () <UploadImageDelegate>

@property (weak, nonatomic) IBOutlet UIView *LogoutView;
@property (weak, nonatomic) IBOutlet UIImageView *UserImage;

@end

@implementation UserSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 退出登录
 */
- (IBAction)Logout:(UIButton *)sender {
    
    
    
    
}

- (IBAction)UserImageButtonClick:(UIButton *)sender {
    
    [LGFUPLOAD_IMAGE showActionSheetInFatherViewController:self SelectButton:sender];
    
}

-(void)uploadImageToServerWithImage:(UIImage *)image SelectButton:(UIButton *)SelectButton{
    
    [_UserImage setImage:image];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return self.tableView.height * 0.3;
        
    } else if (indexPath.row == 7) {
        
        return self.tableView.height * 0.04;
        
    }
    
    return self.tableView.height * 0.07;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return self.tableView.height * 0.1;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return _LogoutView;
    
}

@end
