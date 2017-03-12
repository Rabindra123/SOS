//
//  ContactController.m
//  sos
//
//  Created by Rabi Chourasia on 12/03/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "ContactController.h"

@interface ContactController ()

@end

@implementation ContactController

- (void)viewDidLoad {
  //  [self sendEmail];
                if ([MFMailComposeViewController canSendMail])
                {
                    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    
                    // NSString *Msgsubject =[NSString stringWithFormat:@"Feedback: Pictesque App | Platform: iOS | Version %@",appVersionString];
                    //   NSLog(@"Subject %@",Msgsubject);
    
                    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                    mail.mailComposeDelegate = self;
                    [mail setSubject:@""];
                    [mail setMessageBody:@"" isHTML:NO];
                    [mail setToRecipients:@[@"pictesquecontact@gmail.com"]];
    
                    [self presentViewController:mail animated:YES completion:NULL];
                }
                else
                {
                    NSLog(@"This device cannot send email");
                }

    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
//    NSArray *activityTypes = @[@(DGActivityIndicatorAnimationTypeNineDots),
//                               @(DGActivityIndicatorAnimationTypeTriplePulse),
//                               @(DGActivityIndicatorAnimationTypeFiveDots),
//                               @(DGActivityIndicatorAnimationTypeRotatingSquares),
//                               @(DGActivityIndicatorAnimationTypeDoubleBounce),
//                               @(DGActivityIndicatorAnimationTypeTwoDots),
//                               @(DGActivityIndicatorAnimationTypeThreeDots),
//                               @(DGActivityIndicatorAnimationTypeBallPulse),
//                               @(DGActivityIndicatorAnimationTypeBallClipRotate),
//                               @(DGActivityIndicatorAnimationTypeBallClipRotatePulse),
//                               @(DGActivityIndicatorAnimationTypeBallClipRotateMultiple),
//                               @(DGActivityIndicatorAnimationTypeBallRotate),
//                               @(DGActivityIndicatorAnimationTypeBallZigZag),
//                               @(DGActivityIndicatorAnimationTypeBallZigZagDeflect),
//                               @(DGActivityIndicatorAnimationTypeBallTrianglePath),
//                               @(DGActivityIndicatorAnimationTypeBallScale),
//                               @(DGActivityIndicatorAnimationTypeLineScale),
//                               @(DGActivityIndicatorAnimationTypeLineScaleParty),
//                               @(DGActivityIndicatorAnimationTypeBallScaleMultiple),
//                               @(DGActivityIndicatorAnimationTypeBallPulseSync),
//                               @(DGActivityIndicatorAnimationTypeBallBeat),
//                               @(DGActivityIndicatorAnimationTypeLineScalePulseOut),
//                               @(DGActivityIndicatorAnimationTypeLineScalePulseOutRapid),
//                               @(DGActivityIndicatorAnimationTypeBallScaleRipple),
//                               @(DGActivityIndicatorAnimationTypeBallScaleRippleMultiple),
//                               @(DGActivityIndicatorAnimationTypeTriangleSkewSpin),
//                               @(DGActivityIndicatorAnimationTypeBallGridBeat),
//                               @(DGActivityIndicatorAnimationTypeBallGridPulse),
//                               @(DGActivityIndicatorAnimationTypeRotatingSandglass),
//                               @(DGActivityIndicatorAnimationTypeRotatingTrigons),
//                               @(DGActivityIndicatorAnimationTypeTripleRings),
//                               @(DGActivityIndicatorAnimationTypeCookieTerminator),
//                               @(DGActivityIndicatorAnimationTypeBallSpinFadeLoader)];
//    
//    
//    for (int i = 0; i < activityTypes.count; i++) {
//        DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[activityTypes[i] integerValue] tintColor:[UIColor whiteColor]];
//        CGFloat width = self.view.bounds.size.width / 5.0f;
//        CGFloat height = self.view.bounds.size.height / 7.0f;
//        
//        activityIndicatorView.frame = CGRectMake(width * (i % 7), height * (int)(i / 7), width, height);
//        [self.view addSubview:activityIndicatorView];
//        [activityIndicatorView startAnimating];
//    }
    
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotateMultiple tintColor:[UIColor blueColor] size:100.0f];

   // activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    activityIndicatorView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:activityIndicatorView];
    
    [activityIndicatorView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendEmail {
    // Email Subject
    NSString *emailTitle = @"Test Email";
    // Email Content
    NSString *messageBody = @"Test Subject!";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"support@test.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)didTapBack:(id)sender {
    
    if ([[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"loggedin_type"]] isEqualToString:@"patient"]) {
        PatientDashboardController *gotoPatineDashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"PatientDashboardController"];
        [self.navigationController pushViewController:gotoPatineDashboard animated:YES];
        
        
    }else{
        ProviderDashboardController *gotoDoctorDashboard = [self.storyboard instantiateViewControllerWithIdentifier:@"ProviderDashboardController"];
        [self.navigationController pushViewController:gotoDoctorDashboard animated:YES];
    }
}
@end
