//
//  ViewController.m
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [self CheckedLoggedin];
}

-(void)CheckedLoggedin{
//    if([[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"] != nil) {
//        PatientDashboardController *gotopatientDashboard=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
//        [self.navigationController pushViewController:gotopatientDashboard animated:YES];
//    }
     if([[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] != nil) {
         if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"provider"]) {
        ProviderDashboardController *gotoDoctorDash=[self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboardController"];
        [self.navigationController pushViewController:gotoDoctorDash animated:YES];
    }else{
        PatientDashboardController *gotoPatientDash=[self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
        [self.navigationController pushViewController:gotoPatientDash animated:YES];
        }
     }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapPatientLogin:(id)sender {
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"patient" forKey:@"Login_type"];
    [userdefault synchronize];
    LoginViewController *gotoLogin=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:gotoLogin animated:YES];
}

- (IBAction)didTapProviderLogin:(id)sender {
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:@"provider" forKey:@"Login_type"];
    [userdefault synchronize];
    ProviderLoginViewController *gotoDoctorLogin = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderLoginViewController"];
    [self.navigationController pushViewController:gotoDoctorLogin animated:YES];
}
@end
