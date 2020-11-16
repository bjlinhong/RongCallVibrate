//
//  AppDelegate.m
//  RongCallVibrate
//
//  Created by LiuLinhong on 2020/11/16.
//

#import "AppDelegate.h"
#import  <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center setDelegate:self];
    
    UNAuthorizationOptions type = UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert;
    [center requestAuthorizationWithOptions:type
                          completionHandler:^(BOOL granted, NSError *     _Nullable error) {
        if (granted) {
            NSLog(@"注册成功");
        } else {
            NSLog(@"注册失败");
        }
    }];
    
    [application registerForRemoteNotifications];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSLog(@"DeviceToken: %@", deviceToken); //注册成功后返回的Token
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"Fail To Register error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    
    completionHandler(UIBackgroundFetchResultNewData | UIBackgroundFetchResultNoData | UIBackgroundFetchResultFailed);
    NSLog(@"didReceiveRemoteNotification: %@", userInfo);
}

#pragma mark - UNUserNotificationCenterDelegate
//在前台收到推送时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    NSLog(@"willPresentNotification");
    
    completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler {
    NSLog(@"didReceiveNotificationResponse");
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
   openSettingsForNotification:(nullable UNNotification *)notification {
    NSLog(@"openSettingsForNotification");
}

#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
                                          sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
