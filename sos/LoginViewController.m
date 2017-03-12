//
//  LoginViewController.m
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self view_corner_radius:_view_login_feilds];
    [self Btn_corner_radius:_btn_login];
    [self Btn_corner_radius:_btn_signUp];
//    _Mytoken = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//      NSLog(@"MY Delegate ID%@", _Mytoken.MyDeviceID);
//    
    

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"patient_remember_email"] != nil) {
     
        _txt_email.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patient_remember_email"]];
         _txt_password.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"patient_remember_password"]];
        _image_checkbox.image = [UIImage imageNamed:@"checked.png"];
        isRemember=YES;
    }else{
        _image_checkbox.image = [UIImage imageNamed:@"unchecked.png"];
        isRemember=NO;
    }
    
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.center = self.view.center;
    //   [self.view addSubview:loginButton];
    
    
    _btnFBLogin.delegate=self;
    
    
    
    
    _btnFBLogin.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
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

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error{
    NSLog(@"fb result: %@",result.token);
    NSLog(@"User ID: %@",[FBSDKAccessToken currentAccessToken].userID);
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields": @"name, email, picture"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user data:%@  ", result);
             NSLog(@"email is %@", [result objectForKey:@"email"]);
             NSURL *dpurl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture??width=500&height=500",result[@"id"]]];
             NSLog(@"dp is %@", dpurl);
             
             //calling sign up api
             //[self signUpWithFB:result];
             
             NSString *name = [result objectForKey:@"name"];
             NSString *email=[result objectForKey:@"email"];
             
             NSString *firstname = [[name componentsSeparatedByString:@" "] objectAtIndex:0];
             NSString *lastname = [[name componentsSeparatedByString:@" "] objectAtIndex:1];
             NSMutableDictionary  * FacebookLoginDic =[[NSMutableDictionary alloc]init];
             [FacebookLoginDic setValue:[result objectForKey:@"id"] forKey:@"facebook_id"];
             [FacebookLoginDic setValue:email forKey:@"email"];
             [FacebookLoginDic setValue:lastname forKey:@"lname"];
             [FacebookLoginDic setValue:firstname forKey:@"fname"];
             [FacebookLoginDic setValue:[[[result valueForKey:@"picture"] valueForKey:@"data"]valueForKey:@"url"]forKey:@"fbimage"];
             
             
             NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
             [userdefault setObject:firstname forKey:@"fname"];
             [userdefault setObject:lastname forKey:@"lname"];
             NSLog(@"fab Dic==%@",FacebookLoginDic);
             
             [self FacebookSingIn:FacebookLoginDic];
         }
         else{
             NSLog(@"%@", [error localizedDescription]);
         }
     }];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)didTapSignIn:(id)sender {
    
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
    NSLog(@"Log==%@",SignInDic);
    [self SingIn:SignInDic];
    }
}

- (IBAction)didTapSignUP:(id)sender {
    PatientRegistrationViewController *gotoSignup = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientRegistrationViewController"];
    [self.navigationController pushViewController:gotoSignup animated:YES];
    
}

- (IBAction)didtapRemember:(id)sender {
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
    [userdefault setObject:_txt_email.text forKey:@"patient_remember_email"];
    [userdefault setObject:_txt_password.text forKey:@"patient_remember_password"];
    [userdefault setObject:@"yes" forKey:@"Is_rememberd"];
    [userdefault setObject:@"patient" forKey:@"remember_type"];
    [userdefault synchronize];
}
-(void)NotRemember{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"patient_remember_email"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"patient_remember_password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Is_rememberd"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"remember_type"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)didTapForgotpassword:(id)sender {
    ForgotpasswordController *gotoForgot =[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotpasswordController"];
    [self.navigationController pushViewController:gotoForgot animated:YES];
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
    
    //url=@"http://usawebdzines.com/SOS/web_services/patient_login_ios.php";
    url=@"http://usawebdzines.com/SOS/web_services/ios/patient_login.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
                if ([[responseObject valueForKey:@"success"] boolValue]==1)
                {
                    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                    [userdefault setObject:[responseObject valueForKey:@"uid"] forKey:@"user_id"];
                    [userdefault setObject:@"patient" forKey:@"loggedin_type"];
                    [userdefault setObject:[responseObject valueForKey:@"credit_card"] forKey:@"credit_card"];
                    [userdefault setObject:[responseObject valueForKey:@"email"] forKey:@"email"];
                    [userdefault setObject:[responseObject valueForKey:@"fname"] forKey:@"fname"];
                    [userdefault setObject:[responseObject valueForKey:@"lname"] forKey:@"lname"];
                    [userdefault setObject:[responseObject valueForKey:@"bank_acc"] forKey:@"bank_acc"];
                     [userdefault setObject:[responseObject valueForKey:@"profile"] forKey:@"profile_image"];
                    [userdefault synchronize];
                    PatientDashboardController *gotoDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
                    
                    [self.navigationController pushViewController:gotoDashboard animated:YES];

             
         }else{
             
             [self AlertShow:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"messege"]]];
             
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}

-(void)FacebookSingIn : (NSMutableDictionary *)Param{
    
     [self.view endEditing:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    url=@"http://usawebdzines.com/SOS/web_services/ios/pat_facebook_login.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         if ([[responseObject valueForKey:@"success"] boolValue]==1) {

         NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
             
             
         [userdefault setObject:[responseObject valueForKey:@"id"] forKey:@"user_id"];
         [userdefault setObject:[responseObject valueForKey:@"facebook_id"] forKey:@"fb_id"];
         [userdefault setObject:[responseObject valueForKey:@"email"] forKey:@"email"];
         [userdefault setObject:[responseObject valueForKey:@"credit_card"] forKey:@"credit_card"];
         [userdefault setObject:@"patient" forKey:@"loggedin_type"];
         [userdefault setObject:[responseObject valueForKey:@"email"] forKey:@"email"];    
         [userdefault synchronize];
 
             PatientDashboardController *gotoDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
             
             [self.navigationController pushViewController:gotoDashboard animated:YES];
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


- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
