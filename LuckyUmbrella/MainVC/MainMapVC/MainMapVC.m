//
//  MainMapVC.m
//  LuckyUmbrella
//
//  Created by LGF on 17/6/7.
//  Copyright © 2017年 LGF. All rights reserved.
//

#import "MainMapVC.h"
/**原生地图头文件*/
#import <MapKit/MapKit.h>
/**核心定位服务头文件*/
#import <CoreLocation/CoreLocation.h>
/**火星坐标转换头文件*/
#import"CLLocation+Sino.h"

#import "MainSet.h"

#import "ScanCode.h"//二维码扫描页面

#import "ManualInput.h"//手动输入页

#import "PasswordUnlocked.h"//开锁密码页

#import "RideInTheBike.h"//自行车骑行中页

#import "Payment.h"//付款页

#import "AccountCell.h"

@interface MainMapVC ()<CLLocationManagerDelegate,ScanCodeView,ManualInputView
,PasswordUnlockedView,RideInTheBikeView,PaymentView,MainSetView>
{
    CLLocation *NewSelfLocation;//最新经纬度
    BOOL StartOrEndRiding;//是否开始骑行， yes : 开始骑行 no : 结束骑行
    BOOL LocationUpdateBool;//10秒定位一次用 Bool
    XTimer *LocationUpdateTimer;//10秒定位一次用 Timer
}
/**
 地图view
 */
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *MapViewBottom;
@property (nonatomic, strong) CLLocationManager *LocationManager;
/**
 最新标注点，大头针
 */
@property (weak, nonatomic) IBOutlet SpecialButton *NewLocationPoint;
/**
 客服小女孩
 */
@property (weak, nonatomic) IBOutlet UIButton *LittleRedGirl;
/**
 当前位置view
 */
@property (strong, nonatomic) SpecialButton *SelfLocationView;
/**
 定位到当前自身坐标按钮
 */
@property (weak, nonatomic) IBOutlet SpecialButton *ShowSelfLocationButton;
/**
 调转到吐槽页面按钮
 */
@property (weak, nonatomic) IBOutlet SpecialButton *ShowMakeComplaintsButton;
/**
 设置view
 */
@property (weak, nonatomic) IBOutlet SetView *SetView;
/**
 设置view子页
 */
@property (weak, nonatomic) IBOutlet SpecialView *SetViewMainView;//设置view主页

@property (weak, nonatomic) IBOutlet SpecialView *PasswordView;//开锁密码页

@property (weak, nonatomic) IBOutlet SpecialView *RideInTheBikeView;//自行车骑行中页

@property (strong, nonatomic) IBOutlet SpecialView *ManualInputView;//手动输入页

@property (weak, nonatomic) IBOutlet SpecialView *ScanCodeView;//二维码扫描页面

@property (weak, nonatomic) IBOutlet SpecialView *PaymentView;//付款页

@property (weak, nonatomic) IBOutlet UIButton *UpDownButton;//上下箭头按钮
/**
 设置view动画更新
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *SetViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *NewLocationBottom;
/**
 账户信息一览
 */
@property (weak, nonatomic) IBOutlet UIView *AccountTopView;//账户页面顶部view
@property (weak, nonatomic) IBOutlet UIView *AccountView;//账户页面
@property (weak, nonatomic) IBOutlet UIButton *CloseAccountButton;//关闭帐户页面按钮
@property (weak, nonatomic) IBOutlet UITableView *AccountTableView;//账户功能一览表
//账户信息一览 数据接收控件
@property (weak, nonatomic) IBOutlet UIImageView *MedalImage;//勋章图表
@property (weak, nonatomic) IBOutlet UILabel *CreditRecord;//信用记录
@property (weak, nonatomic) IBOutlet UILabel *PhoneNumber;//手机号
@property (weak, nonatomic) IBOutlet UIButton *UserImage;//用户头像
//账户信息一览动画更新
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AccountTopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *AccountViewTop;

@property (nonatomic, strong) NSArray *TestCoordinateArray;//测试用经纬度数组
@property (nonatomic, strong) NSArray *AccountArray;//帐户功能跳转按钮数组
@end

