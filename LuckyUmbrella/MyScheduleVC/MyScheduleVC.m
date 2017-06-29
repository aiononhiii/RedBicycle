//
//  MyScheduleVC.m
//  LuckyUmbrella
//
//  Created by LGF on 2017/6/27.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MyScheduleVC.h"
#import "MyScheduleCVCell.h"
#import "MyScheduleDetailVC.h"

@interface MyScheduleVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *MyScheduleCV;
@property (nonatomic, strong) NSArray *MyScheduleArray;
@end

@implementation MyScheduleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _MyScheduleArray = [NSMutableArray arrayWithArray:[LGFUserDefaults objectForKey:@"allcoordinatearray"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource And Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _MyScheduleArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_MyScheduleCV.width,_MyScheduleCV.height / 7);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyScheduleCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyScheduleCVCell" forIndexPath:indexPath];
    
    cell.ScheduleTime.text = _MyScheduleArray[indexPath.item][@"starttime"];

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"MyScheduleDetailVCPush" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"MyScheduleDetailVCPush"]){

        MyScheduleDetailVC *msdvc = segue.destinationViewController;
        
        NSIndexPath *indexPath = _MyScheduleCV.indexPathsForSelectedItems.lastObject;
        
        msdvc.DataDict = _MyScheduleArray[indexPath.item];
        
    }
    
}

@end
