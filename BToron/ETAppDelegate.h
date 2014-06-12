//
//  ETAppDelegate.h
//  BToron
//
//  Created by EndoTsuyoshi on 2014/06/10.
//  Copyright (c) 2014年 tuyo.en. All rights reserved.
//

#import "ETRootViewController.h"
#import <UIKit/UIKit.h>

@interface ETAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ETRootViewController *viewController; // 追加
@end
