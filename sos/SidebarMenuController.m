//
//  SidebarMenuController.m
//  VegansMeet
//
//  Created by Jishnu Saha on 14/12/15.
//  Copyright © 2015 ogma. All rights reserved.
//

#import "SidebarMenuController.h"

@interface SidebarMenuController ()

@end

@implementation SidebarMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}
-(void)viewWillAppear:(BOOL)animated{
    MenuArr = [[NSMutableArray alloc]init];
    ArrayMenuImage = [[NSMutableArray alloc]init];
   // NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);

 
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"provider"]) {
        MenuArr=[[NSMutableArray alloc]initWithObjects:@"PROFILE",@"VISIT HISTORY",@"CONTACT",@"LOGOUT",nil];
        ArrayMenuImage = [[NSMutableArray alloc]initWithObjects:@"profilenew.png",@"visithistorynew.png",@"contactnew.png",@"signoutnew.png", nil];
        
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"patient"]) {
        
        MenuArr=[[NSMutableArray alloc]initWithObjects:@"PROFILE",@"PAYMENT",@"RECEIPT",@"CONTACT",@"LOGOUT",nil];
        ArrayMenuImage = [[NSMutableArray alloc]initWithObjects:@"profilenew.png",@"payment.png",@"receiptnew.png",@"contactnew.png",@"signoutnew.png", nil];
    }
    [self.table_menu reloadData];
}
#pragma status bar hidden
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MenuArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MyMenuCell";
    
   SidebarmenuCell *cell = [self.table_menu dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[SidebarmenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyMenuCell"];
    }
    
    cell.myMenu.text=[MenuArr objectAtIndex:indexPath.row];
    
    cell.imageMenu.image = [UIImage imageNamed:[ArrayMenuImage objectAtIndex:indexPath.row]];//
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   // self.app.GlobalBool=NO;
    [SVProgressHUD dismiss];
   //SidebarmenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==0) {
        
         if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"patient"]) {
               UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
             
             PatientProfileController  *controller1=(PatientProfileController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"PatientProfileController"];
             [[SlideNavigationController sharedInstance]
              switchToViewController:controller1 withCompletion:nil];
         }
         else{
             
             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
             
             DoctroProfileController  *controller1=(DoctroProfileController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"DoctroProfileController"];
             [[SlideNavigationController sharedInstance]
              switchToViewController:controller1 withCompletion:nil];
         }
    }

    if (indexPath.row==1) {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"patient"]) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            PatientPaymentViewController  *controller=(PatientPaymentViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"PatientPaymentViewController"];
            [[SlideNavigationController sharedInstance]
             switchToViewController:controller withCompletion:nil];
        }else
        {
           
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            ProviderHistoryController  *controller=(ProviderHistoryController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProviderHistoryController"];
            [[SlideNavigationController sharedInstance]
             switchToViewController:controller withCompletion:nil];
            
        }
    }
    
    
    if (indexPath.row==2) {
         if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"provider"]) {
             
             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
             
             ContactController  *controller=(ContactController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactController"];
             [[SlideNavigationController sharedInstance]
              switchToViewController:controller withCompletion:nil];
             
             
            //             UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello",@"Fri"]
//                                                                                      applicationActivities:nil];
//             
//             controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
//                                                  UIActivityTypePrint,
//                                                  UIActivityTypeCopyToPasteboard,
//                                                  UIActivityTypeAssignToContact,
//                                                  UIActivityTypeSaveToCameraRoll,
//                                                  UIActivityTypeAddToReadingList,
//                                                  UIActivityTypePostToFlickr,
//                                                  UIActivityTypePostToVimeo,
//                                                  UIActivityTypePostToTencentWeibo,
//                                                  UIActivityTypeAirDrop,
//                                                  UIActivityTypePostToFacebook,
//                                                  UIActivityTypePostToTwitter
//                                                  ];
//             [self presentViewController:controller animated:YES completion:nil];
             
//             if ([MFMailComposeViewController canSendMail])
//             {
//                 NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//                 
//                // NSString *Msgsubject =[NSString stringWithFormat:@"Feedback: Pictesque App | Platform: iOS | Version %@",appVersionString];
//              //   NSLog(@"Subject %@",Msgsubject);
//                 
//                 MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//                 mail.mailComposeDelegate = self;
//                 [mail setSubject:@""];
//                 [mail setMessageBody:@"" isHTML:NO];
//                 [mail setToRecipients:@[@"pictesquecontact@gmail.com"]];
//                 
//                 [self presentViewController:mail animated:YES completion:NULL];
//             }
//             else
//             {
//                 NSLog(@"This device cannot send email");
//             }
             

         
         }
    }
    
    
    if (indexPath.row==3) {
       
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"] isEqualToString:@"provider"]) {
             [self resetDefaults];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
           
            ProviderLoginViewController  *controller=(ProviderLoginViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ProviderLoginViewController"];
            [[SlideNavigationController sharedInstance]
             switchToViewController:controller withCompletion:nil];
            
        }else{
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            ContactController  *controller=(ContactController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"ContactController"];
            [[SlideNavigationController sharedInstance]
             switchToViewController:controller withCompletion:nil];
//            UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[@"Hello",@"Fri"]
//                                                                                     applicationActivities:nil];
//            
//            controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
//                                                 UIActivityTypePrint,
//                                                 UIActivityTypeCopyToPasteboard,
//                                                 UIActivityTypeAssignToContact,
//                                                 UIActivityTypeSaveToCameraRoll,
//                                                 UIActivityTypeAddToReadingList,
//                                                 UIActivityTypePostToFlickr,
//                                                 UIActivityTypePostToVimeo,
//                                                 UIActivityTypePostToTencentWeibo,
//                                                 UIActivityTypeAirDrop,
//                                                 UIActivityTypePostToFacebook,
//                                                 UIActivityTypePostToTwitter
//                                                 ];
//            [self presentViewController:controller animated:YES completion:nil];
//            if ([MFMailComposeViewController canSendMail])
//            {
//                NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//                
//                // NSString *Msgsubject =[NSString stringWithFormat:@"Feedback: Pictesque App | Platform: iOS | Version %@",appVersionString];
//                //   NSLog(@"Subject %@",Msgsubject);
//                
//                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
//                mail.mailComposeDelegate = self;
//                [mail setSubject:@""];
//                [mail setMessageBody:@"" isHTML:NO];
//                [mail setToRecipients:@[@"pictesquecontact@gmail.com"]];
//                
//                [self presentViewController:mail animated:YES completion:NULL];
//            }
//            else
//            {
//                NSLog(@"This device cannot send email");
//            }
            


        }
    }
    

      if(indexPath.row==4)
    {
      
            [self resetDefaults];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            
            LoginViewController  *controller=(LoginViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [[SlideNavigationController sharedInstance]
             switchToViewController:controller withCompletion:nil];
        
    }
        
}

- (void)resetDefaults {
    FBSDKLoginManager *manager = [[FBSDKLoginManager alloc] init];
    [manager logOut];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"Is_rememberd"] != nil) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    }
}
- (void)mailComposeController:(MFMailComposeViewController* )controller didFinishWithResult:(MFMailComposeResult)result error:(NSError* )error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            
            break;
        case MFMailComposeResultSaved:
            
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