@implementation MainMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    StartOrEndRiding = NO;
    
    LocationUpdateBool = NO;
    
    [self selfLocationInit];

    //账户信息一览autolayout值初始化
    
    _NewLocationBottom.constant = -_NewLocationPoint.height / 4;
    
    _MapViewBottom.constant = -self.view.height * 0.1;

    _AccountArray = @[@{@"accounttitle" : @"我的行程" ,@"accountimage" : @"MySchedule"},
                      @{@"accounttitle" : @"我的钱包" ,@"accountimage" : @"MyWallet"},
                      @{@"accounttitle" : @"邀请好友" ,@"accountimage" : @"InvitingFriends"},
                      @{@"accounttitle" : @"兑优惠劵" ,@"accountimage" : @"Coupon"},
                      @{@"accounttitle" : @"我的消息" ,@"accountimage" : @"MyNews"},
                      @{@"accounttitle" : @"使用指南" ,@"accountimage" : @"GuideToUse"}];
    
    //测试用数组初始化
    _TestCoordinateArray = @[
      @{@"latitude":@"30.188161",@"longitude":@"120.196958"},
      @{@"latitude":@"30.188887",@"longitude":@"120.197521"},
      @{@"latitude":@"30.189316",@"longitude":@"120.196822"},
      @{@"latitude":@"30.188947",@"longitude":@"120.195847"},
      @{@"latitude":@"30.187312",@"longitude":@"120.196801"},
      
      @{@"latitude":@"30.148447",@"longitude":@"120.195193"},
      @{@"latitude":@"30.148717",@"longitude":@"120.194399"},
      @{@"latitude":@"30.149316",@"longitude":@"120.194745"},
      @{@"latitude":@"30.150776",@"longitude":@"120.195314"},
      @{@"latitude":@"30.149505",@"longitude":@"120.192906"}
      ];
    
    [LGFNotificationCenter addObserver:self selector:@selector(DidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [LGFNotificationCenter addObserver:self selector:@selector(DidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];

    [self ShowMainSetView];
    
    [CATransaction setCompletionBlock: ^{
        
        [self MapViewSetRegion];
        
    }];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

/**
 app进入前台
 */
- (void)DidBecomeActive {
    
    [self selfLocationInit];
    
}

/**
 app进入后台
 */
- (void)DidEnterBackground {
    
    if (!StartOrEndRiding) {
        
        [self DoStopUpdatingLocation];
        
        [LocationUpdateTimer invalidate];
        
    }
    
}

/**
 暂停定位，方向
 */
- (void)DoStopUpdatingLocation {
    
    [self.LocationManager stopUpdatingLocation];
    
    [self.LocationManager stopUpdatingHeading];
    
}

/**
 开始定位，方向
 */
- (void)DoStartUpdatingLocation {
    
    [self.LocationManager startUpdatingLocation];
    
    [self.LocationManager startUpdatingHeading];
    
}

/**
 设置间隔10秒定位一次
 */
- (void)LocationUpdateTimer {
    
    LocationUpdateBool = !LocationUpdateBool;
    
    if (LocationUpdateBool) {
    
        [self DoStartUpdatingLocation];
        
        NSLog(@"开始定位");
        
    } else {
        
        [self DoStopUpdatingLocation];
        
        NSLog(@"结束定位");
        
    }
    
}

#pragma mark 结束移动地图

- (void)mapView:(MKMapView*)mapView regionDidChangeAnimated:(BOOL)animated {
    
    if (!StartOrEndRiding) {
        
        //添加附近可用自行车
        
        for (NSDictionary *CoordinateDict in _TestCoordinateArray) {
            
            CLLocationCoordinate2D testLocation;
            
            testLocation.latitude = [CoordinateDict[@"latitude"] doubleValue];
            
            testLocation.longitude = [CoordinateDict[@"longitude"] doubleValue];
            
            //添加自行车大头针
            
            MKPointAnnotation *pointAnnotation =[[MKPointAnnotation alloc] init];
            
            //设置自行车经纬度
            
            pointAnnotation.coordinate = testLocation;
            
            //设置主标题和副标题
            
            pointAnnotation.title = @"自行车";
            
            //添加到地图上
            
            [_MapView addAnnotation:pointAnnotation];
            
        }
        
        [self NewLocationPointSetConstant:-_NewLocationPoint.height / 4];
        
        MKCoordinateRegion region;
        
        CLLocationCoordinate2D centerCoordinate = mapView.region.center;
        
        region.center= centerCoordinate;
        
        NSLog(@"结束移动地图 regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
        
        //判断移动距离是否超出与当前位置指定范围，超出后提示
        
        CLLocation *FromLocation = [[CLLocation alloc] initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
        
        double distance = [NewSelfLocation distanceFromLocation:FromLocation];
        
        [CATransaction setCompletionBlock: ^{
            
            if (distance > 400 && distance < 5000) {
                
                NSLog(@"超出与当前位置距离：%f",distance);
                
                [MBProgressHUD showSuccess:@"离你太远啦" afterDelay:0.5 toView:self.view];
                
            } else {
                
                if (distance < 400){
                    
                    //                [MBProgressHUD showSuccess:@"附近有 4 辆小红车" toView:self.view];
                    
                } else {
                    
                    [MBProgressHUD showSuccess:@"妈妈快看有超人！飞那么高～" afterDelay:0.5 toView:self.view];
                    
                }
                
            }
            
        }];
        
    }

}

#pragma mark 开始移动地图

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    [self RemoveMKPointAnnotation:@"自行车"];
    
    [self NewLocationPointSetConstant:-_NewLocationPoint.frame.size.height / 2];

}

- (CLLocationManager *)LocationManager{
    
    if (!_LocationManager) {
        
        //创建定位对象
        _LocationManager = [[CLLocationManager alloc] init];
        
        //设置定位属性
        _LocationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        _LocationManager.distanceFilter = kCLDistanceFilterNone;
        
        _LocationManager.pausesLocationUpdatesAutomatically = NO;
        
        _LocationManager.allowsBackgroundLocationUpdates = YES;
        
        //设置定位更新距离militer
        
        _LocationManager.distanceFilter = 10.0;
        
        //绑定定位委托
        
        _LocationManager.delegate = self;
        
        /**设置用户请求服务*/
        //1.去info.plist文件添加定位服务描述,设置的内容可以在显示在定位服务弹出的提示框
        
    }
    
    return _LocationManager;
    
}

#pragma mark 定位自己

- (void)selfLocationInit {

    if ([self.LocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {

        [self.LocationManager requestAlwaysAuthorization];
        
    }

    //请求开启定位服务
    
    if ([AuxiliaryMethod LocateAuthorizationRequest:self]) return;
    
    //设置间隔10秒定位一次
    
    [LocationUpdateTimer invalidate];
    
    LocationUpdateTimer = [XTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(LocationUpdateTimer) userInfo:nil repeats:true];
    
    //开始定位
    
    [self DoStartUpdatingLocation];
    
    NewSelfLocation = self.LocationManager.location;
    
    NewSelfLocation = [NewSelfLocation locationMarsFromEarth];
    
    [self MapViewSetRegion];
    
}

/**
 设置地图显示该经纬度的位置
 */
- (void)MapViewSetRegion {
    
    
        
        MKCoordinateRegion region = MKCoordinateRegionMake(NewSelfLocation.coordinate, MKCoordinateSpanMake(_MapView.height * 0.00001, _MapView.height * 0.00001));
        
        [_MapView setRegion:region animated:YES];
        
    
    
}

#pragma mark CLLocationManagerDelegate

//定位后的返回结果

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"定位中");
    
    //locations数组中存储的是CLLocation
    
    //遍历数组取出坐标--》如果不需要也可以不遍历
    
    NewSelfLocation = [locations firstObject];
    
    //火星坐标转地球坐标
    
    NewSelfLocation = [NewSelfLocation locationMarsFromEarth];
    
    //删除“我在这里”大头针
    [self RemoveMKCircle:@"装饰圈"];
    [self RemoveMKPointAnnotation:@"我在这里"];
    
    //添加大头针
    MKPointAnnotation *pointAnnotation =[[MKPointAnnotation alloc] init];

    //设置经纬度
    pointAnnotation.coordinate = NewSelfLocation.coordinate;
    
    //设置主标题和副标题
    
    pointAnnotation.title=@"我在这里";

    //添加到地图上
    
    [_MapView addAnnotation:pointAnnotation];
    
    MKCircle *circle =[MKCircle circleWithCenterCoordinate:NewSelfLocation.coordinate radius:400];
    
    circle.title = @"装饰圈";
    
    //先添加，在回调方法中创建覆盖物
    
    [_MapView addOverlay:circle];
    
    if (StartOrEndRiding) {
        
        [self StartRiding];
        
    }
    
//
//    //设置地图显示该经纬度的位置
//
//    MKCoordinateRegion region =MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01,0.01));
//    
//    [_MapView setRegion:region animated:YES];
    
//    //创建大头针
//    
//    MKPointAnnotation * pointAnnotation = [[MKPointAnnotation alloc] init];
//    
//    //设置经纬度
//    
//    pointAnnotation.coordinate = location.coordinate;
//    
//    //设置主标题
//    
//    pointAnnotation.title =@"我在这里";
//    
//    //设置副标题
//    
//    pointAnnotation.subtitle =@"hello world";
//    
//    //将大头针添加到地图上
//    
//    [_MapView addAnnotation:pointAnnotation];
    
}

-(void)StartRiding{
    
    //纪录经过经纬度点，用于画历史路径
    
    NSLog(@"纪录经过经纬度点 : %f,%f",NewSelfLocation.coordinate.latitude,NewSelfLocation.coordinate.longitude);
    
    [self MapViewSetRegion];
    
    NSMutableArray *coordinatearray = [NSMutableArray arrayWithArray:[LGFUserDefaults objectForKey:@"coordinatearray"]];
    
    NSMutableDictionary *coordinatedict = [[NSMutableDictionary alloc]init];
    
    [coordinatedict setValue:[NSString stringWithFormat:@"%f",NewSelfLocation.coordinate.latitude] forKey:@"latitude"];
    
    [coordinatedict setValue:[NSString stringWithFormat:@"%f",NewSelfLocation.coordinate.longitude] forKey:@"longitude"];
    
    [coordinatearray addObject:coordinatedict];
    
    [LGFUserDefaults setObject:coordinatearray forKey:@"coordinatearray"];
    
}

/**
 大头针的回调方法（与cell的复用机制很相似）
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MKPointAnnotation *)annotation {
    
    static NSString *placemarkIdentifier = @"PointAnnotation";
    
    if ([annotation isKindOfClass:[MKPointAnnotation class]]){
        
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:placemarkIdentifier];
        
        if([annotation.title isEqualToString:@"我在这里"]){
            
            annotationView.image = [UIImage imageNamed:@"SelfLocationImage"];
            
        } else if ([annotation.title isEqualToString:@"自行车"]){
            
            annotationView.image = [UIImage imageNamed:@"Bicycle"];

            //添加抖动动画
            
            [annotationView.layer addAnimation:[AuxiliaryMethod ViewJitter] forKey:nil];
            
            //添加手势用于设置导航路线
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBicycle:)];
            
            [annotationView addGestureRecognizer:tapGesture];
            
        }
        
        return annotationView;
    }
    return nil;
    
}

/**
 覆盖物的回调方法
 */
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    //判断是覆盖物还是线
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        
        //线颜色
        
        render.strokeColor = LGFColorAlpha(255, 50, 100, 0.5);
        
        render.lineWidth = 5.0;
        
        return render;
        
    }
    
    //创建圆形覆盖物
    
    MKCircleRenderer *circleRender = [[MKCircleRenderer alloc] initWithCircle:overlay];
    
    //设置填充色
    
    circleRender.fillColor = LGFColorAlpha(255, 255, 255, 0.2);
    
    //设置边缘颜色
    
    circleRender.strokeColor = LGFColorAlpha(255, 50, 100, 0.2);
    
    circleRender.lineWidth = 5.0;
    
    return circleRender;
    
}

/**
 绘制导航路线

 @param fromPm 开始点
 @param toPm 结束点
 */
- (void)addLineFrom:(MKMapItem *)fromPm to:(MKMapItem *)toPm {
    
    //2.查找路线
    //方向请求,设置起点,终点
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.transportType = MKDirectionsTransportTypeWalking;
    request.source = fromPm;
    request.destination = toPm;
    
    //方向对象
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    //计算路线
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"总共%lu条路线",response.routes.count);

        //遍历所有的路线
        
        for (MKRoute *route in response.routes) {
            
            //添加路线遮盖
            
            route.polyline.title = @"导航路线";
            
            [_MapView setRegion:[AuxiliaryMethod regionForAnnotations:route.steps] animated:YES];
            
            [_MapView addOverlay:route.polyline];
            
        }
        
    }];
    
}

