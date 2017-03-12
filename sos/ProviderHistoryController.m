//
//  ProviderHistoryController.m
//  sos
//
//  Created by Rabi Chourasia on 13/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ProviderHistoryController.h"

@interface ProviderHistoryController ()

@end

@implementation ProviderHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table_history.delegate=self;
    self.table_history.dataSource=self;
    // Do any additional setup after loading the view.
    [self ShowHistoryList];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)ShowHistoryList{
    NSMutableDictionary *hisDic = [[NSMutableDictionary alloc]init];
    ArraySelctedID = [[NSMutableArray alloc]init];
    [hisDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    [self ShowSavedCard:hisDic];
    [self viewCorner:_view_pop_details];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewCorner : (UIView *)MyView{
   
   
    MyView.layer.cornerRadius = 10.0; // set cornerRadius as you want.
    MyView.layer.masksToBounds = YES;
    MyView.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    MyView.layer.borderWidth = 1.0; // set borderWidth as you want.
  
}

-(void)ShowSavedCard : (NSMutableDictionary *)Param{
    
     [self.view endEditing:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/patient_history.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
                  if ([[responseObject valueForKey:@"success"]  boolValue]==1) {
         ArrayHistory = [[NSMutableArray alloc]initWithArray:[responseObject valueForKey:@"details"]];
         if ([ArrayHistory count]>0) {
             [self.table_history reloadData];
         }
                  }
//         if ([[[responseObject valueForKey:@"details"] valueForKey:@"card found"] boolValue]==1) {
//             
//            
//             
//         }else{
//             
//             
//             [self AlertShow:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]]];
//         }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
-(void)AlertShow : (NSString *)GetMsg{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error Message"
                                 message:GetMsg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:yesButton];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ArrayHistory count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryCell *cell =[self.table_history dequeueReusableCellWithIdentifier:@"HistoryCell"];
    if (cell==nil) {
        
    }
    [cell.image_check setImage:[UIImage imageNamed: @"unchecked.png"]];
    cell.lbl_Doctor_heading.text= [NSString stringWithFormat:@"%@",[[ArrayHistory objectAtIndex:indexPath.row] valueForKey:@"name"]];
     cell.lbl_patient_details.text= @"Patient Additional Details";
     cell.lbl_status.text= @"Status Completed";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.btn_show_additional_details.tag=indexPath.row;
    [cell.btn_show_additional_details addTarget:self action:@selector(pushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    cell.btn_select_check.tag=indexPath.row;
//    [cell.btn_select_check addTarget:self action:@selector(DidtapSelectedIdToMoveArchive:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
   HistoryCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SelectedID=[NSString stringWithFormat:@"%@",[[ArrayHistory objectAtIndex:indexPath.row] valueForKey:@"book_id"]];
    
    
    if ([ArraySelctedID containsObject:SelectedID]) {
        
        
        [ArraySelctedID removeObject:SelectedID];
        
        [cell.image_check setImage:[UIImage imageNamed: @"unchecked.png"]];
        if ([ArraySelctedID count]>0) {
            [_btn_movetoArchive setHidden:NO];
        }else{
            [_btn_movetoArchive setHidden:YES];
        }
        
    }else{
        [ArraySelctedID addObject:SelectedID];
        [cell.image_check setImage:[UIImage imageNamed: @"checked.png"]];
        if ([ArraySelctedID count]>0) {
            [_btn_movetoArchive setHidden:NO];
        }else{
            [_btn_movetoArchive setHidden:YES];
        }
    }
    NSLog(@"Array Selected IDS=%@",ArraySelctedID);
}
-(void)DidtapSelectedIdToMoveArchive : (UIButton *)sender{
    //book_id
    static NSString *simpleTableIdentifier = @"HistoryCell";
   // HistoryCell *cell = (HistoryCell *)[self.table_history dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    NSLog(@"Selected %@",[ArrayHistory objectAtIndex:sender.tag]);
   
   SelectedID=[NSString stringWithFormat:@"%@",[[ArrayHistory objectAtIndex:sender.tag] valueForKey:@"book_id"]];
    
    
    if ([ArraySelctedID containsObject:SelectedID]) {
       
        
        [ArraySelctedID removeObject:SelectedID];
       
          //[cell.image_check setImage:[UIImage imageNamed: @"unchecked.png"]];
        if ([ArraySelctedID count]>0) {
            [_btn_movetoArchive setHidden:NO];
        }else{
             [_btn_movetoArchive setHidden:YES];
        }
        
    }else{
        [ArraySelctedID addObject:SelectedID];
       //  [cell.image_check setImage:[UIImage imageNamed: @"checked.png"]];
        if ([ArraySelctedID count]>0) {
            [_btn_movetoArchive setHidden:NO];
        }else{
            [_btn_movetoArchive setHidden:YES];
        }
    }
    NSLog(@"Array Selected IDS=%@",ArraySelctedID);
}
-(void)pushButtonClicked:(UIButton*)sender
{
    [_view_pop setHidden:NO];
    [_view_pop_details setHidden:NO];
    _lbl_symptoms.text=[NSString stringWithFormat:@"Symptoms:  %@",[[ArrayHistory objectAtIndex:sender.tag] valueForKey:@"symptom1"]];
    _lbl_age.text=[NSString stringWithFormat:@"Age:  %@",[[ArrayHistory objectAtIndex:sender.tag] valueForKey:@"age"]];
    _lbl_additional.text=[NSString stringWithFormat:@"Additional:  %@",[[ArrayHistory objectAtIndex:sender.tag] valueForKey:@"symptom2"]];
    //_lbl_symptoms
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapBack:(id)sender {
  //  [self.navigationController popViewControllerAnimated:YES];
    ProviderDashboardController *gotoDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboardController"];
    [self.navigationController pushViewController:gotoDashboard animated:YES];
    
}

- (IBAction)didTappopClose:(id)sender {
    [_view_pop setHidden:YES];
    [_view_pop_details setHidden:YES];
}
- (IBAction)DidTapGotoArchive:(id)sender {
    ArchiveController *gotoArchive =[self.storyboard instantiateViewControllerWithIdentifier:@"ArchiveController"];
    [self.navigationController pushViewController:gotoArchive animated:YES];
}

- (IBAction)didTapMoveToArchive:(id)sender {
    NSString *joinedString = [ArraySelctedID componentsJoinedByString:@","];
    NSMutableDictionary *MoveArchiveDic=[[NSMutableDictionary alloc]init];
    [MoveArchiveDic setValue:joinedString forKey:@"book_id"];
    NSLog(@"Move To Archive Dic%@",MoveArchiveDic);
    [self MoveToArchive:MoveArchiveDic];
                                         
    
}

-(void)MoveToArchive : (NSMutableDictionary *)Param{
    
    [_btn_movetoArchive setHidden:YES];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/del_history.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         [self ShowHistoryList];
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}

@end
