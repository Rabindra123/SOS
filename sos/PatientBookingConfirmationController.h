//
//  PatientBookingConfirmationController.h
//  sos
//
//  Created by Rabi Chourasia on 22/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "RateView.h"
@interface PatientBookingConfirmationController : UIViewController<RateViewDelegate,SlideNavigationControllerDelegate>{
    NSString *book_id;
    NSTimer *timerCheck;
}
- (IBAction)didTapOpenMenu:(id)sender;
@property (strong,nonatomic)NSString *getBookID;
@property (weak, nonatomic) IBOutlet UILabel *lbl_thankyou;
@property (weak, nonatomic) IBOutlet UILabel *lbl_try_again;
@property (weak, nonatomic) IBOutlet UIView *view_doctor_confirmed;
@property (weak, nonatomic) IBOutlet UIImageView *image_doctor;
@property (weak, nonatomic) IBOutlet RateView *doctorRateviewShow;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doctor_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doctor_specialist;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doctor_licence;
@property (weak, nonatomic) IBOutlet UILabel *lbl_no;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doctor_visiting_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doctor_visiting_fee;
- (IBAction)didTapAccept:(id)sender;
- (IBAction)didTapCancel:(id)sender;
- (IBAction)didTapHome:(id)sender;

@end
