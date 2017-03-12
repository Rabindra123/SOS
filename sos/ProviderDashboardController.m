//
//  ProviderDashboardController.m
//  sos
//
//  Created by Rabi Chourasia on 11/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ProviderDashboardController.h"

@interface ProviderDashboardController ()

@end

@implementation ProviderDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    _Mytoken = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    NSLog(@"MY Delegate ID%@", _Mytoken.MyDeviceID);
    [self getCurrentLocation];
    NSMutableDictionary *cardDic = [[NSMutableDictionary alloc]init];
    [cardDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    NSLog(@"Card Dic%@",cardDic);
    [self ShowNotification:cardDic];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(CLLocationCoordinate2D) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    return coordinate;
}

- (void)getCurrentLocation{
    CLLocationCoordinate2D coordinate = [self getLocation];
    currentLat = [NSString stringWithFormat:@"%f", coordinate.latitude];
    currentLong = [NSString stringWithFormat:@"%f", coordinate.longitude];
    LatLong = [NSString stringWithFormat:@"(%@,%@)",currentLat,currentLong];
    NSLog(@"Latitude  = %@", currentLat);
    NSLog(@"Longitude = %@", currentLong);
    [self ShowCurrentAddressDetails:coordinate.latitude :coordinate.longitude];
    
    
}

-(void)ShowCurrentAddressDetails :  (double) GetCurrentLat  : (double) GetcurrentLong{

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:GetCurrentLat
                                                            longitude:GetcurrentLong
                                                                 zoom:20];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(GetCurrentLat, GetcurrentLong);
    marker.title = @"";
    marker.snippet = @"";
    marker.map = self.mapView_;
    
    //set the camera for the map
    self.mapView_.camera = camera;
    self.mapView_.myLocationEnabled = YES;
    
    [self.mapView_ addSubview:_image_new_notification_arrow];
    
    
    
     
    // For multiple annotations
//     
//     NSArray* arrMarkerData = @[
//     @{@"title": @"Sydney", @"snippet": @"Australia", @"position": [[CLLocation alloc]initWithLatitude:17.4368 longitude:78.4439]},
//     @{@"title": @"Other location", @"snippet": @"other snippet", @"position": [[CLLocation alloc]initWithLatitude:17.398932 longitude:78.472718]}
//     ];
//     
//     for (NSDictionary* dict in arrMarkerData)
//     {
//     GMSMarker *marker = [[GMSMarker alloc] init];
//     marker.icon = [UIImage imageNamed:@"pointer.png"];
//     marker.position = [(CLLocation*)dict[@"position"] coordinate];
//     marker.title = dict[@"title"];
//     marker.snippet = dict[@"snippet"];
//     marker.appearAnimation = kGMSMarkerAnimationPop;
//     marker.map = self.mapView_;
//     }

     
    
}

-(void)ShowNotification : (NSMutableDictionary *)Param{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/show_notification.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Show Notification JSON: %@", responseObject);
         
         [SVProgressHUD dismiss];
         if ([[responseObject valueForKey:@"success"]boolValue]==1) {
             [_view_new_notification setHidden:NO];
             [_image_new_notification_arrow setHidden:NO];
             [_btn_go_tonotification setHidden:NO];
             
         }else{
             [_view_new_notification setHidden:YES];
             [_image_new_notification_arrow setHidden:YES];
             [_btn_go_tonotification setHidden:YES];
         }
//         if ([[[responseObject valueForKey:@"details"] valueForKey:@"card found"] boolValue]==1) {
//             
//            
//             
//         }else{
//             
//             
//             [self AlertShow:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]]];
//         }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)AlertShow : (NSString *)GetMsg{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error Message"
                                 message:GetMsg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:yesButton];
    
    
    [self presentViewController:alert animated:YES completion:nil];
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

- (IBAction)didTapNotificationChange:(id)sender {
    NSMutableDictionary *NotificationDic = [[NSMutableDictionary alloc]init];
    [NotificationDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    [NotificationDic setValue:LatLong  forKey:@"lat_lng"];
    [NotificationDic setValue:_Mytoken.MyDeviceID forKey:@"gcm_id"];
    
    if(_switch_notification.isOn){
        [NotificationDic setValue:@"1" forKey:@"status"];
        
    }else{
         [NotificationDic setValue:@"0" forKey:@"status"];
    }
    NSLog(@"Notification Status Dic== %@",NotificationDic);
    
    [self NotificationStatusChange:NotificationDic];
    
}
-(void)NotificationStatusChange : (NSMutableDictionary *)Param{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/doc_loc.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@" Notification Status JSON: %@", responseObject);
         [SVProgressHUD dismiss];
               if ([[responseObject valueForKey:@"success"]  boolValue]==1) {
         
                   [self.view makeToast:@"You Successfully Active profile" duration:3.0 position:CSToastPositionBottom];
                  }else{
         
         
                      [self AlertShow:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]]];
                 }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}

- (IBAction)didTapMenuOpen:(id)sender {
     [[SlideNavigationController sharedInstance]leftMenuSelected:nil ];
}
- (IBAction)DidTapGotoNotificationList:(id)sender {
    DoctorAcceptRquestController *gotoNotificationList = [self.storyboard instantiateViewControllerWithIdentifier:@"DoctorAcceptRquestController"];
    [self.navigationController pushViewController:gotoNotificationList animated:YES];
}
@end