#pragma mark 账户一览 tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _AccountArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _AccountTableView.height / (_AccountArray.count * 1.5);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountCell" forIndexPath:indexPath];
    
    UIView *bgview = [[UIView alloc]initWithFrame:cell.bounds];
    
    bgview.backgroundColor = LGFColorAlpha(255, 50, 100, 0.1);
    
    cell.selectedBackgroundView = bgview;
    
    NSDictionary *AccountDict = _AccountArray[indexPath.row];
    
    [cell.AccountImage setImage:[UIImage imageNamed:AccountDict[@"accountimage"]]];
    
    cell.AccountTitle.text = AccountDict[@"accounttitle"];
    
    return cell;
    
}

/**
 cell动画
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.transform = CGAffineTransformTranslate(cell.transform, 0, _AccountTableView.height / 2);
    
    [UIView animateWithDuration:0.4 + indexPath.row * 0.05 animations:^{
        
        cell.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

/**
 点击cell跳转到指定页
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        //跳转到我的行程
        
        [self performSegueWithIdentifier:@"MyScheduleVCPush" sender:self];
        
    } else if (indexPath.row == 1){
        
        //跳转到我的钱包
        
        [self performSegueWithIdentifier:@"MyWalletVCPush" sender:self];
        
    } else if (indexPath.row == 2){
        
        //跳转到邀请好友
        
        [self performSegueWithIdentifier:@"InvitingFriendsVCPush" sender:self];
        
    } else if (indexPath.row == 3){
        
        //跳转到兑优惠劵
        
        [self performSegueWithIdentifier:@"CouponVCPush" sender:self];
        
    } else if (indexPath.row == 4){
        
        //跳转到我的消息
        
        [self performSegueWithIdentifier:@"MyNewsVCPush" sender:self];
        
    } else if (indexPath.row == 5){
        
        //跳转到使用指南
        
        [self performSegueWithIdentifier:@"GuideToUseVCPush" sender:self];
        
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"MyScheduleVCPush"]){//跳转到我的行程

        
    } else if ([segue.identifier isEqualToString:@"MyWalletVCPush"]){//跳转到我的钱包
        
        
    } else if ([segue.identifier isEqualToString:@"InvitingFriendsVCPush"]){//跳转到邀请好友
        
        
    } else if ([segue.identifier isEqualToString:@"CouponVCPush"]){//跳转到兑优惠劵
        
        
    } else if ([segue.identifier isEqualToString:@"MyNewsVCPush"]){//跳转到我的消息
        
        
    } else if ([segue.identifier isEqualToString:@"GuideToUseVCPush"]){//跳转到使用指南
        
        
    } else if ([segue.identifier isEqualToString:@"NewsVCPush"]){
        
    }
    
}

#pragma mark 页面各个按钮点击 实现方法

/**
 点击updown按钮 移动设置view
 */
