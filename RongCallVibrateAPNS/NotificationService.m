//
//  NotificationService.m
//  RongCallVibrateAPNS
//
//  Created by LiuLinhong on 2020/11/16.
//

#import "NotificationService.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end


@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = @"需要修改成的Title";
    self.bestAttemptContent.body = @"需要修改成的Message";
    self.contentHandler(self.bestAttemptContent);
    
    [self triggerVibrateRCCall];
    NSLog(@"NotificationService didReceiveNotificationRequest");
    
    // <要点>
    // 否则无法实现30秒
    usleep(30000000);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    NSLog(@"NotificationService serviceExtensionTimeWillExpire");
    self.contentHandler(self.bestAttemptContent);
}

- (void)triggerVibrateRCCall {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"NotificationService triggerVibrateRCCall");
        [NSTimer scheduledTimerWithTimeInterval:1.f
                                        repeats:YES
                                          block:^(NSTimer * _Nonnull timer) {
            AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, ^{});
        }];
    });
}


















@end
