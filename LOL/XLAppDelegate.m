//
//  XLAppDelegate.m
//  LOL
//
//  Created by lanou3g on 14-7-18.
//  Copyright (c) 2014年 __许龙__. All rights reserved.
//

#import "XLAppDelegate.h"
#import "XLRootViewController.h"
#import "Reachability.h"


@implementation XLAppDelegate
{
    Reachability *hostReach;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    XLRootViewController *_xlNewsVC = [[XLRootViewController alloc]init];
    UINavigationController *_navigaVC = [[UINavigationController alloc]initWithRootViewController:_xlNewsVC];
    self.window.rootViewController = _navigaVC;
    
    
    
    
    
    
    //检测网络状况
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        [hostReach startNotifier];
    
    
    
    
    return YES;
}

- (void)reachabilityChanged:(NSNotification *)sender
{
    Reachability *curReach = [sender object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    UILabel *_netLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 350, 200, 25)];
    _netLabel.textAlignment = NSTextAlignmentCenter;
    _netLabel.font = Font(15);
    _netLabel.backgroundColor = SkyBlueColor;
    _netLabel.textColor = RedColor;
    [self.window addSubview:_netLabel];
    
    
    switch (status) {
        case NotReachable:
            _netLabel.text = @"当前网络不可用！";
            break;
        case ReachableViaWiFi:
            _netLabel.text = @"当前网络为WIFI！";
            break;
        case ReachableViaWWAN:
            _netLabel.text = @"当前网络为3G网络！";
            break;
        default:
            break;
    }
    
    
    [UIView animateWithDuration:3 animations:^{
        _netLabel.alpha = 0;
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [_netLabel removeFromSuperview];
        
    });
 
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
