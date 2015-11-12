//
//  AppDelegate.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1];
    self.window.frame = [UIScreen mainScreen].bounds;
    RootViewController * root = [[RootViewController alloc]init];
    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:root];
    //self.window.rootViewController = [[RootViewController alloc]init];
    self.window.rootViewController = nv;
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:@"561092ea67e58e05840005f2"];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];
    
    return YES;
}

//- (void)tabBarSetting
//{
//    UITabBarController * tbc = (UITabBarController *)self.window.rootViewController;
//    // UITabBar（分栏条）
//    UITabBar * tabBar = tbc.tabBar;
//    tabBar.translucent = YES;
//    tabBar.barTintColor = [UIColor whiteColor];
//
//    //[tabBar setBackgroundImage:[UIImage imageNamed:@"header_bg"]];
// 
//    tabBar.barStyle = UIBarStyleDefault;
// 
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
