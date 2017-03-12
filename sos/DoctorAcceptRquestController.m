//
//  DoctorAcceptRquestController.m
//  sos
//
//  Created by Rabi Chourasia on 26/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "DoctorAcceptRquestController.h"

@interface DoctorAcceptRquestController ()

@end

@implementation DoctorAcceptRquestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table_notification.delegate=self;
    self.table_notification.dataSource=self;
    // Do any additional setup after loading the view.
    [self ShowNotificationList];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)ShowNotificationList{
    NSMutableDictionary *hisDic = [[NSMutableDictionary alloc]init];
    ArrayNotification = [[NSMutableArray alloc]init];
    [hisDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    [self ShowDoctorNotificationList:hisDic];
   }
-(void)ShowDoctorNotificationList : (NSMutableDictionary *)Param{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/doc_notification.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         ArrayNotification = [[NSMutableArray alloc]initWithArray:[responseObject valueForKey:@"details"]];
         NSLog(@"Array Details%@",ArrayNotification);
         if ([ArrayNotification count]>0) {
             [self.table_notification reloadData];
         }
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
     return [ArrayNotification count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"requset_status"] isEqualToString:@"set_fees"])
    {
        ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
        cell.txt_fee.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"fees"]];
      
        cell.txt_fee.layer.borderWidth = 2.0f;
        cell.txt_fee.layer.borderColor = [[UIColor blackColor] CGColor];
        cell.txt_fee.layer.cornerRadius = 5;
        cell.txt_fee.clipsToBounds      = YES;
        
        if (![[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"fees"]] isEqualToString:@""]) {
           
            //[cell.txt_fee.ed=NO];
          //  cell.txt_fee.editable = NO;
           // [cell.btn_confirn setHidden:NO];
           [cell.btn_set_fee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             [cell.btn_confirn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             cell.btn_set_fee.backgroundColor = [UIColor lightGrayColor];
            [cell.btn_set_fee setUserInteractionEnabled:NO];
          
             cell.btn_confirn.backgroundColor = [UIColor colorWithRed:71.0/255.0f green:141.0/255.0f blue:45.0/255.0f alpha:1.0];
             [cell.txt_fee setUserInteractionEnabled:NO];
            [cell.btn_confirn setUserInteractionEnabled:YES];
        }else{
            [cell.btn_set_fee setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cell.btn_confirn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             cell.btn_set_fee.backgroundColor = [UIColor colorWithRed:71.0/255.0f green:141.0/255.0f blue:45.0/255.0f alpha:1.0];
            cell.btn_confirn.backgroundColor=[UIColor lightGrayColor];
              [cell.txt_fee setUserInteractionEnabled:YES];
             [cell.btn_set_fee setUserInteractionEnabled:YES];
             [cell.btn_confirn setUserInteractionEnabled:YES];
            
            cell.btn_set_fee.tag=indexPath.row;
            [cell.btn_set_fee addTarget:self action:@selector(DidTapSetFees:) forControlEvents:UIControlEventTouchUpInside];
              [cell.btn_confirn setUserInteractionEnabled:NO];
        }
        
        [cell.view_time.layer setCornerRadius:15.0f];
        [cell.view_time.layer setMasksToBounds:YES];
        if ([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"response"] isEqualToString:@"15 min"]) {
            cell.btn15.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
            cell.btn_30.backgroundColor=[UIColor clearColor];
            cell.btn_45.backgroundColor=[UIColor clearColor];
            cell.btn_1hr.backgroundColor=[UIColor clearColor];
            cell.btn_130hr.backgroundColor=[UIColor clearColor];
            cell.btn_2hr.backgroundColor=[UIColor clearColor];
            
        }
         if([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"response"] isEqualToString:@"30 min"]){
            cell.btn_30.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
            cell.btn15.backgroundColor=[UIColor clearColor];
            cell.btn_45.backgroundColor=[UIColor clearColor];
            cell.btn_1hr.backgroundColor=[UIColor clearColor];
            cell.btn_130hr.backgroundColor=[UIColor clearColor];
            cell.btn_2hr.backgroundColor=[UIColor clearColor];
        }
         if([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"response"] isEqualToString:@"45 min"]){
            cell.btn_45.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
            cell.btn_30.backgroundColor=[UIColor clearColor];
            cell.btn15.backgroundColor=[UIColor clearColor];
            cell.btn_1hr.backgroundColor=[UIColor clearColor];
            cell.btn_130hr.backgroundColor=[UIColor clearColor];
            cell.btn_2hr.backgroundColor=[UIColor clearColor];
        }
         if([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"response"] isEqualToString:@"1 hr"]){
            cell.btn_1hr.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
            cell.btn_30.backgroundColor=[UIColor clearColor];
            cell.btn_45.backgroundColor=[UIColor clearColor];
            cell.btn15.backgroundColor=[UIColor clearColor];
            cell.btn_130hr.backgroundColor=[UIColor clearColor];
            cell.btn_2hr.backgroundColor=[UIColor clearColor];
        }
         if([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"response"] isEqualToString:@"1:30 min"]){
            cell.btn_130hr.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
            cell.btn_30.backgroundColor=[UIColor clearColor];
            cell.btn_45.backgroundColor=[UIColor clearColor];
            cell.btn_1hr.backgroundColor=[UIColor clearColor];
            cell.btn15.backgroundColor=[UIColor clearColor];
            cell.btn_2hr.backgroundColor=[UIColor clearColor];
        }
         if([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"response"] isEqualToString:@"2 hr"]){
            cell.btn_2hr.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
            cell.btn_30.backgroundColor=[UIColor clearColor];
            cell.btn_45.backgroundColor=[UIColor clearColor];
            cell.btn_1hr.backgroundColor=[UIColor clearColor];
            cell.btn_130hr.backgroundColor=[UIColor clearColor];
            cell.btn15.backgroundColor=[UIColor clearColor];
        }


        
    cell.lbl_patient_name.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"name"]];
    cell.lbl_patient_address.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"location"]];
    cell.lbl_patient_problem.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"symptom1"]];
        cell.btn_confirn.tag=indexPath.row;
        [cell.btn_confirn addTarget:self action:@selector(DidTapConfirm:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn_decline.tag=indexPath.row;
        [cell.btn_decline addTarget:self action:@selector(DidTapDecline:) forControlEvents:UIControlEventTouchUpInside];
        
        
        cell.btn15.tag=indexPath.row;
        [cell.btn15 addTarget:self action:@selector(DidTapSet15Min:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_30.tag=indexPath.row;
        [cell.btn_30 addTarget:self action:@selector(DidTapSet30Min:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_45.tag=indexPath.row;
        [cell.btn_45 addTarget:self action:@selector(DidTapSet45Min:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_1hr.tag=indexPath.row;
        [cell.btn_1hr addTarget:self action:@selector(DidTapSet1Hr:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_130hr.tag=indexPath.row;
        [cell.btn_130hr addTarget:self action:@selector(DidTapSet130Hr:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_2hr.tag=indexPath.row;
        [cell.btn_2hr addTarget:self action:@selector(DidTapSet2HR:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.txt_fee.delegate=(id)self;
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
        [numberToolbar sizeToFit];
        
        cell.txt_fee.inputAccessoryView = numberToolbar;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return  cell;
    }
    else{
        VisitCompleteCell *cell =[self.table_notification dequeueReusableCellWithIdentifier:@"VisitCompleteCell"];
        cell.lbl_complete_patient_name.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"name"]];
        cell.lbl_complete_patient_age.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"age"]];
        cell.lbl_complete_patient_address.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"location"]];
        cell.lbl_complete_patient_probelm.text=[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"symptom1"]];
        cell.btn_visit_complete.tag=indexPath.row;
        [cell.btn_visit_complete addTarget:self action:@selector(DidTapVisitComplete:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
       // cell.lbl
    
        return  cell;
    
    }
}

-(void)DidTapSet15Min : (UIButton *) sender{
    //ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    cell.btn15.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
    cell.btn_30.backgroundColor=[UIColor clearColor];
    cell.btn_45.backgroundColor=[UIColor clearColor];
    cell.btn_1hr.backgroundColor=[UIColor clearColor];
    cell.btn_130hr.backgroundColor=[UIColor clearColor];
    cell.btn_2hr.backgroundColor=[UIColor clearColor];
    SetTime=@"15 min";
}


-(void)DidTapSet30Min : (UIButton *) sender{
    //ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    cell.btn_30.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
    cell.btn15.backgroundColor=[UIColor clearColor];
    cell.btn_45.backgroundColor=[UIColor clearColor];
    cell.btn_1hr.backgroundColor=[UIColor clearColor];
    cell.btn_130hr.backgroundColor=[UIColor clearColor];
    cell.btn_2hr.backgroundColor=[UIColor clearColor];
    SetTime=@"30 min";
    
}

-(void)DidTapSet45Min : (UIButton *) sender{
    //ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    cell.btn_45.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
    cell.btn_30.backgroundColor=[UIColor clearColor];
    cell.btn15.backgroundColor=[UIColor clearColor];
    cell.btn_1hr.backgroundColor=[UIColor clearColor];
    cell.btn_130hr.backgroundColor=[UIColor clearColor];
    cell.btn_2hr.backgroundColor=[UIColor clearColor];
    SetTime=@"45 min";
    
}

-(void)DidTapSet1Hr : (UIButton *) sender{
  //  ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    cell.btn_1hr.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
    cell.btn_30.backgroundColor=[UIColor clearColor];
    cell.btn_45.backgroundColor=[UIColor clearColor];
    cell.btn15.backgroundColor=[UIColor clearColor];
    cell.btn_130hr.backgroundColor=[UIColor clearColor];
    cell.btn_2hr.backgroundColor=[UIColor clearColor];
    SetTime=@"1 hr";
    
}
-(void)DidTapSet130Hr : (UIButton *) sender{
   // ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    cell.btn_130hr.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
    cell.btn_30.backgroundColor=[UIColor clearColor];
    cell.btn_45.backgroundColor=[UIColor clearColor];
    cell.btn_1hr.backgroundColor=[UIColor clearColor];
    cell.btn15.backgroundColor=[UIColor clearColor];
    cell.btn_2hr.backgroundColor=[UIColor clearColor];
    SetTime=@"1:30 min";
    
}
-(void)DidTapSet2HR : (UIButton *) sender{
  //  ConfirmCell *cell = [self.table_notification dequeueReusableCellWithIdentifier:@"ConfirmCell"];
    NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    cell.btn_2hr.backgroundColor = [UIColor colorWithRed:171.0/255.0f green:45.0/255.0f blue:46.0/255.0f alpha:1.0];
    cell.btn_30.backgroundColor=[UIColor clearColor];
    cell.btn_45.backgroundColor=[UIColor clearColor];
    cell.btn_1hr.backgroundColor=[UIColor clearColor];
    cell.btn_130hr.backgroundColor=[UIColor clearColor];
    cell.btn15.backgroundColor=[UIColor clearColor];
    SetTime=@"2 hr";
    
}
-(void)DidTapSetFees :(UIButton *)sender{
   NSInteger requiredVisibleCell = sender.tag;
    ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:requiredVisibleCell];
    
    
    NSLog(@" Fee Text==>%@",cell.txt_fee.text);
    
    if ([SetTime isEqualToString:@""] || [SetTime length]==0) {
        
        [self.view makeToast:@"Please select visit time"
                    duration:3.0
                    position:CSToastPositionCenter];
    }else if ([cell.txt_fee.text isEqualToString:@""] || [cell.txt_fee.text length]==0)
    {
        
        [self.view makeToast:@"Please enter your fees"
                    duration:3.0
                    position:CSToastPositionCenter];
    }else{
    NSMutableDictionary *setFeeDic=[[NSMutableDictionary alloc]init];
    [setFeeDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    
    [setFeeDic setValue:cell.txt_fee.text forKey:@"fees"];
    [setFeeDic setValue:SetTime forKey:@"response_time"];
    [setFeeDic setValue:[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:sender.tag] valueForKey:@"book_id"]] forKey:@"book_id"];
    NSLog(@"Set Fee Dic %@",setFeeDic);
        [self CallDoctorNotificationSetFee:setFeeDic :requiredVisibleCell ];
    }
}

-(void)CallDoctorNotificationSetFee : (NSMutableDictionary *)Param : (NSInteger )CellIndex{
     [self.view endEditing:YES];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/doc_response.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
        // [SVProgressHUD dismiss];
       //  ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:CellIndex];
         if ([[responseObject valueForKey:@"status"] boolValue]==1) {
            [self ShowNotificationList];
//             [cell.btn_set_fee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//             [cell.btn_confirn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//             cell.btn_set_fee.backgroundColor = [UIColor lightGrayColor];
//             [cell.btn_set_fee setUserInteractionEnabled:NO];
//             
//             cell.btn_confirn.backgroundColor = [UIColor colorWithRed:71.0/255.0f green:141.0/255.0f blue:45.0/255.0f alpha:1.0];
//             [cell.txt_fee setUserInteractionEnabled:NO];
//             [cell.btn_confirn setUserInteractionEnabled:YES];
//             //[cell.btn_confirn setHidden:NO];
//             [self.table_notification reloadData];
             IsSetFeeUpdate=YES;
         }else{
             //[cell.btn_confirn setHidden:YES];
             
         }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}

-(void)doneWithNumberPad{
    
    [self.view endEditing:YES];}



-(void)DidTapDecline : (UIButton *)sender{
    
}

-(void)DidTapConfirm :(UIButton *)sender{
    
    NSMutableDictionary *ConfirmDic = [[NSMutableDictionary alloc]init];
    [ConfirmDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    
   
    [ConfirmDic setValue:[NSString stringWithFormat:@"%@",[[ArrayNotification objectAtIndex:sender.tag] valueForKey:@"book_id"]] forKey:@"book_id"];
    NSLog(@"Set Fee Dic %@",ConfirmDic);
    
    [self CallDoctorNotificationAccept:ConfirmDic];

    
}
-(void)DidTapVisitComplete  :(UIButton *)sneder{
    
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//  //  return UITableViewAutomaticDimension;
//    
////     if ([[[ArrayNotification objectAtIndex:indexPath.row] valueForKey:@"requset_status"] isEqualToString:@"cmplt_booking"]) {
////         return 70;
////     }
////    else{
////        return 100;
////        
////    }
////    if (indexPath.row == 0) { //change 0 to whatever cell index you want taller
////        return 150;
////    }
////    else {
////        return 44;
////    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)CallDoctorNotificationAccept : (NSMutableDictionary *)Param{
     [self.view endEditing:YES];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/accept_request.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
        // ConfirmCell *cell = [[self.table_notification visibleCells] objectAtIndex:CellIndex];
//         if ([[responseObject valueForKey:@"status"] boolValue]==1) {
//             
//             [cell.btn_confirn setHidden:NO];
//             [self.table_notification reloadData];
//             IsSetFeeUpdate=YES;
//         }else{
//             [cell.btn_confirn setHidden:YES];
//             
//         }
     }
          failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
}
@end
