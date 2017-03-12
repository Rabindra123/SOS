//
//  DoctorRatingController.h
//  sos
//
//  Created by Rabi Chourasia on 16/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
@interface DoctorRatingController : UIViewController<RateViewDelegate>
@property (strong, nonatomic) IBOutlet RateView *myRateview;
@property (weak, nonatomic) IBOutlet UILabel *lbl_amount;
@property (weak, nonatomic) IBOutlet UILabel *lbl_card_no;
@property (weak, nonatomic) IBOutlet UILabel *lbl_doctor_name;

@property (weak, nonatomic) IBOutlet UILabel *lbl_date;
@property (weak, nonatomic) IBOutlet UIImageView *image_doctor;
- (IBAction)didTapSubmit:(id)sender;
@end
