//
//  PatientDashboardController.m
//  sos
//
//  Created by Rabi Chourasia on 10/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "PatientDashboardController.h"

@interface PatientDashboardController ()

@end

@implementation PatientDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
    self.table_location.delegate=self;
    self.table_location.dataSource=self;
    [self.table_location setHidden:YES];
 //   NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    LatLong=[self deviceLocation];
   // NSLog(@"Get New Location %@ ",LatLong);
   
}

- (NSString *)deviceLocation
{
    NSString *theLocation = [NSString stringWithFormat:@"(%f,%f)",locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    return theLocation;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [self getCurrentLocation];
}
-(void)viewWillAppear:(BOOL)animated{
   
    [_btn_press_to_Request setUserInteractionEnabled:YES];

   
    currentZoom  = 15.0f;
    ArrayLocation = [[NSMutableArray alloc]init];
    
    
    [_txt_search_address addTarget:self
                            action:@selector(textFieldDidChangeText)
                  forControlEvents:UIControlEventEditingChanged];
   
    arrayDocorId=[[NSMutableArray alloc]init];
    NSMutableDictionary *showCurrentAddress =[[NSMutableDictionary alloc]init];
    [showCurrentAddress setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"patient_id"];
    
    [showCurrentAddress setValue:LatLong forKey:@"patient_latlon"];
    // [showCurrentAddress setValue:@"(22.641941,88.338753)" forKey:@"patient_latlon"];
    NSLog(@"Show Dic %@",showCurrentAddress);
    [self ShowuserLocation:showCurrentAddress];
   
}
-(void)textFieldDidChangeText{
    if ([_txt_search_address.text length] >= 3) {
        [self placeAutocompleteWithQuery:_txt_search_address.text];
        
    }
    else{
        [_table_location setHidden:YES];
    }
}
- (void)placeAutocompleteWithQuery:(NSString *)query {
    
    GMSVisibleRegion visibleRegion = _myMapViewShow.projection.visibleRegion;
    
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:visibleRegion.farLeft
                                                                       coordinate:visibleRegion.nearRight];
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc] init];
    filter.type = kGMSPlacesAutocompleteTypeFilterAddress;
    
    _placesClient = [[GMSPlacesClient alloc] init];
    [_placesClient autocompleteQuery:query
                              bounds:bounds
                              filter:filter
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                // NSLog(@"results: %@",results);
                                //removing all objects from array before adding new objects
                                [ArrayLocation removeAllObjects];
                                
                                for (GMSAutocompletePrediction* result in results) {
                                    NSLog(@"Result '%@' with placeID %@", result.attributedFullText.string, result.placeID);
                                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                                    [dict setValue:result.attributedFullText.string forKey:@"location"];
                                    [dict setValue:result.placeID forKey:@"placeID"];
                                    [ArrayLocation addObject:dict];
                                }
                                if ([ArrayLocation count]>0) {
                                    [_table_location setHidden:NO];
                                    [_table_location reloadData];
                                }else{
                                    [_table_location setHidden:YES];
                                   
                                }
                               
                                
                                
                                  NSLog(@"locations: %@",ArrayLocation);
                                
                            }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return [ArrayLocation count];
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
        static NSString *cellIdentifier = @"locationCell";
        
        locationCell *cell = [tableView dequeueReusableCellWithIdentifier:
                              cellIdentifier];
        if (cell == nil) {
            cell = [[locationCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.lbl_location_name.text=[NSString stringWithFormat:@"%@",[[ArrayLocation objectAtIndex:indexPath.row] valueForKey:@"location"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_txt_search_address resignFirstResponder];
    
   
        // NSLog(@"Select Details %@",[arrLocations objectAtIndex:indexPath.row]);
        NSString *placeID = [NSString stringWithFormat:@"%@",[[ArrayLocation objectAtIndex:indexPath.row] valueForKey:@"placeID"]];
        _txt_search_address.text=[NSString stringWithFormat:@"%@",[[ArrayLocation objectAtIndex:indexPath.row] valueForKey:@"location"]];
        [_placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error) {
            if (error != nil) {
                NSLog(@"Place Details error %@", [error localizedDescription]);
                return;
            }
            
            if (place != nil) {
     
                newSelectedCurrentLatLong=[NSString stringWithFormat:@"%f,%f",place.coordinate.latitude,place.coordinate.longitude];
                
                isSelectedAddress=YES;
                NSString *latitude = [NSString stringWithFormat:@"%f", place.coordinate.latitude];
                NSString *longitude = [NSString stringWithFormat:@"%f", place.coordinate.longitude];
                LatLong = [NSString stringWithFormat:@"(%@,%@)",latitude,longitude];
                 NSLog(@"nnew selected place details for %@", newSelectedCurrentLatLong);
                Avg_lat=latitude;
                Avg_lon=longitude;
                [self ShowCurrentAddressDetails :place.coordinate.latitude :place.coordinate.longitude];
                NSMutableDictionary *showCurrentAddress =[[NSMutableDictionary alloc]init];
                [showCurrentAddress setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"patient_id"];
            
                [showCurrentAddress setValue:LatLong forKey:@"patient_latlon"];
                NSLog(@"Selecte new address Dic %@",showCurrentAddress);
                [self ShowuserLocation:showCurrentAddress];
            } else {
                NSLog(@"No place details for %@", placeID);
            }
            [_table_location setHidden:YES];
        }];
        
        // _txt_searchLocation.text=@"";
    
}



//-(CLLocationCoordinate2D) getLocation{
//    locationManager = [[CLLocationManager alloc] init];
//    locationManager.delegate = self;
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    locationManager.distanceFilter = kCLDistanceFilterNone;
//    [locationManager startUpdatingLocation];
//    CLLocation *location = [locationManager location];
//    CLLocationCoordinate2D coordinate = [location coordinate];
//    return coordinate;
//}

- (void)getCurrentLocation{
//    CLLocationCoordinate2D coordinate = [self getLocation];
//    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
//    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
//    LatLong = [NSString stringWithFormat:@"(%@,%@)",latitude,longitude];
//    NSLog(@"Latitude  = %@", latitude);
//    NSLog(@"Longitude = %@", longitude);
//   [self GetCurrentAddressDetails:coordinate.latitude :coordinate.longitude];
//    [self ShowCurrentAddressDetails:coordinate.latitude :coordinate.longitude];
 
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    //NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
       NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        LatLong = [NSString stringWithFormat:@"(%@,%@)",latitude,longitude];
        //NSLog(@"Latitude  = %@", latitude);
        //NSLog(@"Longitude = %@", longitude);
       [self GetCurrentAddressDetails:location.coordinate.latitude :location.coordinate.longitude];
        [self ShowCurrentAddressDetails:location.coordinate.latitude :location.coordinate.longitude];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}
-(void)ShowuserLocation : (NSMutableDictionary *)Param{
    
   
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //NSString *url=@"http://usawebdzines.com/SOS/web_services/test.php";
  NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/find_doctor.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@" find doctor JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         if ([[responseObject valueForKey:@"success"] boolValue]==1)
         {
             
             [_btn_press_to_Request setUserInteractionEnabled:YES];

         
         NSError *error;
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                            options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                              error:&error];
         
                ArrayDoctors_Lat_long=[NSMutableArray arrayWithArray:[responseObject valueForKey:@"details"]];
         
        
         if ([ArrayDoctors_Lat_long count]>0) {
             
             Avg_lat=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"average_lat"] ];
             Avg_lon=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"average_lon"] ];
              [locationManager stopUpdatingLocation];
              _btn_press_to_Request.backgroundColor = [UIColor colorWithRed:65.0/255.0f green:140.0/255.0f blue:61.0/255.0f alpha:1.0] ;
            for (int i=0; i<[ArrayDoctors_Lat_long count]; i++) {
                [arrayDocorId addObject:[NSString stringWithFormat:@"%@",[[ArrayDoctors_Lat_long objectAtIndex:i] valueForKey:@"doc_id"]]];
            }
          //   NSLog(@"All Docor IDS %@",arrayDocorId);
            
         }else{
             _btn_press_to_Request.backgroundColor = [UIColor redColor];
         }
         if (isSelectedAddress==NO)
         {
             if ([ArrayDoctors_Lat_long count]>0)
             {
                
             }else{
                 [self ShowCurrentAddressDetails:[[responseObject valueForKey:@"avg_lat"] doubleValue] :[[responseObject valueForKey:@"avg_lon"] doubleValue]];
              
             }
               [self getCurrentLocation];
         }
         }else{
             [SVProgressHUD dismiss];
             //[self AlertShow:[responseObject valueForKey:@"messege"]];
             [locationManager stopUpdatingLocation];
             _btn_press_to_Request.backgroundColor = [UIColor colorWithRed:65.0/255.0f green:140.0/255.0f blue:61.0/255.0f alpha:1.0] ;
             
             _btn_press_to_Request.backgroundColor = [UIColor redColor];
             [_btn_press_to_Request setUserInteractionEnabled:NO];
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)GetCurrentAddressDetails :  (double) GetCurrentLat  : (double) GetcurrentLong{
    
    //http://maps.googleapis.com/maps/api/geocode/json?latlng=22.5631,88.3235&sensor=true_or_false
    //[SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //url=@"http://usawebdzines.com/SOS/web_services/patient_login_ios.php";
    NSString  *url=[NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true_or_false",GetCurrentLat,GetcurrentLong];
    NSLog(@"NEw URL %@",url);
    [manager POST:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        
      //   NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         NSLog(@"Data%@",[[[responseObject valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"]);
         _txt_search_address.text =[NSString stringWithFormat:@"%@",[[[responseObject valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"]];
         [locationManager stopUpdatingLocation];
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];

}
-(void)ShowCurrentAddressDetails :  (double) GetCurrentLat  : (double) GetcurrentLong{
    
    NSLog(@"Array Lat Long List ========%@",ArrayDoctors_Lat_long);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[Avg_lat doubleValue]
                                                            longitude:[Avg_lon doubleValue]
                                                                 zoom:currentZoom];
    
    for (int i=0; i<[ArrayDoctors_Lat_long count]; i++) {
       // NSLog(@"Average Lat %f",CurrnetLatPosition);
//         NSLog(@"Average Lon %f",currentLonPosition);
        
        NSString *newLat = [NSString stringWithFormat:@"%@",[[ArrayDoctors_Lat_long objectAtIndex:i] valueForKey:@"lat"]];
         NSString *newLong = [NSString stringWithFormat:@"%@",[[ArrayDoctors_Lat_long objectAtIndex:i] valueForKey:@"lon"]];
        
        NSLog(@"Get Doctor Lat== %@",newLat);
         NSLog(@"Get Doctor Lat== %@",newLat);
        GMSMarker *marker = [[GMSMarker alloc] init];
                marker.icon = [UIImage imageNamed:@"Doctor_available_plus_icon.png"];
                marker.position = CLLocationCoordinate2DMake([newLat floatValue], [newLong floatValue]);
                marker.title =@"";
                marker.snippet = @"";
                marker.appearAnimation = kGMSMarkerAnimationPop;
                marker.map = self.myMapViewShow;

    }
   _myMapViewShow.settings.scrollGestures = NO;
   [self.myMapViewShow addSubview:_image_select_location];
    [ self.myMapViewShow addSubview:_btn_select_doctor];
    [self.myMapViewShow addSubview:_btn_press_to_Request];
    [self.myMapViewShow addSubview:_view_card_details];
    [self.myMapViewShow addSubview:_view_add_payment];
    //set the camera for the map
    self.myMapViewShow.camera = camera;
    self.myMapViewShow.myLocationEnabled = YES;
 
    _myMapViewShow.settings.myLocationButton = YES;
    
}
-(void)ZoominOutMap:(CGFloat)level
{
  GMSCameraPosition  *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude
                                         longitude:locationManager.location.coordinate.longitude
                                              zoom:level];
    
    self.myMapViewShow.camera = camera;
}
-(void)zoomInMapView:(id)sender
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"] == nil || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"]] isEqualToString:@"xxxx-xxxx-xxxx-"] || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"]] isEqualToString:@""])
    {
        [_view_add_payment setHidden:NO];
        [_view_card_details setHidden:YES];
    }
    else{
        [_view_add_payment setHidden:YES];
        [_view_card_details setHidden:NO];
    }
    _lbl_show_card_no.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"];
    if(isZoom==NO)
    {
    [self.myMapViewShow animateToZoom:15];
        isZoom=YES;
    }else{
         [self.myMapViewShow animateToZoom:13];
        isZoom=NO;
    }
    [_btn_press_to_Request setHidden:NO];
    [_view_card_details setHidden:NO];
    
