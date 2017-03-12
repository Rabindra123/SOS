//
//  AppDelegate.h
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "SidebarMenuController.h"
@import GoogleMaps;
@import GooglePlaces;
#import <GooglePlaces/GooglePlaces.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,SlideNavigationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign) BOOL GlobalBool;
@property (strong,nonatomic)NSString *MyDeviceID;
@end

