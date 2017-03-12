//
//  ProviderDashboardController.h
//  sos
//
//  Created by Rabi Chourasia on 11/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@class  AppDelegate;
@interface ProviderDashboardController : UIViewController<SlideNavigationControllerDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    NSString *LatLong;
    NSString *currentLat,*currentLong;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_go_tonotification;
@property (strong,nonatomic)AppDelegate *Mytoken;
@property (weak, nonatomic) IBOutlet UISwitch *switch_notification;
- (IBAction)didTapNotificationChange:(id)sender;
- (IBAction)didTapMenuOpen:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_new_notification;
@property (weak, nonatomic) IBOutlet UIImageView *image_new_notification_arrow;
- (IBAction)DidTapGotoNotificationList:(id)sender;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView_;
@end
