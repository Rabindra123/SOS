//
//  LoginViewController.h
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "AppDelegate.h"
@class AppDelegate;
@interface LoginViewController : UIViewController<UITextFieldDelegate,FBSDKLoginButtonDelegate>{
    NSString *url;
    BOOL isRemember;
}
- (IBAction)didTapFacebookLogin:(id)sender;
@property (strong, nonatomic) IBOutlet FBSDKLoginButton *btnFBLogin;

@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
@property (strong, nonatomic) IBOutlet UIView *view_login_feilds;
- (IBAction)didTapSignIn:(id)sender;
- (IBAction)didTapSignUP:(id)sender;
- (IBAction)didtapRemember:(id)sender;
- (IBAction)didTapForgotpassword:(id)sender;


- (IBAction)didTapBack:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_fb_login;
@property (strong, nonatomic) IBOutlet UIButton *btn_login;
@property (strong, nonatomic) IBOutlet UIImageView *image_checkbox;

@property (strong, nonatomic) IBOutlet UIButton *btn_signUp;
@property (strong,nonatomic)AppDelegate *Mytoken;
@end
