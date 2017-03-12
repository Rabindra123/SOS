//
//  CardDetailsController.h
//  sos
//
//  Created by Rabi Chourasia on 12/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKCardNumberField.h"
#import "BKCardExpiryField.h"
@interface CardDetailsController : UIViewController<UITextFieldDelegate>{
    UITapGestureRecognizer *tap;
}
@property (weak, nonatomic) IBOutlet BKCardNumberField *cardNumberField;
@property (weak, nonatomic) IBOutlet BKCardExpiryField *cardExpiryField;
@property (weak, nonatomic) IBOutlet UITextField *txt_cardholder_name;
@property (weak, nonatomic) IBOutlet UITextField *txt_cvv;
@property (weak, nonatomic) IBOutlet UIButton *btn_done;
@property (nonatomic,assign)BOOL ISCardAdd;
- (IBAction)didTapDone:(id)sender;
- (IBAction)didTapBack:(id)sender;

@end
