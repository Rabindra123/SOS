//
//  ViewController.h
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    NSString *LatLong;

}
- (IBAction)didTapPatientLogin:(id)sender;
- (IBAction)didTapProviderLogin:(id)sender;


@end

