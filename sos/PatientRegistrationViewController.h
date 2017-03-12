//
//  PatientRegistrationViewController.h
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientRegistrationViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,TOCropViewControllerDelegate>{
    NSData *imagedata;
    UITapGestureRecognizer *tap;
}
@property (strong, nonatomic) IBOutlet UITextField *txt_first_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_last_name;
@property (strong, nonatomic) IBOutlet UITextField *txt_phone;
@property (strong, nonatomic) IBOutlet UITextField *txt_zip;
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
@property (strong, nonatomic) IBOutlet UITextField *txt_confirm_password;
- (IBAction)didTabGalleryOpen:(id)sender;
- (IBAction)didTapSave:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *image_profile;
- (IBAction)didTapBack:(id)sender;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@end
