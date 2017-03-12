//
//  CardDetailsController.m
//  sos
//
//  Created by Rabi Chourasia on 12/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "CardDetailsController.h"

@interface CardDetailsController ()

@end

@implementation CardDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    _txt_cvv.delegate=self;
    [self TextBottomLine:_cardNumberField];
    [self TextBottomLine:_cardExpiryField];
    [self TextBottomLine:_txt_cvv];
    [self TextBottomLine:_txt_cardholder_name];
    self.cardNumberField.showsCardLogo = YES;
    [self tapGesture];
    [self CardNumberDoneKeyboard];
    // Do any additional setup after loading the view.
    [_btn_done setHidden:YES];
    
    if (_ISCardAdd==NO) {
        NSMutableDictionary *cardDic = [[NSMutableDictionary alloc]init];
        [cardDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"pat_id"];
        [self ShowSavedCard:cardDic];
    }
    
    
}
-(void)ShowSavedCard : (NSMutableDictionary *)Param{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         if ([[[responseObject valueForKey:@"details"] valueForKey:@"card found"] boolValue]==1) {
             
             _txt_cvv.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"details"] valueForKey:@"cvv"]];
             _txt_cardholder_name.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"details"] valueForKey:@"cardholderName"]];
             _cardNumberField.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"details"] valueForKey:@"credit_card"]];
             _cardExpiryField.text=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"details"] valueForKey:@"expirationDate"]];
             
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

-(void)tapGesture{
    
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard{
    [self.view endEditing:YES];
    
    
}
-(void)CardNumberDoneKeyboard {
#pragma  Done Button
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(ZipCodedoneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    _cardNumberField.inputAccessoryView = numberToolbar;
    _txt_cvv.inputAccessoryView = numberToolbar;
    _cardExpiryField.inputAccessoryView = numberToolbar;
    
}


-(void)ZipCodedoneWithNumberPad{
    
    [self.view endEditing:YES];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //4012888888881881
    //4111111111111111
    
    //        if (([_txt_cardholder_name.text length] >0 ) && ([_cardNumberField.text length] > 10) && ([_cardExpiryField.text length]>3) && ([_txt_cvv.text length]>2)) {
    //            [_btn_done setHidden:NO];
    //
    //    }
    return YES;
}

-(void)TextBottomLine :(UITextField *)GetTExt{
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor lightGrayColor].CGColor;
    border.frame = CGRectMake(0, GetTExt.frame.size.height - borderWidth, GetTExt.frame.size.width, GetTExt.frame.size.height);
    border.borderWidth = borderWidth;
    [GetTExt.layer addSublayer:border];
    GetTExt.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    [_btn_done setHidden:YES];

    
//    if (_btn_done.hidden) {
        if (([_txt_cardholder_name.text length] >0 ) && ([_cardNumberField.text length] > 10) && ([_cardExpiryField.text length]>3) && ([_txt_cvv.text length]>1)) {
            [_btn_done setHidden:NO];
            
        }
        
//    }
//    else{
//        if (([_txt_cardholder_name.text length] >0 ) && ([_cardNumberField.text length] > 10) && ([_cardExpiryField.text length]>3) && ([_txt_cvv.text length]>2)) {
//            [_btn_done setHidden:NO];
//            
//        }
//    }
    if (textField==_txt_cvv) {
        
        int length = [self getLength:_txt_cvv.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 3)
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


- (IBAction)didTapDone:(id)sender {
    
    NSMutableDictionary *saveCardDic= [[NSMutableDictionary alloc]init];
    [saveCardDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"pat_id"];
    [saveCardDic setValue:_cardNumberField.text forKey:@"credit_card"];
    [saveCardDic setValue:_cardExpiryField.text forKey:@"expirationDate"];
    [saveCardDic setValue:_txt_cardholder_name.text forKey:@"cardholderName"];
    [saveCardDic setValue:_txt_cvv.text forKey:@"cvv"];
    NSLog(@"Card Dic %@",saveCardDic);
    [self SavedCard:saveCardDic];
}

-(void)SavedCard : (NSMutableDictionary *)Param{
    [self.view endEditing:YES]; 
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/pat_card_details.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         if ([[responseObject valueForKey:@"success"] boolValue]==1) {
             NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
             [userdefault setObject:[responseObject valueForKey:@"card_num"] forKey:@"credit_card"];
             [userdefault synchronize];
             
             [self.view makeToast:@"Card Add Successfully"
                         duration:3.0
                         position:CSToastPositionCenter];
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

- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