//    currentZoom = currentZoom + 5;
//
//    [self ZoominOutMap:currentZoom];
}

-(void) zoomOutMapView:(id)sender
{
    currentZoom = currentZoom - 1;
    
    [self ZoominOutMap:currentZoom];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTap_MenuOpen:(id)sender {
     [[SlideNavigationController sharedInstance]leftMenuSelected:nil ];
}
- (IBAction)didTapSearch_clear:(id)sender {
    _txt_search_address.text=@"";
}


- (IBAction)didTapPressToRequest:(id)sender {
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"] == nil || [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"]] isEqualToString:@"xxxx-xxxx-xxxx-"]||[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"]] isEqualToString:@""])
    {
        
        [self.view makeToast:@"Please add Card "
                    duration:3.0
                    position:CSToastPositionCenter];
    }
    else{
        
      //  NSString *joinedComponents = [arrayDocorId componentsJoinedByString:@","];
         [locationManager stopUpdatingLocation];
        
        DoctorBookingController *gotoBooking=[self.storyboard instantiateViewControllerWithIdentifier:@"DoctorBookingController"];
       gotoBooking.DoctorsIDList=[arrayDocorId componentsJoinedByString:@","];

        [self.navigationController pushViewController:gotoBooking animated:YES];

        
    }
   }
- (IBAction)didTapGotoCardUpdate:(id)sender {
     [locationManager stopUpdatingLocation];
    PatientPaymentViewController *gotoCardDetails=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientPaymentViewController"];
    [self.navigationController pushViewController:gotoCardDetails animated:YES];
}
- (IBAction)didTapGotoAddPayment:(id)sender {
     [locationManager stopUpdatingLocation];
    CardDetailsController *gotoAddcard=[self.storyboard instantiateViewControllerWithIdentifier:@"CardDetailsController"];
    gotoAddcard.ISCardAdd=YES;
    [self.navigationController pushViewController:gotoAddcard animated:YES];
}
@end