- (IBAction)UpDownButtonSelect:(UIButton *)sender {
    
    [self UpDownButtonSelected:_SetViewTop.constant >= -_SetView.height * 0.3 ? !sender.selected : sender.selected];
 
}

/**
 地图定位移动到 自身当前位置
 */
- (IBAction)SelfLocation:(UIButton *)sender {
    
    [self RemoveMKPolyline:@"导航路线"];
    
    //请求开启定位服务
    if ([AuxiliaryMethod LocateAuthorizationRequest:self]) return;
    
    [self MapViewSetRegion];
    
}

/**
 点击 x 按钮 隐藏 账户详情一览
 */
- (IBAction)CloseAccount:(UIButton *)sender {
    
    [self ShowAccountSetConstant:0];
    
}

#pragma mark 页面各个手势 实现方法

/**
 下滑 隐藏 账户详情一览
 */
- (IBAction)PanCloseAccount:(UIPanGestureRecognizer *)sender {
    
    if ([[AuxiliaryMethod PanDirectionEstimation:[sender translationInView:_AccountView] EDistance:10] isEqualToString:@"下"]) {
        
        if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
            
            [self ShowAccountSetConstant:0];
            
        }
        
    }
    
}

/**
 滑动　设置view　隐藏，出现
 */
- (IBAction)SetViewPan:(UIPanGestureRecognizer *)sender {
    
    if ([[AuxiliaryMethod PanDirectionEstimation:[sender translationInView:_SetView] EDistance:10.0] isEqualToString:@"下"]) {
        
        if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
            
            //向下滑动

            [self UpDownButtonSelected:_SetViewTop.constant >= -_SetView.height * 0.3 ? YES : NO];

        }
        
    } else if (_SetViewTop.constant >= -_SetView.height * 0.3  && [[AuxiliaryMethod PanDirectionEstimation:[sender translationInView:_SetView] EDistance:10.0] isEqualToString:@"上"]) {
        
        if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {
            
            //向上滑动
            
            [self UpDownButtonSelected:NO];

        }
        
    }
    
}

