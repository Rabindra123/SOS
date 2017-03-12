//
//  ProviderRegistrationViewController.h
//  sos
//
//  Created by Alok Das on 06/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface ProviderRegistrationViewController  : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,TOCropViewControllerDelegate,UIScrollViewDelegate,NIDropDownDelegate>{
    NSData *imagedata;
    UITapGestureRecognizer *tap;
    NSString *whichImageUpload;
     NIDropDown *dropDown;
    BOOL IsStateClick;
    NSArray *ArrayState,*DoctorSpecialist;
    UIDatePicker *datePicker;
}
-(void)rel;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;

- (IBAction)didTapBack:(id)sender;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIImageView *image_profile;
@property (strong, nonatomic) IBOutlet UIImageView *image_medical_certificate;
@property (strong, nonatomic) IBOutlet UIImageView *image_driver_licence;
@property (strong, nonatomic) IBOutlet UIImageView *image_car_insurance;

@property (strong, nonatomic) IBOutlet UIImageView *image_medical_malpracticens;

- (IBAction)DidTapProfileImageOpen:(id)sender;
- (IBAction)didTapUpload_medical_cert:(id)sender;
- (IBAction)didTapUpload_driver_licence:(id)sender;
- (IBAction)didTapUpload_car_ins:(id)sender;
- (IBAction)didTapUpload_medical_malpracticens:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txt_first_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_last_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_date_of_birth;
@property (weak, nonatomic) IBOutlet UITextField *txt_ssn;
@property (weak, nonatomic) IBOutlet UITextField *txt_city;
@property (weak, nonatomic) IBOutlet UITextField *txt_cell;
@property (weak, nonatomic) IBOutlet UITextField *txt_zip;
@property (weak, nonatomic) IBOutlet UITextField *txt_other;
@property (weak, nonatomic) IBOutlet UITextField *txt_address;
@property (weak, nonatomic) IBOutlet UILabel *lbl_state;

@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_confirm_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_medical_licence;

@property (weak, nonatomic) IBOutlet UITextField *txt_driver_licence;
@property (weak, nonatomic) IBOutlet UITextField *txt_car_insurance;
@property (weak, nonatomic) IBOutlet UITextField *txt_medical_malpracticeins;
@property (weak, nonatomic) IBOutlet UITextField *txt_bank_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_acct_number;
@property (weak, nonatomic) IBOutlet UITextField *txt_routing_no;
@property (weak, nonatomic) IBOutlet UIView *view_sub_scroll;

@property (strong, nonatomic) IBOutlet UIButton *btn_state_list;
- (IBAction)didTapGetStateList:(id)sender;

- (IBAction)didTapSave:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn_didTapSelectMedical_speciality;
- (IBAction)DidTapdidTapSelectMedical_speciality:(id)sender;

@end
