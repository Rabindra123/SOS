//
//  PatientPaymentViewController.h
//  sos
//
//  Created by Rabi Chourasia on 08/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
@interface PatientPaymentViewController : UIViewController<SlideNavigationControllerDelegate>
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapAddCard:(id)sender;
- (IBAction)didTapEditCard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit_card;
@property (weak, nonatomic) IBOutlet UILabel *lbl_cardNo;


@end