/**
 点击了小自行车
 */
- (void)tapBicycle:(UITapGestureRecognizer *)sender {
    
    [self RemoveMKPolyline:@"导航路线"];
    
    //调用系统导航
    
    MKAnnotationView *annotationView = (MKAnnotationView *)sender.view;
    
    //起点
    //    MKMapItem *startLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *startLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:NewSelfLocation.coordinate addressDictionary:nil]];
    //终点
    MKMapItem *endLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:annotationView.annotation.coordinate addressDictionary:nil]];

    [self addLineFrom:startLocation to:endLocation];
}

#pragma mark 页面动画实现方法

/**
 账户一览 隐藏，出现 动画
 */
- (void)ShowAccountSetConstant:(int)Constant {

    [UIView animateWithDuration:0.3 animations:^{
        
        _AccountTopViewHeight.constant = Constant;
        
        _AccountViewTop.constant = -Constant * 3.6;
        
        _AccountView.alpha = 1.0;
        
        _AccountTopView.alpha = 1.0;
        
        [self.view layoutIfNeeded];
        
        if (Constant != 0) {
            
            [_AccountTableView reloadData];
            
        }
        
    } completion:^(BOOL finished) {
        
        if (Constant == 0) {
            
            _AccountView.alpha = 0.0;
            
            _AccountTopView.alpha = 0.0;
            
        }
        
    }];
    
}

