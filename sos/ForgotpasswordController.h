//
//  ForgotpasswordController.h
//  sos
//
//  Created by Rabi Chourasia on 10/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotpasswordController : UIViewController<UITextFieldDelegate>{
    NSString *LoginType;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_email;
- (IBAction)DidTapBack:(id)sender;
- (IBAction)didTapSubmit:(id)sender;

@end
