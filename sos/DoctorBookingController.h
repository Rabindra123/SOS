//
//  DoctorBookingController.h
//  sos
//
//  Created by Rabi Chourasia on 15/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@import GooglePlaces;
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>
#import "bookingLoationCell.h"
#import "NIDropDown.h"
@interface DoctorBookingController : UIViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,NIDropDownDelegate,UITextFieldDelegate>{
    CLLocationManager *locationManager;
    NSString *LatLong,*newSelectedCurrentLatLong;
    CGFloat currentZoom;
    NSMutableArray *ArrayLocation,*ArrayCurrentLocation;
    GMSPlacesClient *_placesClient;
    BOOL isSelectedAddress,IsSymptomClick;
    NSArray *ArrayDoctorSpecialList,*ArraySymptomsList;
     NIDropDown *dropDown;
    UITapGestureRecognizer *tap;
}
-(void)rel;
@property (strong,nonatomic)NSString *DoctorsIDList;
@property (weak, nonatomic) IBOutlet UITextField *txt_new_address;
- (IBAction)didTapBack:(id)sender;
- (IBAction)didTapBookNow:(id)sender;
- (IBAction)didTapSpeakNow:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lbl_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *txt_address;
@property (weak, nonatomic) IBOutlet GMSMapView *myMapViewShow;
- (IBAction)DidTapBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *table_location;

@property (weak, nonatomic) IBOutlet UILabel *lbl_username;
@property (weak, nonatomic) IBOutlet UIButton *btn_select_provider;
- (IBAction)didTapSelectProvider:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_symptoms;
- (IBAction)didTapMySymptoms:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txt_additional_feat;

@property (weak, nonatomic) IBOutlet UITextField *txt_age;
@end
