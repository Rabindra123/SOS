//
//  PatientBookingConfirmationController.m
//  sos
//
//  Created by Rabi Chourasia on 22/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "PatientBookingConfirmationController.h"

@interface PatientBookingConfirmationController ()

@end

@implementation PatientBookingConfirmationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self ShowRating];
   
    [self CallDoctorBookingTimer];
   // [self CheckRequestAccept];

}

-(void)CallDoctorBookingTimer {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/timmer.php";
    [manager POST:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
      //   [SVProgressHUD dismiss];
         
//         if ([[responseObject valueForKey:@"status"]boolValue]==1) {
         
         timerCheck = [NSTimer scheduledTimerWithTimeInterval:120.0
                                                                        target: self
                                                                      selector:@selector(onTick:)
                                                                      userInfo: nil repeats:YES];
             
             
             
//         }else{
//             [self.lbl_try_again setHidden:NO];
//         }
         
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}


-(BOOL)prefersStatusBarHidden { return YES; }
-(void)CheckRequestAccept{
    if ([timerCheck isValid])
    {
        [timerCheck invalidate];
    }
    timerCheck = nil;
    
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    NSMutableDictionary *SendDic =[[NSMutableDictionary alloc]init];
    [SendDic setValue:dateString forKey:@"timestamp"];
    [SendDic setValue:_getBookID forKey:@"book_id"];
    NSLog(@"Send Dic %@",SendDic);
    [self CallDoctorBooking:SendDic];
}
-(void)CallDoctorBooking : (NSMutableDictionary *)GetParam{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_accept_booking.php";
    [manager POST:url parameters:GetParam
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         if ([[responseObject valueForKey:@"success"]boolValue]==1) {
             book_id=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"book_id"]];
             _lbl_doctor_name.text=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"doctor_name"]];
             _lbl_doctor_specialist.text=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"med_speciality"]];
             _lbl_doctor_licence.text=[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"med_license"]];
             _lbl_doctor_visiting_fee.text=[NSString stringWithFormat:@"YOUR FEE THE VISIT WILL BE $%@",[responseObject valueForKey:@"fees"]];
             _lbl_doctor_visiting_time.text=[NSString stringWithFormat:@"%@ will see you in %@",[responseObject valueForKey:@"doctor_name"],[responseObject valueForKey:@"response_time"]];
            NSURL *image_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"profile"]]];
             [_image_doctor setImageWithURL:image_url];
             _image_doctor.layer.cornerRadius = _image_doctor.frame.size.height /2;
             _image_doctor.layer.masksToBounds = YES;
             [self ShowRating:[[responseObject valueForKey:@"rating"] floatValue]];
             

             
             [self.view_doctor_confirmed setHidden:NO];
             [_lbl_thankyou setHidden:YES];
             
         }else{
             [self.lbl_try_again setHidden:NO];
               [_lbl_thankyou setHidden:YES];
         }
         
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}

-(void)onTick:(NSTimer *)timer {
    //do smth
    
    [self CheckRequestAccept];
}

-(void)ShowRating : (float )GetRating{
#pragma For Rating Star
    self.doctorRateviewShow.notSelectedImage=[UIImage imageNamed:@"empty-star.png"];
    self.doctorRateviewShow.halfSelectedImage=[UIImage imageNamed:nil];
    self.doctorRateviewShow.fullSelectedImage=[UIImage imageNamed:@"star_yellow.png"];
    self.doctorRateviewShow.editable=NO;
    self.doctorRateviewShow.maxRating=5;
    self.doctorRateviewShow.rating=GetRating;
    self.doctorRateviewShow.delegate=self;
    
}

#pragma rating star Delegate
- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating {
    NSLog(@"rating%f",rating);
    // Score=rating;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapOpenMenu:(id)sender {
    [[SlideNavigationController sharedInstance]leftMenuSelected:nil ];
}
- (IBAction)didTapAccept:(id)sender {
    
    NSMutableDictionary *AcceptDic=[[NSMutableDictionary alloc]init];
    [AcceptDic setValue:book_id forKey:@"book_id"];
    NSLog(@"Accept Dic %@",AcceptDic);
    [self CallPatientAccept:AcceptDic];
}

- (IBAction)didTapCancel:(id)sender {
    NSMutableDictionary *CancelDic=[[NSMutableDictionary alloc]init];
    [CancelDic setValue:book_id forKey:@"book_id"];
    NSLog(@"Cancel Dic %@",CancelDic);
    [self CallPatientCancel:CancelDic];
}

- (IBAction)didTapHome:(id)sender {
    PatientDashboardController *GotoHome = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
    [self.navigationController pushViewController:GotoHome animated:YES];
    
}
-(void)CallPatientAccept : (NSMutableDictionary *)GetParam{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_accept.php";
    [manager POST:url parameters:GetParam
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         if ([[responseObject valueForKey:@"success"]boolValue]==1) {
             
             VisitConfirmedController *gotoVisitConfirmed = [self.storyboard instantiateViewControllerWithIdentifier:@"VisitConfirmedController"];
             
             [self.navigationController pushViewController:gotoVisitConfirmed animated:YES];
             
//             [self.view_doctor_confirmed setHidden:YES];
//             [_lbl_thankyou setHidden:NO];
//             [self.lbl_try_again setHidden:YES];
             
         }else{
//             [self.view_doctor_confirmed setHidden:YES];
//             [_lbl_thankyou setHidden:YES];
//             [self.lbl_try_again setHidden:YES];
         }
         
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)CallPatientCancel : (NSMutableDictionary *)GetParam{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_cancle.php";
    [manager POST:url parameters:GetParam
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         if ([[responseObject valueForKey:@"success"]boolValue]==1) {
             
             PatientDashboardController *gotoDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
             [self.navigationController pushViewController:gotoDashboard animated:YES];
             
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
