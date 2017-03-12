//
//  ConfirmCell.h
//  sos
//
//  Created by Rabi Chourasia on 01/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_patient_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_patient_address;
@property (weak, nonatomic) IBOutlet UILabel *lbl_patient_problem;
@property (weak, nonatomic) IBOutlet UIView *view_confirm;
@property (weak, nonatomic) IBOutlet UIButton *btn15;
@property (weak, nonatomic) IBOutlet UIButton *btn_30;
@property (weak, nonatomic) IBOutlet UIButton *btn_45;
@property (weak, nonatomic) IBOutlet UIButton *btn_1hr;
@property (weak, nonatomic) IBOutlet UIButton *btn_130hr;
@property (weak, nonatomic) IBOutlet UIButton *btn_2hr;
@property (weak, nonatomic) IBOutlet UITextField *txt_fee;
@property (weak, nonatomic) IBOutlet UIButton *btn_set_fee;
@property (weak, nonatomic) IBOutlet UIButton *btn_confirn;
@property (weak, nonatomic) IBOutlet UIButton *btn_decline;
@property (weak, nonatomic) IBOutlet UIView *view_time;

@end
