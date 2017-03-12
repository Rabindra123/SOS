//
//  PatientPaymentViewController.m
//  sos
//
//  Created by Rabi Chourasia on 08/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "PatientPaymentViewController.h"

@interface PatientPaymentViewController ()

@end

@implementation PatientPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lbl_cardNo.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"credit_card"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)didTapClose:(id)sender {
    //[[SlideNavigationController sharedInstance]righttMenuSelected:nil ];
    //[self.navigationController popViewControllerAnimated:YES];
    PatientDashboardController *gotoBack = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
    [self.navigationController pushViewController:gotoBack animated:YES];
}

- (IBAction)didTapAddCard:(id)sender {
    CardDetailsController *gotoCardDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"CardDetailsController"];
    gotoCardDetails.ISCardAdd=YES;
    [self.navigationController pushViewController:gotoCardDetails animated:YES];
}

- (IBAction)didTapEditCard:(id)sender {
    CardDetailsController *gotoCardDetails = [self.storyboard instantiateViewControllerWithIdentifier:@"CardDetailsController"];
    gotoCardDetails.ISCardAdd=NO;
    [self.navigationController pushViewController:gotoCardDetails animated:YES];
}
@end