/**
 设置view 隐藏，出现 动画
 */

- (void)SetViewSetConstant:(int)Constant SetViewType:(SetViewType)SetViewType {
    
    [_SetViewMainView layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{

        _SetViewTop.constant =  Constant;
        
        _UpDownButton.alpha = SetViewType == MainSetPage || SetViewType == NonePage || SetViewType == PasswordUnlockedPage || (SetViewType == ManualInputPage && Constant >= -_SetView.height * 0.4) ? 1.0 : 0.0;

        _SetViewMainView.alpha = SetViewType == MainSetPage ? 1.0 : 0.0;

        _ScanCodeView.alpha = SetViewType == ScanCodePage ? 1.0 : 0.0;
        
        _ManualInputView.alpha = SetViewType == ManualInputPage ? 1.0 : 0.0;
        
        _PasswordView.alpha = SetViewType == PasswordUnlockedPage ? 1.0 : 0.0;
        
        _RideInTheBikeView.alpha = SetViewType == RideInTheBikePage ? 1.0 : 0.0;
        
        _PaymentView.alpha = SetViewType == PaymentPage ? 1.0 : 0.0;
        
        _NewLocationPoint.alpha = SetViewType == RideInTheBikePage ? 0.0 : 1.0;
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

/**
 大头针抬起 动画
 */
- (void)NewLocationPointSetConstant:(int)Constant {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _NewLocationBottom.constant = Constant;
        
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
        
    }];
    
}

#pragma mark 删除指定地图标记

/**
 删除指定线条
 */
- (void)RemoveMKPolyline:(NSString*)title {
    
    [_MapView.overlays enumerateObjectsUsingBlock:^(id<MKOverlay>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[MKPolyline class]] && [obj.title isEqualToString:title]) {
            
            [_MapView removeOverlay:obj];
            
        }
        
    }];
    
}

