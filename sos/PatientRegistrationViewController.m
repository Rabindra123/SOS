//
//  PatientRegistrationViewController.m
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "PatientRegistrationViewController.h"

@interface PatientRegistrationViewController ()

@end

@implementation PatientRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _txt_email.delegate=self;
    [self DoneKeyboard];
    [self tapGesture];
    
    // Do any additional setup after loading the view.
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
    _txt_phone.inputAccessoryView = numberToolbar;
    _txt_zip.inputAccessoryView = numberToolbar;
    
}


-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==_txt_first_name) {
        [_txt_last_name becomeFirstResponder];
        
    }else if (textField==_txt_last_name){
        [_txt_phone becomeFirstResponder];
    }
    else if (textField==_txt_phone){
        [_txt_zip becomeFirstResponder];
    }
    else if (textField==_txt_zip){
        [_txt_email becomeFirstResponder];
    }
    else if (textField==_txt_email){
        [_txt_password becomeFirstResponder];
    }
    else if (textField==_txt_password){
        [_txt_confirm_password becomeFirstResponder];
    }
    


    [textField resignFirstResponder];
    return YES;
}

-(void)tapGesture{
    
    tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard{
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
    if(textField ==_txt_zip || textField ==_txt_email || textField == _txt_password || textField == _txt_confirm_password){
        const int movementDistance = -90; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? movementDistance : -movementDistance);
        
        [UIView beginAnimations: @"animateTextField" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        [UIView commitAnimations];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField==_txt_zip) {
        
        int length = [self getLength:_txt_zip.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 5)
        {
            if(range.length == 0)
                return NO;
        }
    }
    
    if (textField==_txt_phone) {
        int length = [self getLength:_txt_phone.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:_txt_phone.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:_txt_phone.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
        
    }
    return YES;
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




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)didTabGalleryOpen:(id)sender {
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


- (IBAction)didTapSave:(id)sender {
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
    else if ([_txt_phone.text length] < 10){
        [_txt_phone becomeFirstResponder];
        [self AlertShow:@"Please enter a valid phone no."];
        
    }
    else if ([_txt_zip.text length] < 5){
        [_txt_zip becomeFirstResponder];
        [self AlertShow:@"Please enter a valid zip code"];
        
    }
    
    else  if (([emailTest evaluateWithObject:emailString] != YES)  || [emailString isEqualToString:@""])
    {
        [_txt_email becomeFirstResponder];
        [self AlertShow:@"Please enter a valid E-mail"];
        
        
        
    }
    else if([_txt_password.text isEqualToString:@"" ])
    {
        [_txt_password becomeFirstResponder];
        [_txt_password becomeFirstResponder];
        [self AlertShow:@"Please enter password"];
        
        
    }
    else if([_txt_confirm_password.text isEqualToString:@"" ])
    {
        [_txt_confirm_password becomeFirstResponder];
        [_txt_password becomeFirstResponder];
        [self AlertShow:@"Please enter confirm password"];
        
        
    }
    else if(![_txt_password.text isEqualToString:_txt_confirm_password.text ])
    {
        [_txt_password becomeFirstResponder];
        [self AlertShow:@"password and confirm password does not match!"];
        
        
    }
    else if(imagedata==nil){
          [self AlertShow:@"Please upload profile image!"];
    }
    
    
    else{
        
        NSMutableDictionary *uploadDic = [[NSMutableDictionary alloc]init];
        [uploadDic setValue:_txt_first_name.text forKey:@"fname"];
        [uploadDic setValue:_txt_last_name.text forKey:@"lname"];
        [uploadDic setValue:_txt_email.text forKey:@"email"];
        [uploadDic setValue:_txt_phone.text forKey:@"mobile"];
        [uploadDic setValue:_txt_zip.text forKey:@"zipcd"];
        [uploadDic setValue:_txt_password.text forKey:@"psswrd"];
        NSLog(@"Reg Dic %@",uploadDic);
        [self uploadPhoto:uploadDic];
    }
    
}
- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)uploadPhoto : (NSMutableDictionary *)GetUploadDic{
    [self.view endEditing:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    //NSLog(@"Business Dict Details %@",businessDic);
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://usawebdzines.com/SOS/web_services/ios/"]];
    NSData *imageData = UIImageJPEGRepresentation(self.image_profile.image, 0.5);
    // NSDictionary *parameters = @{@"username": self.username, @"password" : self.password};
    AFHTTPRequestOperation *op = [manager POST:@"reg_patient.php" parameters:GetUploadDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"uploaded_file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        NSLog(@"Response object%@",responseObject);
        [SVProgressHUD dismiss];
        [self.view setUserInteractionEnabled:YES];
        [SVProgressHUD dismiss];
        if ([[responseObject valueForKey:@"success"] boolValue]==1) {
            
            
            NSUserDefaults *userDetails=[NSUserDefaults standardUserDefaults];
            [userDetails setObject:[responseObject valueForKey:@"id"] forKey:@"user_id"];
            [userDetails setObject:[responseObject valueForKey:@"email"] forKey:@"email"];
            [userDetails setObject:@"patient" forKey:@"loggedin_type"];

            [userDetails synchronize];
            PatientDashboardController *gotoDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
            
            [self.navigationController pushViewController:gotoDashboard animated:YES];
            
            
        }else{
            [SVProgressHUD dismiss];
            
            [self AlertShow:[responseObject valueForKey:@"message"]];
            
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [op start];
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
