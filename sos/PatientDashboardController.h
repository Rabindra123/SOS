//
//  PatientDashboardController.h
//  sos
//
//  Created by Rabi Chourasia on 10/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import <CoreLocation/CoreLocation.h>
@import GoogleMaps;
@import GooglePlaces;
#import <GooglePlaces/GooglePlaces.h>
@interface PatientDashboardController : UIViewController<SlideNavigationControllerDelegate,CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>{
    CLLocationManager *locationManager;
    NSString *LatLong,*newSelectedCurrentLatLong,*GetDoctorsIDList;
    CGFloat currentZoom;
    NSMutableArray *ArrayLocation,*ArrayDoctors_Lat_long,*arrayDocorId;
    GMSPlacesClient *_placesClient;
    BOOL isSelectedAddress,isZoom;
    double CurrnetLatPosition,currentLonPosition;
    NSString *Avg_lat,*Avg_lon;
}
@property (weak, nonatomic) IBOutlet UITableView *table_location;

- (IBAction)didTap_MenuOpen:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt_search_address;
- (IBAction)didTapSearch_clear:(id)sender;
@property (weak, nonatomic) IBOutlet GMSMapView *myMapViewShow;
-(IBAction)zoomInMapView:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image_select_location;
@property (weak, nonatomic) IBOutlet UIButton *btn_select_doctor;
@property (weak, nonatomic) IBOutlet UIButton *btn_press_to_Request;

- (IBAction)didTapPressToRequest:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_card_details;
@property (weak, nonatomic) IBOutlet UILabel *lbl_show_card_no;
- (IBAction)didTapGotoCardUpdate:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *view_add_payment;
- (IBAction)didTapGotoAddPayment:(id)sender;

@end
