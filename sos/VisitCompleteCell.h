//
//  VisitCompleteCell.h
//  sos
//
//  Created by Rabi Chourasia on 01/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitCompleteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_complete_patient_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_complete_patient_address;
@property (weak, nonatomic) IBOutlet UILabel *lbl_complete_patient_probelm;
@property (weak, nonatomic) IBOutlet UILabel *lbl_complete_patient_age;
@property (weak, nonatomic) IBOutlet UIButton *btn_visit_complete;
@property (weak, nonatomic) IBOutlet UIButton *btn_complte_patient_location_show;

@end
