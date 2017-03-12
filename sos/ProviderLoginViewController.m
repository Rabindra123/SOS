//
//  ProviderLoginViewController.m
//  sos
//
//  Created by Rabi Chourasia on 06/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ProviderLoginViewController.h"

@interface ProviderLoginViewController ()

@end

@implementation ProviderLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // _Mytoken = (AppDelegate*)[[UIApplication sharedApplication] delegate];
   // NSLog(@"MY Delegate ID%@", _Mytoken.MyDeviceID);
   // [self AlertShow:_Mytoken.MyDeviceID];

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"doctor_remember_email"] != nil) {
        
        _txt_email.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"doctor_remember_email"]];
        _txt_password.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"doctor_remember_password"]];
        _image_checkbox.image = [UIImage imageNamed:@"checked.png"];
        isRemember=YES;
    }else{
        _image_checkbox.image = [UIImage imageNamed:@"unchecked.png"];
        isRemember=NO;
    }
    
    
    [self view_corner_radius:_view_login_field];
    [self Btn_corner_radius:_btn_login];
    [self Btn_corner_radius:_btn_signup];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self getCurrentLocation];

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
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    LatLong = [NSString stringWithFormat:@"(%@,%@)",latitude,longitude];
    NSLog(@"Latitude  = %@", latitude);
    NSLog(@"Longitude = %@", longitude);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dismissKeyboard
{
    [_txt_password resignFirstResponder];
    [_txt_email resignFirstResponder];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField==_txt_email) {
        
        [_txt_password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
-(void)view_corner_radius :(UIView *)GetView{
    // border radius
    [GetView.layer setCornerRadius:10.0f];
    
    // border
    [GetView.layer setBorderColor:[UIColor colorWithRed:77.0/255.0f green:80.0/255.0f blue:113.0/255.0f alpha:1.0].CGColor];
    [GetView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [GetView.layer setShadowColor:[UIColor blackColor].CGColor];
    [GetView.layer setShadowOpacity:0.8];
    [GetView.layer setShadowRadius:3.0];
    [GetView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

-(void)Btn_corner_radius :(UIButton *)GetButton{
    // border radius
    //  [GetButton.layer setCornerRadius:10.0f];
    
    // border
    [GetButton.layer setBorderColor:[UIColor colorWithRed:63.0/255.0f green:95.0/255.0f blue:140.0/255.0f alpha:1.0].CGColor];
    [GetButton.layer setBorderWidth:1.5f];
    
    // drop shadow
    [GetButton.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [GetButton.layer setShadowOpacity:0.8];
    [GetButton.layer setShadowRadius:3.0];
    [GetButton.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapRememberPassword:(id)sender {
    if (isRemember==NO) {
        _image_checkbox.image = [UIImage imageNamed:@"checked.png"];
        
        
        isRemember=YES;
    }else{
        _image_checkbox.image = [UIImage imageNamed:@"unchecked.png"];
        isRemember=NO;
    }
}
-(void)IsRemember{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:_txt_email.text forKey:@"doctor_remember_email"];
    [userdefault setObject:_txt_password.text forKey:@"doctor_remember_password"];
    [userdefault setObject:@"yes" forKey:@"Is_rememberd"];
    [userdefault setObject:@"doctor" forKey:@"remember_type"];
    [userdefault synchronize];
}
-(void)NotRemember{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"doctor_remember_email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"doctor_remember_password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Is_rememberd"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"remember_type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)didTapForgotPassword:(id)sender {
    ForgotpasswordController *gotoForgot =[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotpasswordController"];
    [self.navigationController pushViewController:gotoForgot animated:YES];
}

- (IBAction)didTapLogin:(id)sender {
    
    NSString *emailString = _txt_email.text;
    NSString *emailRegval = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegval];
    
    
    if (([emailTest evaluateWithObject:emailString] != YES)  || [emailString isEqualToString:@""])
    {
        [_txt_email becomeFirstResponder];
        [self AlertShow:@"Please enter a valid E-mail"];
        
        
        
    }
    
    else  if ([_txt_password.text isEqualToString:@""] || [_txt_password.text length]==0) {
        [_txt_password becomeFirstResponder];
        [self AlertShow:@"Please enter password"];
        
    }
    else{
    NSMutableDictionary *SignInDic=[[NSMutableDictionary alloc]init];
    [SignInDic setValue:_txt_email.text forKey:@"email"];
    [SignInDic setValue:_txt_password.text forKey:@"psswrd"];
    [SignInDic setValue:@"ios" forKey:@"type"];
    [SignInDic setValue:LatLong forKey:@"lat_lon"];
        [SignInDic setValue:@"" forKey:@"gcm_id"];
    // [SignInDic setValue:[NSString stringWithFormat:@"%@",_Mytoken.MyDeviceID] forKey:@"gcm_id"];
    NSLog(@"Log==%@",SignInDic);
   [self SingIn:SignInDic];
    }
}
-(void)SingIn : (NSMutableDictionary *)Param{
     [self.view endEditing:YES];
    if (isRemember==YES) {
        [self IsRemember];
    }else{
        [self NotRemember];
    }
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    url=@"http://usawebdzines.com/SOS/web_services/ios/doctor_login.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         
         if ([[responseObject valueForKey:@"success"] boolValue]==1) {
             
             NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
             [userdefault setObject:[responseObject valueForKey:@"id"] forKey:@"user_id"];
             [userdefault setObject:[responseObject valueForKey:@"bank_account"] forKey:@"bank_account"];
             [userdefault setObject:[responseObject valueForKey:@"email"] forKey:@"email"];

              [userdefault setObject:@"provider" forKey:@"loggedin_type"];
             
             [userdefault synchronize];
            ProviderDashboardController *gotodashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboardController"];
             [self.navigationController pushViewController:gotodashboard animated:YES];

             
         }else{
             [self AlertShow:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]]];

         }
         
         //         ArrayMatchList=[NSMutableArray arrayWithArray:[responseObject valueForKey:@"data"]];
         //         [self.table_match_list reloadData];
         
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


- (IBAction)didTapSignUp:(id)sender {
    ProviderRegistrationViewController *gotoDoctorSignUp = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderRegistrationViewController"];
    [self.navigationController pushViewController:gotoDoctorSignUp animated:YES];
}
- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
