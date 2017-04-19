//
//  YQBackgroundTaskManager.h
//  Logistics
//
//  Created by fangyq on 2017/3/20.
//  Copyright © 2017年 方义强. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@interface YQBackgroundTaskManager : NSObject

// taskManager
+ (instancetype)sharedBackgroundTaskManager;

- (UIBackgroundTaskIdentifier)beginNewBackgroundTask;
- (void)endAllBackgroundTasks;


@end
