//
//  DoctorBookingController.m
//  sos
//
//  Created by Rabi Chourasia on 15/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "DoctorBookingController.h"

@interface DoctorBookingController ()

@end

@implementation DoctorBookingController

- (void)viewDidLoad {
    [super viewDidLoad];
    _txt_age.delegate=self;
    _txt_additional_feat.delegate=self;
    ArrayLocation=[[NSMutableArray alloc]init];
    ArrayDoctorSpecialList=[[NSArray alloc]init];
    ArraySymptomsList=[[NSArray alloc]init];
    _table_location.delegate=self;
    _table_location.dataSource=self;
    // Do any additional setup after loading the view.
    _lbl_username.text=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"fname"],[[NSUserDefaults standardUserDefaults] objectForKey:@"lname"]];
    [self getCurrentLocation];
    [_txt_new_address addTarget:self
                         action:@selector(textFieldDidChangeText)
               forControlEvents:UIControlEventEditingChanged];

    [self ShowDoctorSpecialist];
    NSLog(@"All Doctor List %@",_DoctorsIDList);
//    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    [self DoneKeyboard];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)DoneKeyboard {
#pragma  Done Button
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _txt_age.inputAccessoryView = numberToolbar;
   
    
}


-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
    
}
#pragma  KeyBoard Move Up

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

-(void)animateTextField:(UITextField*)textField up:(BOOL)up
{
    if(textField ==_txt_additional_feat || textField ==_txt_age ){
        const int movementDistance = -190; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
       if (textField==_txt_age) {
        
        int length = [self getLength:_txt_age.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 2)
        {
            if(range.length == 0)
                return NO;
        }
    }
    
    return YES;
}

-(int)getLength:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    
    return length;
    
    
}