/**
 删除指定覆盖物
 */
- (void)RemoveMKCircle:(NSString*)title {
    
    [_MapView.overlays enumerateObjectsUsingBlock:^(id<MKOverlay>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[MKCircle class]] && [obj.title isEqualToString:title]) {
            
            [_MapView removeOverlay:obj];
            
        }
        
    }];
    
}

/**
 删除指定大头针
 */
- (void)RemoveMKPointAnnotation:(NSString*)title {
    
    [_MapView.annotations enumerateObjectsUsingBlock:^(id<MKAnnotation>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.title isEqualToString:title]) {
            
            [_MapView removeAnnotation:obj];
            
        }
        
    }];
    
}

#pragma mark 代理回调

/**
 点击礼物图标 显示 最新消息一览
 */
- (void)ShowNews {
    
    [self performSegueWithIdentifier:@"NewsVCPush" sender:self];
    
}

/**
 点击用户图标 显示 账户详情一览
 */
- (void)ShowAccount {
    
    [self ShowAccountSetConstant:self.view.height * 0.25];
    
}

/**
 跳到密码解锁页面
 */
- (void)ShowPasswordUnlocked:(NSString *)result {
    
    PasswordUnlocked *PasswordUnlockedVC = (PasswordUnlocked *)[AuxiliaryMethod ShowView:_PasswordView SelfVC:self];
    
    if (PasswordUnlockedVC) {
        
        PasswordUnlockedVC.UnlockedBicycleNumber.text = [NSString stringWithFormat:@"No.%@的解锁码",@"2333333"];
        
        PasswordUnlockedVC.delegate = self;
        
    }

    [self SetViewSetConstant:-_SetView.height * 0.4 SetViewType:PasswordUnlockedPage];
    
}

/**
 跳到蓝牙解锁页面
 */
- (void)ShowBluetoothUnlocked:(NSString *)result {
    
    
    
}

/**
 跳到骑行页面
 */
- (void)ShowRideInTheBike:(NSString *)result {
    
    NSMutableArray *coordinatearray = [NSMutableArray array];
    
    [LGFUserDefaults setObject:coordinatearray forKey:@"coordinatearray"];
    
    [self StartRiding];
    
    NSMutableDictionary *allcoordinatedict = [NSMutableDictionary dictionary];
    
    [allcoordinatedict setObject:[NSDate NeedDateFormat:@"yyyy-MM-dd HH:mm:ss" ReturnType:returnstring date:[NSDate date]] forKey:@"starttime"];

    [LGFUserDefaults setObject:allcoordinatedict forKey:@"allcoordinatedict"];
    
    
    StartOrEndRiding = YES;
    
    RideInTheBike *RideInTheBikeVC = (RideInTheBike *)[AuxiliaryMethod ShowView:_RideInTheBikeView SelfVC:self];
    
    if (RideInTheBikeVC) RideInTheBikeVC.delegate = self;
    
    [self SetViewSetConstant:-_SetView.height * 0.4 SetViewType:RideInTheBikePage];
    
}

/**
 跳到支付页面
 */
