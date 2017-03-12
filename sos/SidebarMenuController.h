//
//  SidebarMenuController.h
//  VegansMeet
//
//  Created by Jishnu Saha on 14/12/15.
//  Copyright © 2015 ogma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarmenuCell.h"


#import "SlideNavigationController.h"
#import "AppDelegate.h"
#import "PatientProfileController.h"

#import <MessageUI/MessageUI.h>






@class AppDelegate;
@interface SidebarMenuController : UIViewController<UITableViewDataSource,UITableViewDelegate,SlideNavigationControllerDelegate,MFMailComposeViewControllerDelegate>
{
    NSMutableArray *MenuArr;
    NSMutableArray *ArrayMenuImage;
    NSString *LoginBY;
}
@property (nonatomic,retain)AppDelegate *app;
@property (weak, nonatomic) IBOutlet UITableView *table_menu;
@end