-(void)textFieldDidChangeText{
    if ([_txt_new_address.text length] >= 3) {
         tap.enabled=NO;
        [self placeAutocompleteWithQuery:_txt_new_address.text];
        
    }
    else{
        tap.enabled=YES;
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

-(void)GetCurrentAddressDetails :  (double) GetCurrentLat  : (double) GetcurrentLong{
    
    //http://maps.googleapis.com/maps/api/geocode/json?latlng=22.5631,88.3235&sensor=true_or_false
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
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
         _txt_new_address.text =[NSString stringWithFormat:@"%@",[[[responseObject valueForKey:@"results"] objectAtIndex:0] valueForKey:@"formatted_address"]];
         
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ArrayLocation count];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *cellIdentifier = @"bookingLoationCell";
    
    bookingLoationCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    if (cell == nil) {
        cell = [[bookingLoationCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.lbl_showLocation.text=[NSString stringWithFormat:@"%@",[[ArrayLocation objectAtIndex:indexPath.row] valueForKey:@"location"]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_txt_new_address resignFirstResponder];
    
    
    // NSLog(@"Select Details %@",[arrLocations objectAtIndex:indexPath.row]);
    NSString *placeID = [NSString stringWithFormat:@"%@",[[ArrayLocation objectAtIndex:indexPath.row] valueForKey:@"placeID"]];
    _txt_new_address.text=[NSString stringWithFormat:@"%@",[[ArrayLocation objectAtIndex:indexPath.row] valueForKey:@"location"]];
    [_placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            //            NSLog(@"Place name %@", place.name);
            //            NSLog(@"Place address %@", place.formattedAddress);
            //            NSLog(@"Place placeID %@", place.placeID);
            //            NSLog(@"Place attributions %@", place.attributions);
            //            NSLog(@"Place Latitude %f",place.coordinate.latitude);
            //             NSLog(@"Place longitude %f",place.coordinate.longitude);
            
            //                longi=place.coordinate.longitude;
            //                lati=place.coordinate.latitude;
            newSelectedCurrentLatLong=[NSString stringWithFormat:@"%f,%f",place.coordinate.latitude,place.coordinate.longitude];
            
            isSelectedAddress=YES;
            NSString *latitude = [NSString stringWithFormat:@"%f", place.coordinate.latitude];
            NSString *longitude = [NSString stringWithFormat:@"%f", place.coordinate.longitude];
            LatLong = [NSString stringWithFormat:@"(%@,%@)",latitude,longitude];
            NSLog(@"nnew selected place details for %@", newSelectedCurrentLatLong);
            [self ShowCurrentAddressDetails :place.coordinate.latitude :place.coordinate.longitude];
            
            
        } else {
            NSLog(@"No place details for %@", placeID);
        }
        tap.enabled=YES;
        [_table_location setHidden:YES];
    }];
    
    // _txt_searchLocation.text=@"";
    
}

- (void)getCurrentLocation{
    CLLocationCoordinate2D coordinate = [self getLocation];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    LatLong = [NSString stringWithFormat:@"(%@,%@)",latitude,longitude];
    NSLog(@"Latitude  = %@", latitude);
    NSLog(@"Longitude = %@", longitude);
   
    [self ShowCurrentAddressDetails:coordinate.latitude :coordinate.longitude];
     [self GetCurrentAddressDetails:coordinate.latitude :coordinate.longitude];
}
-(void)ShowCurrentAddressDetails :  (double) GetCurrentLat  : (double) GetcurrentLong{
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:GetCurrentLat
                                                            longitude:GetcurrentLong
                                                                 zoom:12.0];
    
  //
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(GetCurrentLat, GetcurrentLong);
        marker.icon = [UIImage imageNamed:@"Doctor_available_plus_icon.png"];
        marker.title = @"";
        marker.snippet = @"";
        marker.map = self.myMapViewShow;
    
       //set the camera for the map
     [self.myMapViewShow addSubview:_table_location];
    self.myMapViewShow.camera = camera;
    self.myMapViewShow.myLocationEnabled = YES;
    
    _myMapViewShow.settings.myLocationButton = YES;
    
}
-(void)ShowDoctorSpecialist{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/speciliest_doc.php";
    [manager POST:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         [self ShowPatientSymptomslist];
           ArrayDoctorSpecialList=[NSArray arrayWithArray:[responseObject valueForKey:@"details"]];
         
         //         if ([[[responseObject objectAtIndex:0] valueForKey:@"success"] intValue]==1)
         //
         //         {
         //
         //
         //
         //
         //         }else{
         //
         //             [self AlertShow:[NSString stringWithFormat:@"%@",[[responseObject objectAtIndex:0] valueForKey:@"messege"]]];
         //
         //         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)ShowPatientSymptomslist{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/symptoms_list.php";
    [manager POST:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
           ArraySymptomsList=[NSArray arrayWithArray:[responseObject valueForKey:@"details"]];
         
            }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
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

- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapBookNow:(id)sender {

    if ([_btn_select_provider.titleLabel.text isEqualToString:@"I NEED (SELECT PROVIDER)"]) {
         [self AlertShow:@"Please  select your provider"];
    }
    else  if ([_btn_symptoms.titleLabel.text isEqualToString:@"MY SYMPTOMS"]){
         [self AlertShow:@"Please  select your symptoms"];
        
    }else if([_txt_age.text length]==0 || [_txt_age.text isEqualToString:@""]){
         [self AlertShow:@"Please  enter your age!"];
    }else{
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day = [components day];
        NSInteger week = [components month];
        NSInteger year = [components year];
        
        NSString *currentDate = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)day, (long)week, (long)year];
        
        
        NSMutableDictionary *bookDic = [[NSMutableDictionary alloc]init];
        [bookDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"patient_id"];
        [bookDic setValue:_DoctorsIDList forKey:@"selected_doc"];
        [bookDic setValue:LatLong forKey:@"lat_lon"];
        [bookDic setValue:currentDate forKey:@"request_date"];
        [bookDic setValue:_btn_select_provider.titleLabel.text forKey:@"specialist"];
        [bookDic setValue:_btn_symptoms.titleLabel.text forKey:@"symptom"];
        [bookDic setValue:_txt_additional_feat.text forKey:@"other_info"];
        [bookDic setValue:_txt_age.text forKey:@"age"];
        [bookDic setValue:_txt_new_address.text forKey:@"location"];
        NSLog(@"Book Dic %@",bookDic);
        [self CallDoctorBooking:bookDic];
        
    }
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
- (IBAction)didTapSpeakNow:(id)sender {
    
    if ([_btn_select_provider.titleLabel.text isEqualToString:@"I NEED (SELECT PROVIDER)"]) {
        [self AlertShow:@"Please  select your provider"];
    }
    else  if ([_btn_symptoms.titleLabel.text isEqualToString:@"MY SYMPTOMS"]){
        [self AlertShow:@"Please  select your symptoms"];
        
    }else if([_txt_age.text length]==0 || [_txt_age.text isEqualToString:@""]){
        [self AlertShow:@"Please  enter your age!"];
    }else{
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger day = [components day];
        NSInteger week = [components month];
        NSInteger year = [components year];
        
        NSString *currentDate = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)day, (long)week, (long)year];
        
        
        NSMutableDictionary *bookDic = [[NSMutableDictionary alloc]init];
        [bookDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"patient_id"];
        [bookDic setValue:_DoctorsIDList forKey:@"selected_doc"];
        [bookDic setValue:LatLong forKey:@"lat_lon"];
        [bookDic setValue:currentDate forKey:@"request_date"];
        [bookDic setValue:_btn_select_provider.titleLabel.text forKey:@"specialist"];
        [bookDic setValue:_btn_symptoms.titleLabel.text forKey:@"symptom"];
        [bookDic setValue:_txt_additional_feat.text forKey:@"other_info"];
        [bookDic setValue:_txt_age.text forKey:@"age"];
        [bookDic setValue:_txt_new_address.text forKey:@"location"];
        NSLog(@"Book Dic %@",bookDic);
      //  [self CallDoctorBooking:bookDic];
        
    }

}
- (IBAction)DidTapBack:(id)sender {
}
-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
- (IBAction)didTapSelectProvider:(id)sender {
   IsSymptomClick=NO;
    tap.enabled=NO;
   
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :ArrayDoctorSpecialList :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
    

}
- (IBAction)didTapMySymptoms:(id)sender {
    IsSymptomClick=YES;
     tap.enabled=NO;
    
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :ArraySymptomsList :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

}
-(void)niDropDownDelegateMethod:(NIDropDown *)sender :(NSInteger)IndexNo{
     tap.enabled=YES;
    if (IsSymptomClick==YES) {
        [self rel];
        NSLog(@"%@", _btn_symptoms.titleLabel.text);
    }else{
        [self rel];
        NSLog(@"%@", _btn_select_provider.titleLabel.text);
    }
    
    
    NSLog(@"Selected ==%ld",(long)IndexNo);
    //    NSLog(@"SElected Id %@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"id"]);
    //    SelectedMaterialTypeID = [NSString stringWithFormat:@"%@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"id"]];
    //    NSLog(@"SElected Id %@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"title"]);
    
}

-(void)CallDoctorBooking : (NSMutableDictionary *)GetParam{
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/request_doctor.php";
    [manager POST:url parameters:GetParam
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         if ([[responseObject valueForKey:@"success"]boolValue]==1) {
             
             PatientBookingConfirmationController *gotoPatientBooking =[self.storyboard instantiateViewControllerWithIdentifier:@"PatientBookingConfirmationController"];
             gotoPatientBooking.getBookID=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"book_id"]];
             [self.navigationController pushViewController:gotoPatientBooking animated:YES];
         }else{
             
         }
        
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}

@end
