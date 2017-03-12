//
//  ProviderRegistrationViewController.m
//  sos
//
//  Created by Alok Das on 06/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ProviderRegistrationViewController.h"

@interface ProviderRegistrationViewController ()

@end

@implementation ProviderRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self DoneKeyboard];
    // Do any additional setup after loading the view.
    [_txt_routing_no setEnabled:YES];
     ArrayState=[[NSArray alloc]init];
    DoctorSpecialist=[[NSArray alloc]init];
    [self ShowState];
    [self DateOfBirth];
    [self tapGesture];
    tap.enabled=YES;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)tapGesture{
    
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard{
    [self.view endEditing:YES];
    
    
}
-(void)DateOfBirth{
    self.txt_date_of_birth.delegate = self;
    
    // alloc/init your date picker, and (optional) set its initial date
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]]; //this returns today's date
    
    // theMinimumDate (which signifies the oldest a person can be) and theMaximumDate (defines the youngest a person can be) are the dates you need to define according to your requirements, declare them:
    
    // the date string for the minimum age required (change according to your needs)
    NSString *maxDateString = @"01/01/2000";
    // the date formatter used to convert string to date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // the specific format to use
    dateFormatter.dateFormat = @"dd/MM/yyyy";
    // converting string to date
    NSDate *theMaximumDate = [dateFormatter dateFromString: maxDateString];
    
    // repeat the same logic for theMinimumDate if needed
    
    // here you can assign the max and min dates to your datePicker
    [datePicker setMaximumDate:theMaximumDate]; //the min age restriction
  //  [datePicker setMinimumDate:theMinimumDate]; //the max age restriction (if needed, or else dont use this line)
    
    // set the mode
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // update the textfield with the date everytime it changes with selector defined below
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    // and finally set the datePicker as the input mode of your textfield
    [self.txt_date_of_birth setInputView:datePicker];
}
-(void)updateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)self.txt_date_of_birth.inputView;
    self.txt_date_of_birth.text = [self formatDate:picker.date];
}
- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
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
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         ArrayState=[NSArray arrayWithArray:[responseObject valueForKey:@"details"]];
         [self ShowMedicalSpecialist];
                  
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)ShowMedicalSpecialist{
    // [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    // NSString  *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_profile.php";
    NSString *url=@"http://www.usawebdzines.com/SOS/web_services/ios/speciliest_doc.php";
    [manager POST:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         DoctorSpecialist=[NSArray arrayWithArray:[responseObject valueForKey:@"details"]];
        
         
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
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

    _txt_routing_no.inputAccessoryView = numberToolbar;
    _txt_cell.inputAccessoryView = numberToolbar;
    _txt_other.inputAccessoryView = numberToolbar;
    _txt_ssn.inputAccessoryView = numberToolbar;
     _txt_date_of_birth.inputAccessoryView = numberToolbar;
     _txt_zip.inputAccessoryView = numberToolbar;
    
    
}
-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];}



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
    if (textField==_txt_ssn) {
        int length = [self getLength:_txt_ssn.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:_txt_ssn.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:_txt_ssn.text];
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


    //Format Date of Birth YYYY-MM-DD
    if(textField == _txt_date_of_birth)
    {
        if ((_txt_date_of_birth.text.length == 2)||(_txt_date_of_birth.text.length == 5))
            //Handle backspace being pressed
            if (![string isEqualToString:@""])
                _txt_date_of_birth.text = [_txt_date_of_birth.text stringByAppendingString:@"/"];
        return !([textField.text length]>9 && [string length] > range.length);
    }
    else
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
    if(textField ==_txt_bank_name || textField ==_txt_acct_number || textField == _txt_routing_no ){
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
    if (textField==_txt_first_name) {
        [self.view endEditing:YES];
        [_txt_last_name becomeFirstResponder];
    }
    else if (textField==_txt_last_name) {
        [self.view endEditing:YES];
        [_txt_date_of_birth becomeFirstResponder];
    }
    else if (textField==_txt_date_of_birth) {
        [self.view endEditing:YES];
        [_txt_ssn becomeFirstResponder];
    }
    else if (textField==_txt_ssn) {
        [self.view endEditing:YES];
        [_txt_address becomeFirstResponder];
    }
   else if (textField==_txt_address) {
         [self.view endEditing:YES];
        [_txt_city becomeFirstResponder];
    }
   else if (textField==_txt_city) {
       [self.view endEditing:YES];
       [_txt_zip becomeFirstResponder];
   }
   else if (textField==_txt_zip) {
       [self.view endEditing:YES];
       [_txt_cell becomeFirstResponder];
   }else if (textField==_txt_cell) {
       [self.view endEditing:YES];
       [_txt_other becomeFirstResponder];
   }
   else if (textField==_txt_other) {
       [self.view endEditing:YES];
       [_txt_email becomeFirstResponder];
   }else if (textField==_txt_email) {
       [self.view endEditing:YES];
       [_txt_password becomeFirstResponder];
   }else if (textField==_txt_password) {
       [self.view endEditing:YES];
       [_txt_confirm_password becomeFirstResponder];
   }
   else if (textField==_txt_confirm_password) {
       [self.view endEditing:YES];
       [_txt_medical_licence becomeFirstResponder];
   }else if (textField==_txt_medical_licence) {
       [self.view endEditing:YES];
       [_txt_driver_licence becomeFirstResponder];
   }else if (textField==_txt_driver_licence) {
       [self.view endEditing:YES];
       [_txt_car_insurance becomeFirstResponder];
   }else if (textField==_txt_car_insurance) {
       [self.view endEditing:YES];
       [_txt_medical_malpracticeins becomeFirstResponder];
   }else if (textField==_txt_medical_malpracticeins) {
       [self.view endEditing:YES];
       [_txt_bank_name becomeFirstResponder];
   }else if (textField==_txt_bank_name) {
       [self.view endEditing:YES];
       [_txt_acct_number becomeFirstResponder];
   }else if (textField==_txt_acct_number) {
       [self.view endEditing:YES];
       [_txt_routing_no becomeFirstResponder];
   }
  
 
   else{
        [self.view endEditing:YES];
    }
//    // [self.view endEditing:YES];
//    if (textField==_txt_medical_malpracticeins) {
//               [self.view endEditing:YES];
//               [_txt_bank_name becomeFirstResponder];
//           }else if (textField==_txt_bank_name) {
//               [self.view endEditing:YES];
//               [_txt_acct_number becomeFirstResponder];
//           }else if (textField==_txt_acct_number) {
//               [self.view endEditing:YES];
//               [_txt_routing_no becomeFirstResponder];
//           }
//
//           else{
//                [self.view endEditing:YES];
//                }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Cropper Delegate -
- (void)cropViewController:(TOCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle
{

    if([whichImageUpload isEqualToString:@"profile"]){
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
    
    }else if ([whichImageUpload isEqualToString:@"medical_cer"]){
        self.image_medical_certificate.image = image;
        imagedata = UIImageJPEGRepresentation(self.image_medical_certificate.image, 0.5);
        //imagedata=(UIImage *)UIImageJPEGRepresentation(image,1.0f);
        // NSLog(@"image data%@",imagedata);
        
        [self layoutImageView];
        
        // self.navigationItem.rightBarButtonItem.enabled = YES;
        
        CGRect viewFrame = [self.view convertRect:self.image_medical_certificate.frame toView:self.navigationController.view];
        self.image_medical_certificate.hidden = YES;
        [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:viewFrame completion:^{
            self.image_medical_certificate.hidden = NO;
        }];

        
    }
    else if ([whichImageUpload isEqualToString:@"driver_lic"]){
        self.image_driver_licence.image = image;
        imagedata = UIImageJPEGRepresentation(self.image_driver_licence.image, 0.5);
        //imagedata=(UIImage *)UIImageJPEGRepresentation(image,1.0f);
        // NSLog(@"image data%@",imagedata);
        
        [self layoutImageView];
        
        // self.navigationItem.rightBarButtonItem.enabled = YES;
        
        CGRect viewFrame = [self.view convertRect:self.image_driver_licence.frame toView:self.navigationController.view];
        self.image_driver_licence.hidden = YES;
        [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:viewFrame completion:^{
            self.image_driver_licence.hidden = NO;
        }];
        
        
    }
    else if ([whichImageUpload isEqualToString:@"car_ins"]){
        self.image_car_insurance.image = image;
        imagedata = UIImageJPEGRepresentation(self.image_car_insurance.image, 0.5);
        //imagedata=(UIImage *)UIImageJPEGRepresentation(image,1.0f);
        // NSLog(@"image data%@",imagedata);
        
        [self layoutImageView];
        
        // self.navigationItem.rightBarButtonItem.enabled = YES;
        
        CGRect viewFrame = [self.view convertRect:self.image_car_insurance.frame toView:self.navigationController.view];
        self.image_car_insurance.hidden = YES;
        [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:viewFrame completion:^{
            self.image_car_insurance.hidden = NO;
        }];
        
        
    }
    else if ([whichImageUpload isEqualToString:@"medical_mal"]){
        self.image_medical_malpracticens.image = image;
        imagedata = UIImageJPEGRepresentation(self.image_medical_malpracticens.image, 0.5);
        //imagedata=(UIImage *)UIImageJPEGRepresentation(image,1.0f);
        // NSLog(@"image data%@",imagedata);
        
        [self layoutImageView];
        
        // self.navigationItem.rightBarButtonItem.enabled = YES;
        
        CGRect viewFrame = [self.view convertRect:self.image_medical_malpracticens.frame toView:self.navigationController.view];
        self.image_medical_malpracticens.hidden = YES;
        [cropViewController dismissAnimatedFromParentViewController:self withCroppedImage:image toFrame:viewFrame completion:^{
            self.image_medical_malpracticens.hidden = NO;
        }];
        
        
    }
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutImageView];
 [self.myScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+650)];
    self.view_sub_scroll.frame=CGRectMake(self.view_sub_scroll.frame.origin.x, self.view_sub_scroll.frame.origin.y, self.myScrollView.frame.size.width, self.view_sub_scroll.frame.size.height+650);
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
- (IBAction)DidTapProfileImageOpen:(id)sender {
    whichImageUpload=@"profile";
    [self OpenGallery];
}

- (IBAction)didTapUpload_medical_cert:(id)sender {
    whichImageUpload=@"medical_cer";
    [self OpenGallery];
}

- (IBAction)didTapUpload_driver_licence:(id)sender {
    whichImageUpload=@"driver_lic";
    [self OpenGallery];
}

- (IBAction)didTapUpload_car_ins:(id)sender {
    whichImageUpload=@"car_ins";
     [self OpenGallery];
}

- (IBAction)didTapUpload_medical_malpracticens:(id)sender {
    whichImageUpload=@"medical_mal";
    [self OpenGallery];
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

- (IBAction)didTapSelectMedical_speciality:(id)sender {
    IsStateClick=NO;
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Medical Speciality", @"Family Practitioner", @"Internist", @"Pediatrician", @"PA", @"NP", @"DO", @"Podiatrist", @"PT", @"RN",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :DoctorSpecialist :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

}

- (IBAction)didTapSelecteState:(id)sender {
    tap.enabled=NO;
    IsStateClick=YES;
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"Hello 0", @"Hello 1", @"Hello 2", @"Hello 3", @"Hello 4", @"Hello 5", @"Hello 6", @"Hello 7", @"Hello 8", @"Hello 9",nil];
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :arrImage :@"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
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
- (IBAction)didTapGetStateList:(id)sender {
    tap.enabled=NO;
    IsStateClick=YES;
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
-(void)niDropDownDelegateMethod:(NIDropDown *)sender :(NSInteger)IndexNo{
   
    if (IsStateClick==YES) {
        [self rel];
        NSLog(@"%@", _btn_state_list.titleLabel.text);
    }else{
        [self rel];
        NSLog(@"%@", _btn_didTapSelectMedical_speciality.titleLabel.text);
    }
    tap.enabled=YES;
    
    NSLog(@"Selected ==%ld",(long)IndexNo);
    //    NSLog(@"SElected Id %@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"id"]);
    //    SelectedMaterialTypeID = [NSString stringWithFormat:@"%@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"id"]];
    //    NSLog(@"SElected Id %@",[[[ArrayTasktalkMaterials objectAtIndex:IndexNo] valueForKey:@"TaskTalk"] valueForKey:@"title"]);
  
}
- (IBAction)didTapSave:(id)sender {
//  
//    doctor/////////////////
//    fname,lname,dob,ssn,address,city,zip,state,cell,other,email,choosepwd,cnpwd,medlicence,driverlicence,car insurance,medmalpractice,bank name,account no,routing no
//    pateint///////////
//    fname,lname,cell,zip,email,chossepwd,conpwd
    
    NSString *emailString = _txt_email.text;
    NSString *emailRegval = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegval];
    
    if ([_txt_first_name.text isEqualToString:@""] || [_txt_first_name.text length]==0) {
        [_txt_first_name becomeFirstResponder];
        [self AlertShow:@"Please enter first name"];
        
    }
   
    else if ([_txt_last_name.text isEqualToString:@""] || [_txt_last_name.text length]==0) {
        [_txt_last_name becomeFirstResponder];
        [self AlertShow:@"Please enter last name"];
        
    }
    else if ([_txt_date_of_birth.text isEqualToString:@""] || [_txt_date_of_birth.text length]==0) {
        [_txt_date_of_birth becomeFirstResponder];
        [self AlertShow:@"Please enter your date of birth"];
        
    }
    else if ([_txt_address.text isEqualToString:@""] || [_txt_address.text length]==0) {
        [_txt_address becomeFirstResponder];
        [self AlertShow:@"Please enter address"];
        
    }
    else if ([_txt_city.text isEqualToString:@""] || [_txt_city.text length]==0) {
        [_txt_city becomeFirstResponder];
        [self AlertShow:@"Please enter city name"];
        
    }
    else if ([_btn_state_list.titleLabel.text isEqualToString:@"--State--"])  {
        [self AlertShow:@"Please select state"];
        
    }
    else if ([_txt_cell.text isEqualToString:@""] || [_txt_cell.text length]==0)  {
        [_txt_cell becomeFirstResponder];
        [self AlertShow:@"Please  enter cell no"];
        
    }

    else  if (([emailTest evaluateWithObject:emailString] != YES)  || [emailString isEqualToString:@""])
    {
        [_txt_email becomeFirstResponder];
        [self AlertShow:@"Please enter a valid E-mail"];
        
    }
     else if ([_txt_medical_licence.text isEqualToString:@""] || [_txt_medical_licence.text length]==0)
   {
       [_txt_medical_licence becomeFirstResponder];
       [self AlertShow:@"Please  enter medical license no"];
       
   }
   else if ([_txt_driver_licence.text isEqualToString:@""] || [_txt_driver_licence.text length]==0)  {
       [_txt_driver_licence becomeFirstResponder];
       [self AlertShow:@"Please  enter Driver license no"];
       
   }
   else if ([_txt_car_insurance.text isEqualToString:@""] || [_txt_car_insurance.text length]==0)  {
       [_txt_car_insurance becomeFirstResponder];
       [self AlertShow:@"Please  enter car insurance no"];
       
   }
   else if ([_txt_medical_malpracticeins.text isEqualToString:@""] || [_txt_medical_malpracticeins.text length]==0)  {
       [_txt_medical_malpracticeins becomeFirstResponder];
       [self AlertShow:@"Please  enter medical malpracticeins"];
       
   }
   else if ([_txt_bank_name.text isEqualToString:@""] || [_txt_bank_name.text length]==0)  {
       [_txt_bank_name becomeFirstResponder];
       [self AlertShow:@"Please  enter your bank name"];
       
   }
   else if ([_txt_acct_number.text isEqualToString:@""] || [_txt_acct_number.text length]==0)  {
       [_txt_bank_name becomeFirstResponder];
       [self AlertShow:@"Please  enter your bank account no"];
       
   }
   else if ([_txt_routing_no.text isEqualToString:@""] || [_txt_routing_no.text length]==0)  {
       [_txt_routing_no becomeFirstResponder];
       [self AlertShow:@"Please  enter your routing no"];
       
   }
   else if(imagedata==nil){
       [self AlertShow:@"Please upload profile image"];
   }
  
   else{
    NSMutableDictionary *SaveDic=[[NSMutableDictionary alloc]init];
    [SaveDic setValue:_txt_first_name.text forKey:@"fname"];
     [SaveDic setValue:_txt_last_name.text forKey:@"lname"];
     [SaveDic setValue:_txt_email.text forKey:@"email"];
     [SaveDic setValue:_txt_cell.text forKey:@"mobile"];
    [SaveDic setValue:_txt_other.text forKey:@"other"];
    [SaveDic setValue:_txt_address.text forKey:@"addrs"];
    [SaveDic setValue:_btn_state_list.titleLabel.text forKey:@"state"];
    [SaveDic setValue:_txt_city.text forKey:@"city"];
    [SaveDic setValue:_txt_zip.text forKey:@"zipcd"];
    [SaveDic setValue:_txt_password.text forKey:@"psswrd"];
    [SaveDic setValue:_btn_didTapSelectMedical_speciality.titleLabel.text forKey:@"medical_speciality"];
    [SaveDic setValue:_txt_medical_licence.text forKey:@"medical_license"];
    [SaveDic setValue:_txt_driver_licence.text forKey:@"drive_license"];
    [SaveDic setValue:_txt_car_insurance.text forKey:@"car_insurance"];
    [SaveDic setValue:_txt_medical_malpracticeins.text forKey:@"medical_malprac"];
    [SaveDic setValue:_txt_bank_name.text forKey:@"bank"];
    [SaveDic setValue:_txt_acct_number.text forKey:@"b_acc"];
    [SaveDic setValue:@"" forKey:@"gcm_id"];
    [SaveDic setValue:_txt_date_of_birth.text forKey:@"dob"];
    [SaveDic setValue:_txt_routing_no.text forKey:@"routing_no"];
    NSLog(@"Save Dic %@",SaveDic);
       [self uploadPhoto:SaveDic];
   }
    
  }

-(void)uploadPhoto : (NSMutableDictionary *)GetUploadDic{
         
 [self.view endEditing:YES];
    NSArray *array = @[self.image_profile.image,self.image_medical_certificate.image,self.image_driver_licence.image,self.image_car_insurance.image,self.image_medical_malpracticens.image];
    

    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
         //NSLog(@"Business Dict Details %@",businessDic);
         AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://usawebdzines.com/SOS/web_services/ios/"]];
        // NSData *imageData = UIImageJPEGRepresentation(self.image_profile.image, 0.5);
         // NSDictionary *parameters = @{@"username": self.username, @"password" : self.password};
         AFHTTPRequestOperation *op = [manager POST:@"reg_doc.php" parameters:GetUploadDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        
             for(int i=0;i<[array count];i++)
            {
                NSLog(@"current Index %d",i);
                UIImage *eachImage  = [array objectAtIndex:i];
                NSData *imageData = UIImageJPEGRepresentation(eachImage,0.5);
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%d",i+1 ] fileName:[NSString stringWithFormat:@"photo%d.jpg",i+1 ] mimeType:@"image/jpeg"];
           
                
            }

             
         } success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
             NSLog(@"Response object%@",responseObject);
             [SVProgressHUD dismiss];
             [self.view setUserInteractionEnabled:YES];
             [SVProgressHUD dismiss];
             if ([[responseObject valueForKey:@"success"] boolValue]==1) {
                 
                 
                     NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
                     [userdefault setObject:[[responseObject valueForKey:@"detail"] valueForKey:@"id"] forKey:@"user_id"];
                     [userdefault setObject:[[responseObject valueForKey:@"detail"]valueForKey:@"bank_account"] forKey:@"bank_account"];
                     [userdefault setObject:[[responseObject valueForKey:@"detail"]valueForKey:@"email"] forKey:@"email"];
                     
                     [userdefault setObject:@"provider" forKey:@"loggedin_type"];
                     
                     [userdefault synchronize];
                     ProviderDashboardController *gotodashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboardController"];
                     [self.navigationController pushViewController:gotodashboard animated:YES];
                 
             }else{
                 [SVProgressHUD dismiss];
                 
                 [self AlertShow:@"Something Wrong!!"];
                 
                 
             }
             
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@ ***** %@", operation.responseString, error);
         }];
         [op start];
     }

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}
- (IBAction)DidTapdidTapSelectMedical_speciality:(id)sender {
    tap.enabled=NO;
    IsStateClick=NO;
    NSArray * arrImage = [[NSArray alloc] init];
    arrImage = [NSArray arrayWithObjects:[UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], [UIImage imageNamed:@"apple.png"], [UIImage imageNamed:@"apple2.png"], nil];
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :DoctorSpecialist  :arrImage : @"down"];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }

}
@end
