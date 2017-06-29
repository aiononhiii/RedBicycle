//
//  UserSetVC.m
//  LuckyUmbrella
//
//  Created by LGF on 17/6/13.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "UserSetVC.h"

@interface UserSetVC ()
@property (weak, nonatomic) IBOutlet UIButton *CloseButton;

@end

@implementation UserSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)CloseUserSet:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
