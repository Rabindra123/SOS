//
//  ArchiveController.m
//  sos
//
//  Created by Alok Das on 01/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ArchiveController.h"

@interface ArchiveController ()

@end

@implementation ArchiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.table_archive.dataSource=self;
    self.table_archive.delegate=self;
    NSMutableDictionary *ArchiveDic = [[NSMutableDictionary alloc]init];
    ArrayArchiveList = [[NSMutableArray alloc]init];
    [ArchiveDic setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] forKey:@"doc_id"];
    NSLog(@"Archive Dic %@",ArchiveDic);
    [self ShowArchiveList:ArchiveDic];
    [self viewCorner:_view_sub_pop];

}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)viewCorner : (UIView *)MyView{
    
    
    MyView.layer.cornerRadius = 10.0; // set cornerRadius as you want.
    MyView.layer.masksToBounds = YES;
    MyView.layer.borderColor = [UIColor lightGrayColor].CGColor; // set color as you want.
    MyView.layer.borderWidth = 1.0; // set borderWidth as you want.
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ShowArchiveList : (NSMutableDictionary *)Param{
    
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url=@"http://usawebdzines.com/SOS/web_services/ios/archive.php";
    [manager POST:url parameters:Param
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"JSON: %@", responseObject);
         [SVProgressHUD dismiss];
         
         ArrayArchiveList = [[NSMutableArray alloc]initWithArray:[responseObject valueForKey:@"details"]];
         if ([ArrayArchiveList count]>0) {
             [self.table_archive reloadData];
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
//http://usawebdzines.com/SOS/web_services/ios/archive.php

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [ArrayArchiveList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArchiveCell *cell =[self.table_archive dequeueReusableCellWithIdentifier:@"ArchiveCell"];
    if (cell==nil) {
        
    }
    
    cell.lbl_patient_name.text= [NSString stringWithFormat:@"%@",[[ArrayArchiveList objectAtIndex:indexPath.row] valueForKey:@"name"]];
    cell.lbl_patient_info.text= @"Patient Additional Details";
    cell.lbl_status.text= @"Status Completed";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.btn_show_details.tag=indexPath.row;
    [cell.btn_show_details addTarget:self action:@selector(pushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}
-(void)pushButtonClicked:(UIButton*)sender
{
    [_view_main_pop setHidden:NO];
    [_view_sub_pop setHidden:NO];
    _lbl_symptom.text=[NSString stringWithFormat:@"Symptoms:  %@",[[ArrayArchiveList objectAtIndex:sender.tag] valueForKey:@"symptom1"]];
    _lbl_age.text=[NSString stringWithFormat:@"Age:  %@",[[ArrayArchiveList objectAtIndex:sender.tag] valueForKey:@"age"]];
    _lbl_info.text=[NSString stringWithFormat:@"Additional:  %@",[[ArrayArchiveList objectAtIndex:sender.tag] valueForKey:@"symptom2"]];
    //_lbl_symptoms
}
- (IBAction)didTapBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)didTapPopClose:(id)sender {
    [_view_sub_pop setHidden:YES];
    [_view_main_pop setHidden:YES];
}
@end
