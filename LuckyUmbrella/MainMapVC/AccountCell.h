//
//  AccountCell.h
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/19.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *AccountImage;
@property (weak, nonatomic) IBOutlet UILabel *AccountTitle;
@property (weak, nonatomic) IBOutlet UILabel *Balance;//钱包余额
@end
