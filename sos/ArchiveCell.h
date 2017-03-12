//
//  ArchiveCell.h
//  sos
//
//  Created by Alok Das on 01/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchiveCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl_patient_name;
@property (strong, nonatomic) IBOutlet UILabel *lbl_patient_info;
@property (strong, nonatomic) IBOutlet UILabel *lbl_status;
@property (strong, nonatomic) IBOutlet UIButton *btn_show_details;

@end
