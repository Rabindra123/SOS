//
//  AppDelegate.m
//  sos
//
//  Created by Alok Das on 02/02/17.
//  Copyright © 2017 Ogma Conceptions. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    
    self.GlobalBool=NO;
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    
    SidebarMenuController *rightMenu = (SidebarMenuController *)[mainStoryboard
                                                                 instantiateViewControllerWithIdentifier: @"SidebarMenuController"];
    
    
    [SlideNavigationController sharedInstance].leftMenu = rightMenu;
    [SlideNavigationController sharedInstance].rightMenu = rightMenu;
    
    [GMSServices provideAPIKey:@"AIzaSyBcZA1r6vM6mhF9_-jf-ADzqVzkHYJs5z4"];
    [GMSPlacesClient provideAPIKey:@"AIzaSyBcZA1r6vM6mhF9_-jf-ADzqVzkHYJs5z4"];
    //
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert
                                                                                             | UIUserNotificationTypeBadge
                                                                                             | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *Token=[NSUserDefaults standardUserDefaults];
    [Token setValue:token forKey:@"token"];
    [Token synchronize];
    
    NSLog(@"My token is---%@", token);
    _MyDeviceID=[NSString stringWithFormat:@"%@",token];
    NSLog(@"My token is: %@", _MyDeviceID);
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                          openURL:url
                                                sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                       annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    //application.applicationIconBadgeNumber = 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue];
    //[UIApplication sharedApplication].applicationIconBadgeNumber = someNumber;
    //self.textView.text = [userInfo description];
    // We can determine whether an application is launched as a result of the user tapping the action
    // button or whether the notification was delivered to the already-running application by examining
    // the application state.
    
    if (application.applicationState == UIApplicationStateActive)
    {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        // UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Receive a Notification" message:[NSString stringWithFormat:@"Your App name received this notification while it was running:\n%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]]delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        //  [alertView show];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

