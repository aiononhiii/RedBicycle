//
//  MakeComplaintsVC.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/16.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MakeComplaintsVC.h"

#define RealHeight (self.tableView.height - 64)

@interface MakeComplaintsVC ()

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

@property (nonatomic, strong) NSArray<UIButton *> *MakeComplaintsTypeButtonArray;//吐槽按钮数组
@property (nonatomic, strong) NSMutableArray<NSString *> *MakeComplaintsTypeArray;//吐槽数组
@end

@implementation MakeComplaintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _MakeComplaintsTypeButtonArray = @[_MakeComplaintsTypeOne, _MakeComplaintsTypeTwo, _MakeComplaintsTypeThree, _MakeComplaintsTypeFour, _MakeComplaintsTypeFive, _MakeComplaintsTypeSix, _MakeComplaintsTypeSeven, _MakeComplaintsTypeEight];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MakeComplaintsTypeClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    sender.layer.borderWidth = sender.selected ? 0.0 : 1.0;

    [_SubmitButton setEnabled:NO];
    
    [_MakeComplaintsTypeButtonArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.selected) {
            
            [_SubmitButton setEnabled:YES];
            
        }
        
    }];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return RealHeight * 0.08;
        
    }
    
    return RealHeight * 0.16;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        
        return RealHeight * 0.08;
        
    } else if(section == 2) {
        
        return RealHeight * 0.04;
        
    }
    
    return 0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGFloat SectionHeight = RealHeight * 0.08;
    
    NSString *SectionTitle = @"";
    
    if (section == 0) {
        
        SectionTitle = @"👍请选择故障类型";

    } else if (section == 1) {
        
        SectionTitle = @"📷拍摄单车周围环境，便于维修师傅找车";

    } else {
        
        SectionHeight = 0;
        
    }

    return [AuxiliaryMethod MakeSectionViewWithHeight:SectionHeight Text:SectionTitle];
    
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
