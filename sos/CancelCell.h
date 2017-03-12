//
//  CancelCell.h
//  sos
//
//  Created by Rabi Chourasia on 01/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CancelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_cancel_patient_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_cancel_cardNO;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end
