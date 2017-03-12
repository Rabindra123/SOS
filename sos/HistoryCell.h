//
//  HistoryCell.h
//  sos
//
//  Created by Rabi Chourasia on 13/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_Doctor_heading;
@property (weak, nonatomic) IBOutlet UILabel *lbl_patient_details;
@property (weak, nonatomic) IBOutlet UILabel *lbl_status;
@property (strong, nonatomic) IBOutlet UIImageView *image_check;
@property (strong, nonatomic) IBOutlet UIButton *btn_select_check;

@property (weak, nonatomic) IBOutlet UIButton *btn_show_additional_details;
@end
