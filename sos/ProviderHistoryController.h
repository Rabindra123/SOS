//
//  ProviderHistoryController.h
//  sos
//
//  Created by Rabi Chourasia on 13/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderHistoryController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *ArrayHistory,*ArraySelctedID;
    NSString *SelectedID;
}
@property (weak, nonatomic) IBOutlet UILabel *lbl_provider_name;
@property (weak, nonatomic) IBOutlet UITableView *table_history;
@property (strong, nonatomic) IBOutlet UIView *view_pop;
@property (strong, nonatomic) IBOutlet UIView *view_pop_details;

- (IBAction)didTapBack:(id)sender;
- (IBAction)didTappopClose:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_symptoms;
@property (strong, nonatomic) IBOutlet UILabel *lbl_age;
@property (strong, nonatomic) IBOutlet UILabel *lbl_additional;
@property (strong, nonatomic) IBOutlet UIButton *btn_movetoArchive;

- (IBAction)DidTapGotoArchive:(id)sender;
- (IBAction)didTapMoveToArchive:(id)sender;

@end
