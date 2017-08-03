//
//  MyWalletVC.m
//  LuckyUmbrella
//
//  Created by totyu3 on 2017/6/28.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MyWalletVC.h"

@interface MyWalletVC ()

@end

@implementation MyWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return self.tableView.height * 0.2;
        
    } else if (indexPath.row == 1) {
        
        return self.tableView.height * 0.2;
        
    }
    
    return self.tableView.height * 0.1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
