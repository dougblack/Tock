//
//  AppDelegate.m
//  Times
//
//  Created by Douglas Black on 12/23/12.
//  Copyright (c) 2012 Doug Black. All rights reserved.
//

#import "AppDelegate.h"
#import "TimesViewController.h"
#import "CommonCLUtility.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    TimesViewController *timesTable = [[TimesViewController alloc] init];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:timesTable];
    [self setNavigationController:navigationController];
    [self.window setRootViewController:self.navigationController];
    [self.window addSubview:self.navigationController.view];
    [self.window makeKeyAndVisible];
    
    
    UIImage *buttonColor = [CommonCLUtility imageFromColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]];
    
    UIImage *barcolor = [CommonCLUtility imageFromColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    
    UIImage *navBarImage = [UIImage imageNamed:@"nav_bar.png"];
    UIImage *buttonImage = [UIImage imageNamed:@"button.png"];
    // APPEARANCES
//    [[UIBarButtonItem appearance] setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    [[UIToolbar appearance] setBackgroundImage:navBarImage forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    
    return YES;
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
