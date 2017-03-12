//
//  DoctroProfileController.h
//  sos
//
//  Created by Rabi Chourasia on 18/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
@interface DoctroProfileController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,TOCropViewControllerDelegate,NIDropDownDelegate>{
     NSData *imagedata;
    NSArray *ArrayState;
     NIDropDown *dropDown;
}
-(void)rel;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollview;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *txt_fname;
@property (weak, nonatomic) IBOutlet UITextField *txt_lname;
@property (weak, nonatomic) IBOutlet UITextField *txt_state;
@property (weak, nonatomic) IBOutlet UITextField *txt_address;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_bank_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_account_numer;
@property (weak, nonatomic) IBOutlet UITextField *txt_routing_no;
@property (weak, nonatomic) IBOutlet UITextField *txt_add_home;
@property (weak, nonatomic) IBOutlet UITextField *txt_work;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_confirm_password;
@property (weak, nonatomic) IBOutlet UITextField *txt_cell;
@property (weak, nonatomic) IBOutlet UITextField *txt_other;
@property (weak, nonatomic) IBOutlet UITextField *txt_zip;
@property (weak, nonatomic) IBOutlet UIImageView *image_profile;
- (IBAction)didTapOpenGallery:(id)sender;
- (IBAction)didTapBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_state;
- (IBAction)didTapSelectState:(id)sender;

- (IBAction)DidTapSave:(id)sender;
@end
