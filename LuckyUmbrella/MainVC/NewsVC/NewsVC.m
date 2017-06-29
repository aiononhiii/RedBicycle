//
//  NewsVC.m
//  LuckyUmbrella
//
//  Created by totyu3 on 2017/6/28.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "NewsVC.h"
#import "NewsCVCell.h"

@interface NewsVC ()
@property (weak, nonatomic) IBOutlet UICollectionView *NewsCV;

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.self

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource And Delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 15;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_NewsCV.width,_NewsCV.height / 5);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsCVCell" forIndexPath:indexPath];

    cell.ActivityImage.backgroundColor = LGFRandomColor;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"NewsDetailVCPush" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"NewsDetailVCPush"]){
        
//        MyScheduleDetailVC *msdvc = segue.destinationViewController;
//        
//        NSIndexPath *indexPath = _MyScheduleCV.indexPathsForSelectedItems.lastObject;
//        
//        msdvc.DataDict = _MyScheduleArray[indexPath.item];
        
    }
    
}

@end
