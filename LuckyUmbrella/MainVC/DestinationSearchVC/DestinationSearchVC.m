//
//  DestinationSearchVC.m
//  LuckyUmbrella
//
//  Created by apple on 2017/7/20.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "DestinationSearchVC.h"
#import "DestinationSearchCell.h"

@interface DestinationSearchVC ()
@property (weak, nonatomic) IBOutlet UITableView *DestinationSearchTable;
@property (weak, nonatomic) IBOutlet UISearchBar *DestinationSearchBar;
@property (strong, nonatomic) NSArray *DestinationArray;
@end

@implementation DestinationSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _DestinationSearchTable.tableFooterView = [[UIView alloc] init];
    
    [CATransaction setCompletionBlock: ^{
        
        [self performSelector:@selector(DestinationSearchBarBecomeFirstResponder) withObject:nil afterDelay:0.1];

    }];
    
}
-(void)DestinationSearchBarBecomeFirstResponder{
    
    [_DestinationSearchBar becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@",searchBar.text);
    MKLocalSearchRequest *localSearchRequest = [[MKLocalSearchRequest alloc] init];
    localSearchRequest.region = _SuperRegion;
    localSearchRequest.naturalLanguageQuery = searchBar.text;//搜索关键词
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:localSearchRequest];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        NSLog(@"the response's count is:%ld",response.mapItems.count);
        
        _DestinationArray = [NSArray array];
        
        if (error) {
            
            NSLog(@"error info：%@",error);
            
        } else {
            
            _DestinationArray = response.mapItems;
            
//            for (MKMapItem *mapItem in response.mapItems) {
//
//                NSLog(@"name:%@,\nthoroughfare:%@,\nsubThoroughfare:%@,\nlocality:%@,\nsubLocality:%@,\nadministrativeArea:%@,\nsubAdministrativeArea:%@,\ncountry:%@,\ninlandWater:%@,\nocean:%@",mapItem.placemark.name,mapItem.placemark.thoroughfare,mapItem.placemark.subThoroughfare,mapItem.placemark.locality,mapItem.placemark.subLocality,mapItem.placemark.administrativeArea,mapItem.placemark.subAdministrativeArea,mapItem.placemark.country,mapItem.placemark.inlandWater,mapItem.placemark.ocean);
//
//
//            }
      
        }
        
        //刷新表格
        [_DestinationSearchTable reloadData];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _DestinationArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DestinationSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DestinationSearchCell" forIndexPath:indexPath];
    
    MKMapItem *DestinationItem = _DestinationArray[indexPath.row];
    
    cell.textLabel.text = DestinationItem.placemark.name;
    
    return cell;
    
}
/**
 点击cell跳转到指定页
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate ShowDestination:_DestinationArray[indexPath.row]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