- (void)ShowPayment:(NSString *)result {
    
    NSMutableArray *coordinatearray = [NSMutableArray arrayWithArray:[LGFUserDefaults objectForKey:@"coordinatearray"]];
    
    NSMutableDictionary *allcoordinatedict = [NSMutableDictionary dictionaryWithDictionary:[LGFUserDefaults objectForKey:@"allcoordinatedict"]];
    
    [allcoordinatedict setObject:coordinatearray forKey:@"coordinatearray"];
    
    
    [allcoordinatedict setObject:[NSDate NeedDateFormat:@"yyyy-MM-dd HH:mm:ss" ReturnType:returnstring date:[NSDate date]] forKey:@"endtime"];
    
    NSMutableArray *allcoordinatearray = [NSMutableArray arrayWithArray:[LGFUserDefaults objectForKey:@"allcoordinatearray"]];
    
    [allcoordinatearray addObject:allcoordinatedict];
    
    [LGFUserDefaults setObject:allcoordinatearray forKey:@"allcoordinatearray"];
    
    StartOrEndRiding = NO;
    
    Payment *PaymentVC = (Payment *)[AuxiliaryMethod ShowView:_PaymentView SelfVC:self];
    
    if (PaymentVC) PaymentVC.delegate = self;
    
    [self SetViewSetConstant:-_SetView.height * 0.4 SetViewType:PaymentPage];
    
}



/**
 跳到扫二维码页面
 */
- (void)ShowScanCode {
    
    [self RemoveMKPolyline:@"导航路线"];
    
    ScanCode *ScanCodeVC = (ScanCode *)[AuxiliaryMethod ShowView:_ScanCodeView SelfVC:self];
    
    if (ScanCodeVC) ScanCodeVC.delegate = self;
    
    [self SetViewSetConstant:-_SetView.height SetViewType:ScanCodePage];
    
}

/**
 跳到手动输入页面
 */
- (void)ShowManualInput {
    
    ManualInput *ManualInputVC = (ManualInput *)[AuxiliaryMethod ShowView:_ManualInputView SelfVC:self];
    
    if (ManualInputVC) ManualInputVC.delegate = self;

    [self SetViewSetConstant:-_SetView.height * 0.4 SetViewType:ManualInputPage];
    
}

/**
 手动输入页面键盘弹出
 */
- (void)ShowManualInputWithKeyboardHeight:(CGFloat)KeyboardHeight {
    
    ManualInput *ManualInputVC = (ManualInput *)[AuxiliaryMethod ShowView:_ManualInputView SelfVC:self];
    
    if (ManualInputVC) ManualInputVC.delegate = self;
    
    [self SetViewSetConstant:KeyboardHeight SetViewType:ManualInputPage];
    
}

/**
 跳到初始设置页
 */
- (void)ShowMainSetView {
    
    MainSet *MainSetVC = (MainSet *)[AuxiliaryMethod ShowView:_SetViewMainView SelfVC:self];
    
    if (MainSetVC) MainSetVC.delegate = self;
    
    [self SetViewSetConstant:-_SetView.height * 0.3 SetViewType:MainSetPage];
    
}

/**
 隐藏初始设置页
 */
- (void)HideMainSetView {

    [self SetViewSetConstant:-_SetView.height * 0.1 SetViewType:NonePage];
    
}

#pragma mark 一些逻辑封装

/**
 点击updown按钮 逻辑判断
 */
- (void)UpDownButtonSelected:(BOOL)Selected {
    
    if (Selected) {
        
        _UpDownButton.transform = CGAffineTransformMakeRotation(M_PI);
        
        [self HideMainSetView];
        
    } else {
        
        _UpDownButton.transform = CGAffineTransformIdentity;
        
        [self ShowMainSetView];
        
    }
    
    _UpDownButton.selected = Selected;
    
}

#pragma mark 手势代理 控制有效view

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isDescendantOfView:_ManualInputView] || [touch.view isDescendantOfView:_RideInTheBikeView] || [touch.view isDescendantOfView:_PaymentView]) {
        
        return NO;
        
    }
    
    return YES;
    
}

@end
