//
//  PTGAppDelegate.m
//  PalermoTiGuida
//
//  Created by Dan on 10/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGAppDelegate.h"
#import "TestFlight.h"
#import <FacebookSDK/FacebookSDK.h>
@implementation PTGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIImage *navBarImg = [[UIImage imageNamed:NAV_BAR_BG_IMAGE] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [[UINavigationBar appearance] setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage new]];
    UIImage *image =[[UIImage imageNamed:@"tab_bar_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[UITabBar appearance] setBackgroundImage:image];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back_button_bg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back_button_bg"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];

    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"back_button_bg"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    
    [MagicalRecord setupCoreDataStack];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
     [TestFlight takeOff:@"55286689-990e-4d49-b82b-26eb61f8b3f3"];
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
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url];
}

@end
