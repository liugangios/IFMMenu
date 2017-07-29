//
//  AppDelegate.m
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/29.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //1.创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc] init];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:31/255.0 green:184/255.0 blue:34/255.0 alpha:1], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    //设置控制器为Window的根控制器
    self.window.rootViewController=tb;
    
    //b.创建子控制器
    UIViewController *c1=[[ViewController alloc] init];
    c1.title=@"消息";
    c1.tabBarItem.image=[UIImage imageNamed:@"tabbar_mainframe"];
    c1.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_mainframeHL"];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:c1];
    
    UIViewController *c2=[[UIViewController alloc] init];
    c2.view.backgroundColor=[UIColor whiteColor];
    c2.title=@"联系人";
    c2.tabBarItem.image=[UIImage imageNamed:@"tabbar_contacts"];
    c2.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_contactsHL"];
    
    UIViewController *c3=[[UIViewController alloc] init];
    c3.title=@"动态";
    c3.tabBarItem.image=[UIImage imageNamed:@"tabbar_discover"];
    c3.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_discoverHL"];
    
    UIViewController *c4=[[UIViewController alloc] init];
    c4.title=@"设置";
    c4.tabBarItem.image=[UIImage imageNamed:@"tabbar_me"];
    c4.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar_meHL"];
    

    tb.viewControllers=@[nav1,c2,c3,c4];

    [self.window makeKeyAndVisible];
    return YES;
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
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
