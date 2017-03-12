//
//  ForgotpasswordController.m
//  sos
//
//  Created by Rabi Chourasia on 10/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ForgotpasswordController.h"

@interface ForgotpasswordController ()

@end

@implementation ForgotpasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self BottomLoneText:_txt_email];
    [_txt_email becomeFirstResponder];
    _txt_email.delegate=self;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_txt_email resignFirstResponder];
    return YES;
}

-(void)BottomLoneText : (UITextField *)GetTExt{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor colorWithRed:42.0/255.0f green:108.0/255.0f blue:177.0/255.0f alpha:1.0].CGColor;
    border.frame = CGRectMake(0, GetTExt.frame.size.height - borderWidth, GetTExt.frame.size.width, GetTExt.frame.size.height);
    border.borderWidth = borderWidth;
    [GetTExt.layer addSublayer:border];
    GetTExt.layer.masksToBounds = YES;
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

- (IBAction)DidTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)didTapSubmit:(id)sender {
    NSString *emailString = _txt_email.text;
    NSString *emailRegval = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegval];
    
    if (([emailTest evaluateWithObject:emailString] != YES)  || [emailString isEqualToString:@""])
    {
        [_txt_email becomeFirstResponder];
        [self AlertShow:@"Please enter a valid E-mail"];
        
        
        
    }
    else{
    

    
    
    NSMutableDictionary *forgotDic=[[NSMutableDictionary alloc]init];
    [forgotDic setValue:_txt_email.text forKey:@"email"];
     
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Login_type"] isEqualToString:@"patient"]) {
       LoginType = @"pat";
    }else{
        LoginType = @"doc";
    }
    [forgotDic setValue:@"pat" forKey:@"type"];
    [self ForgotPasswordCall:forgotDic];
    }
    
}

-(void)ForgotPasswordCall : (NSMutableDictionary *)Param{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
   NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/forgot_password.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         if ([[responseObject valueForKey:@"success"] boolValue]==1) {
             
             
//             PatientPaymentViewController *gotoPay=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientPaymentViewController"];
//             [self.navigationController pushViewController:gotoPay animated:YES];
         }else{
             
             
             [self AlertShow:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"msg"]]];
         }
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

@end
