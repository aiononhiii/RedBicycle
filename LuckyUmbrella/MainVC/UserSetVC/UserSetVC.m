//
//  UserSetVC.m
//  LuckyUmbrella
//
//  Created by totyu3 on 2017/6/30.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "UserSetVC.h"

#define RealHeight (self.tableView.height - 64)

@interface UserSetVC ()
@property (weak, nonatomic) IBOutlet UIView *LogoutView;

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

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return RealHeight * 0.3;
        
    } else if (indexPath.row == 7) {
        
        return RealHeight * 0.04;
        
    }
    
    return RealHeight * 0.07;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return RealHeight * 0.1;
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return _LogoutView;
    
}

@end
