//
//  ProviderLoginViewController.h
//  sos
//
//  Created by Rabi Chourasia on 06/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class AppDelegate;
@interface ProviderLoginViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>{
    NSString *url;
    CLLocationManager *locationManager;
    NSString *LatLong;
     BOOL isRemember;
}
@property (strong,nonatomic)AppDelegate *Mytoken;
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;

- (IBAction)didTapRememberPassword:(id)sender;
- (IBAction)didTapForgotPassword:(id)sender;
- (IBAction)didTapLogin:(id)sender;
- (IBAction)didTapSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_login_field;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet UIButton *btn_signup;
- (IBAction)didTapBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image_checkbox;

@end
