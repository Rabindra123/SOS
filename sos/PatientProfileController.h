//
//  PatientProfileController.h
//  sos
//
//  Created by Rabi Chourasia on 16/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+AFNetworking.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "NIDropDown.h"
#import "BKCardNumberField.h"
#import "BKCardExpiryField.h"
@interface PatientProfileController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,TOCropViewControllerDelegate,NIDropDownDelegate>{
     NSData *imagedata;
    NIDropDown *dropDown;
    NSArray *ArrayState;
}
-(void)rel;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (weak, nonatomic) IBOutlet UITextField *txt_fname;
@property (weak, nonatomic) IBOutlet UITextField *txt_lname;
@property (weak, nonatomic) IBOutlet UITextField *txt_state;
@property (weak, nonatomic) IBOutlet UITextField *txt_address;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_paypal_account;

@property (weak, nonatomic) IBOutlet UITextField *txt_card_holder_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_cvv;
@property (weak, nonatomic) IBOutlet BKCardNumberField *txt_credit_card_no;


@property (weak, nonatomic) IBOutlet BKCardExpiryField *txt_mm_yy;

@property (weak, nonatomic) IBOutlet UITextField *txt_add_home;
@property (weak, nonatomic) IBOutlet UITextField *txt_add_work;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
@property (weak, nonatomic) IBOutlet UITextField *confirm_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_cell;
@property (weak, nonatomic) IBOutlet UITextField *txt_other;
@property (weak, nonatomic) IBOutlet UITextField *txt_zip;
@property (weak, nonatomic) IBOutlet UIImageView *image_profile;
- (IBAction)didTapOpenCamera:(id)sender;
- (IBAction)DidTapSave:(id)sender;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
- (IBAction)didTapBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_state;
- (IBAction)DidTapSelectState:(id)sender;


@end
