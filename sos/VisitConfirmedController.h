//
//  VisitConfirmedController.h
//  sos
//
//  Created by Rabi Chourasia on 26/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface VisitConfirmedController : UIViewController<MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbl_confirmed_title;
- (IBAction)didTapSendSms:(id)sender;
- (IBAction)didTapGotoHome:(id)sender;

@end
