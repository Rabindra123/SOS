//
//  DoctorAcceptRquestController.h
//  sos
//
//  Created by Rabi Chourasia on 26/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorAcceptRquestController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    NSMutableArray *ArrayNotification;
    NSString *SetTime;
    BOOL IsSetFeeUpdate;
}
- (IBAction)didTapBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table_notification;

@end
