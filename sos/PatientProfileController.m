//
//  PatientProfileController.m
//  sos
//
//  Created by Rabi Chourasia on 16/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "PatientProfileController.h"

@interface PatientProfileController ()

@end

@implementation PatientProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myScrollview.delegate=self;
    NSMutableDictionary *showDic=[[NSMutableDictionary alloc]init];
    ArrayState=[[NSArray alloc]init];
   // [showDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"pat_id"];
     [showDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"email"] forKey:@"email"];
    NSLog(@"show Dic %@",showDic);
    [self ShowProfile:showDic];
    [self DoneKeyboard];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)DoneKeyboard{
#pragma  Done Button
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    
    _txt_mm_yy.inputAccessoryView = numberToolbar;
    _txt_cell.inputAccessoryView = numberToolbar;
    _txt_other.inputAccessoryView = numberToolbar;
    _txt_cvv.inputAccessoryView = numberToolbar;
    _txt_credit_card_no.inputAccessoryView = numberToolbar;
    _txt_zip.inputAccessoryView = numberToolbar;

    
    
}
-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];}


//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//   
//    [self.myScrollview setContentSize:CGSizeMake(320, 1000)];
//}
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
    if(textField ==_txt_add_home || textField ==_txt_add_work || textField == _txt_password || textField == _confirm_password)
       {
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==_txt_zip) {
        
        int length = [self getLength:_txt_zip.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 5)
        {
            if(range.length == 0)
                return NO;
        }
    }
    
    if (textField==_txt_cvv) {
        
        int length = [self getLength:_txt_cvv.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 3)
        {
            if(range.length == 0)
                return NO;
        }
    }
    if (textField==_txt_cell) {
        int length = [self getLength:_txt_cell.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:_txt_cell.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:_txt_cell.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
        
    }
    
    if (textField==_txt_other) {
        int length = [self getLength:_txt_other.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:_txt_other.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:_txt_other.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
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
-(NSString*)formatNumber:(NSString*)mobileNumber
{
    
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = [mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    
    return mobileNumber;
}

-(void)ShowProfile : (NSMutableDictionary *)Param{
    
    [self.view endEditing:YES];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    

 // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/showpatient_profile.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@" Dashboard JSON====>: %@", responseObject);
         [SVProgressHUD dismiss];
         if ([[[responseObject objectAtIndex:0] valueForKey:@"success"] intValue]==1)
      
         {
             _txt_fname.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"fname"]];
             _txt_lname.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"lname"]];
             if ([[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"state"]] isEqualToString:@""]) {
                  [_btn_state setTitle:@"State" forState: UIControlStateNormal];
             }
             else{
             [_btn_state setTitle: [NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"state"]]  forState: UIControlStateNormal];
                 [_btn_state setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             }
             //_btn_state.titleLabel.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"state"]];
             _txt_zip.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"zipcode"]];
             _txt_address.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"address"]];
             _txt_cell.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"cell"]];
             _txt_other.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"other_num"]];
             _txt_email.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"email"]];
             _txt_paypal_account.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"paypal"]];
             _txt_credit_card_no.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"credit_card"]];
             _txt_cvv.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"cvv"]];
             _txt_card_holder_name.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"cardholderName"]];
             _txt_mm_yy.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"expirationDate"]];////
             _txt_add_home.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"home_place"]];
             _txt_add_work.text=[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"work_place"]];
            
             NSURL *image_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[responseObject objectAtIndex:0] valueForKey:@"detail"] valueForKey:@"image"]]];
             NSLog(@"image url %@",image_url);
    
             [_image_profile setImageWithURL:image_url ];

             [self ShowState];
             
             
         }else{
             
             [self AlertShow:[NSString stringWithFormat:@"%@",[[responseObject objectAtIndex:0] valueForKey:@"messege"]]];
             
         }
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)ShowState{
  // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://www.usawebdzines.com/SOS/web_services/ios/citylist.php";
    [manager POST:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        // NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
        ArrayState=[NSArray arrayWithArray:[responseObject valueForKey:@"details"]];
      // NSLog(@" Array State==%@",ArrayState);

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
 
 address = Howrah;
 cardholderName = Rohit;
 cell = "(123) 345-4556";
 "credit_card" = "xxxx-xxxx-xxxx-";
 cvv = 123;
 email = "guddu@gmail.com";
 expirationDate = "02/19";
 fname = Guddu;
 "home_place" = 22342424;
 lname = Chourasia;
 "new_pass" = 100;
 other = "(534) 534-5345";
 "pat_id" = 1488048510;
 paypal = "paypal@gmail.com";
 state = Alaska;
 "work_place" = 2344234;
 zipcode = 13232;
*/

- (IBAction)didTapOpenCamera:(id)sender {
    [self OpenGallery];
}

- (IBAction)DidTapSave:(id)sender {

    if([_txt_password.text length]> 0 && ![_txt_password.text isEqualToString:@""]){
        if ([_txt_password.text isEqualToString:_confirm_password.text])
        {
            NSMutableDictionary *SaveDic= [[NSMutableDictionary alloc]init];
            [SaveDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"pat_id"];
            [SaveDic setValue:_txt_fname.text forKey:@"fname"];
            [SaveDic setValue:_txt_lname.text forKey:@"lname"];
            [SaveDic setValue:_txt_address.text forKey:@"address"];
            [SaveDic setValue:_txt_email.text forKey:@"email"];
            [SaveDic setValue:_txt_paypal_account.text forKey:@"paypal"];
            [SaveDic setValue:_txt_credit_card_no.text forKey:@"credit_card"];
            [SaveDic setValue:_txt_card_holder_name.text forKey:@"cardholderName"];
            [SaveDic setValue:_txt_cvv.text forKey:@"cvv"];
            [SaveDic setValue:_txt_mm_yy.text forKey:@"expirationDate"];
            [SaveDic setValue:_txt_add_home.text forKey:@"home_place"];
            [SaveDic setValue:_txt_add_work.text forKey:@"work_place"];
            [SaveDic setValue:_txt_password.text forKey:@"new_pass"];
            [SaveDic setValue:_txt_cell.text  forKey:@"cell"];
            [SaveDic setValue:_txt_other.text forKey:@"other"];
            [SaveDic setValue:_txt_zip.text forKey:@"zipcode"];
            [SaveDic setValue:_btn_state.titleLabel.text forKey:@"state"];
            NSLog(@"Save Dic %@",SaveDic);
             [self uploadPhoto:SaveDic];
 
        }else{
            [self AlertShow:@"password and confirm password does not match!"];
        }
    }
    else{
        NSMutableDictionary *SaveDic= [[NSMutableDictionary alloc]init];
        [SaveDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"pat_id"];
        [SaveDic setValue:_txt_fname.text forKey:@"fname"];
        [SaveDic setValue:_txt_lname.text forKey:@"lname"];
        [SaveDic setValue:_txt_address.text forKey:@"address"];
        [SaveDic setValue:_txt_email.text forKey:@"email"];
        [SaveDic setValue:_txt_paypal_account.text forKey:@"paypal"];
        [SaveDic setValue:_txt_credit_card_no.text forKey:@"credit_card"];
        [SaveDic setValue:_txt_card_holder_name.text forKey:@"cardholderName"];
        [SaveDic setValue:_txt_cvv.text forKey:@"cvv"];
        [SaveDic setValue:_txt_mm_yy.text forKey:@"expirationDate"];
        [SaveDic setValue:_txt_add_home.text forKey:@"home_place"];
        [SaveDic setValue:_txt_add_work.text forKey:@"work_place"];
       // [SaveDic setValue:_txt_password.text forKey:@"password"];
        [SaveDic setValue:_txt_cell.text  forKey:@"cell"];
        [SaveDic setValue:_txt_other.text forKey:@"other"];
        [SaveDic setValue:_txt_zip.text forKey:@"zipcode"];
        [SaveDic setValue:_btn_state.titleLabel.text forKey:@"state"];
        NSLog(@"Save Dic %@",SaveDic);
        [self uploadPhoto:SaveDic];

    }
    
}
-(void)uploadPhoto : (NSMutableDictionary *)GetUploadDic{
     [self.view endEditing:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
   
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://usawebdzines.com/SOS/web_services/ios/"]];
    NSData *imageData = UIImageJPEGRepresentation(self.image_profile.image, 0.5);
    // NSDictionary *parameters = @{@"username": self.username, @"password" : self.password};
   // NSLog(@"image Data ===>%@",imageData);
    AFHTTPRequestOperation *op = [manager POST:@"editpatient_profile.php" parameters:GetUploadDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"uploaded_file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        NSLog(@"Response object%@",responseObject);
        [SVProgressHUD dismiss];
        [self.view setUserInteractionEnabled:YES];
        [SVProgressHUD dismiss];
        if ([[responseObject valueForKey:@"success"] boolValue]==1) {
            
            
            [self.view makeToast:@"Profile update successfully "
                        duration:3.0
                        position:CSToastPositionCenter];
            PatientDashboardController *gotoDashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
            [self.navigationController pushViewController:gotoDashboard animated:YES];
            
        }else{
            [SVProgressHUD dismiss];
            
            [self AlertShow:@"Something Wrong!!"];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
}


-(void)OpenGallery{
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:nil      //  Must be "nil", otherwise a blank title area will appear above our two buttons
                                message:nil
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* button0 = [UIAlertAction
                              actionWithTitle:@"Cancel"
                              style:UIAlertActionStyleCancel
                              handler:^(UIAlertAction * action)
                              {
                                  //  UIAlertController will automatically dismiss the view
                              }];
    
    UIAlertAction* button1 = [UIAlertAction
                              actionWithTitle:@"Take photo"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                  picker.delegate = (id)self;
                                  if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                      picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  else
                                      picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                  
                                  [self presentViewController:picker animated:YES completion:NULL];
                                  
                              }];
    
    UIAlertAction* button2 = [UIAlertAction
                              actionWithTitle:@"Gallery"
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  
                                  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                  picker.delegate = (id)self;
                                  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                  [self presentViewController:picker animated:YES completion:NULL];
                              }];
    
    [alert addAction:button0];
    [alert addAction:button1];
    [alert addAction:button2];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{
    self.image_profile.image = image;
    imagedata = UIImageJPEGRepresentation(self.image_profile.image, 0.5);
    //imagedata=(UIImage *)UIImageJPEGRepresentation(image,1.0f);
    // NSLog(@"image data%@",imagedata);
    
    [self layoutImageView];
    
    // self.navigationItem.rightBarButtonItem.enabled = YES;
    
    CGRect viewFrame = [self.view convertRect:self.image_profile.frame toView:self.navigationController.view];
    self.image_profile.hidden = YES;
    [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:viewFrame completion:^{
        self.image_profile.hidden = NO;
    }];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
     [self.myScrollview setContentSize:CGSizeMake(320, self.myScrollview.frame.size.height+240)];
}

- (void)layoutImageView
{
    if (self.imageView.image == nil)
        return;
    
    CGFloat padding = 20.0f;
    
    CGRect viewFrame = self.view.frame;
    viewFrame.size.width -= (padding * 2.0f);
    viewFrame.size.height -= ((padding * 2.0f));
    
    CGRect imageFrame = CGRectZero;
    imageFrame.size = self.imageView.image.size;
    
    CGFloat scale = MIN(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height);
    imageFrame.size.width *= scale;
    imageFrame.size.height *= scale;
    imageFrame.origin.x = (CGRectGetWidth(self.view.bounds) - imageFrame.size.width) * 0.5f;
    imageFrame.origin.y = (CGRectGetHeight(self.view.bounds) - imageFrame.size.height) * 0.5f;
    self.imageView.frame = imageFrame;
    
}


#pragma mark - Image Picker Delegate -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.image = image;
        TOCropViewController *cropController = [[TOCropViewController alloc] initWithImage:image];
        cropController.delegate = self;
        //_defualtImageView.hidden=YES;
        [self presentViewController:cropController animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)didTapBack:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
    PatientDashboardController *gotoBack=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
    [self.navigationController pushViewController:gotoBack animated:YES];
}
- (IBAction)DidTapSelectState:(id)sender {
  
    
    
        NSArray * arrImage = [[NSArray alloc] init];
        arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
        if(dropDown == nil) {
            CGFloat f = 200;
            dropDown = [[NIDropDown alloc]showDropDown:sender :&f :ArrayState  :arrImage : @"down"];
            dropDown.delegate = self;
        }
        else {
            [dropDown hideDropDown:sender];
            [self rel];
        }
        
    }
    -(void)rel{
        //    [dropDown release];
        dropDown = nil;
    }
-(void)niDropDownDelegateMethod:(NIDropDown *)sender :(NSInteger)IndexNo{
   
    NSLog(@"Selected ==%ld",(long)IndexNo);
//    NSLog(@"SElected Id %@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"id"]);
//    SelectedMaterialTypeID = [NSString stringWithFormat:@"%@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"id"]];
//    NSLog(@"SElected Id %@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"title"]);
    [self rel];
    NSLog(@"%@", _btn_state.titleLabel.text);
       [_btn_state setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

@end
