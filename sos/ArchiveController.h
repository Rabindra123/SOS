//
//  ArchiveController.h
//  sos
//
//  Created by Alok Das on 01/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchiveController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *ArrayArchiveList;
}
- (IBAction)didTapBack:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_DoctorName;
@property (strong, nonatomic) IBOutlet UITableView *table_archive;
@property (strong, nonatomic) IBOutlet UIView *view_main_pop;
- (IBAction)didTapPopClose:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_sub_pop;
@property (strong, nonatomic) IBOutlet UILabel *lbl_symptom;
@property (strong, nonatomic) IBOutlet UILabel *lbl_age;
@property (strong, nonatomic) IBOutlet UILabel *lbl_info;

@end
