//
//  ViewController.m
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/29.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "ViewController.h"
#import "IFMMenu.h"

@interface ViewController ()<UITabBarControllerDelegate>
@property(nonatomic, strong)NSMutableArray *menuItems;
@end

@implementation ViewController

- (NSMutableArray *)menuItems{
    if (!_menuItems) {
        
        _menuItems = [[NSMutableArray alloc] initWithObjects:
                      
                      [IFMMenuItem itemWithImage:[UIImage imageNamed:@"nav_menu_groupchat"]
                                           title:@"发起群聊"
                                          action:^(IFMMenuItem *item) {
                                              NSLog(@"发起群聊");
                                          }],
                      [IFMMenuItem itemWithImage:[UIImage imageNamed:@"nav_menu_addfriend"]
                                           title:@"添加朋友"
                                          action:^(IFMMenuItem *item) {
                                              NSLog(@"添加朋友");
                                          }],
                      [IFMMenuItem itemWithImage:[UIImage imageNamed:@"nav_menu_scan"]
                                           title:@"扫一扫"
                                          action:^(IFMMenuItem *item) {
                                              NSLog(@"扫一扫");
                                          }],
                      [IFMMenuItem itemWithImage:[UIImage imageNamed:@"nav_menu_wallet"]
                                           title:@"收付款"
                                          action:^(IFMMenuItem *item) {
                                              NSLog(@"收付款");
                                          }],nil];
    }
    
    return _menuItems;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tabBarController.delegate = self;
    
    self.view.backgroundColor = IFMColor(239.0, 239.0, 244.0, 1.0);
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.center.x-36, 100, 73, 64)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"AppLogo"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
}

//导航栏弹出
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    IFMMenu *menu = [[IFMMenu alloc] initWithItems:self.menuItems];
    menu.menuCornerRadiu = 3;
    menu.showShadow = NO;
    [menu showFromNavigationController:self.navigationController WithX:[UIScreen mainScreen].bounds.size.width-32];
}

//tabBar导航栏弹出
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSMutableArray *menuItems = [[NSMutableArray alloc] initWithObjects:
                                 
         [IFMMenuItem itemWithImage:[UIImage imageNamed:@"address_icon_down"]
                              title:@"保存到手机"
                             action:^(IFMMenuItem *item) {
                                 NSLog(@"保存到手机");
                             }],
         [IFMMenuItem itemWithImage:[UIImage imageNamed:@"address_icon_share"]
                              title:@"分享一下"
                             action:^(IFMMenuItem *item) {
                                 NSLog(@"分享一下");
                             }],
         [IFMMenuItem itemWithImage:[UIImage imageNamed:@"address_icon_modify"]
                              title:@"关注一下"
                             action:^(IFMMenuItem *item) {
                                 NSLog(@"关注一下");
                             }], nil];
    
    IFMMenu *menu = [[IFMMenu alloc] initWithItems:menuItems];
    menu.menuBackgroundStyle = IFMMenuBackgroundStyleLight;
    menu.minMenuItemHeight = 45;
    
    CGFloat x = tabBarController.selectedIndex *90 +50;
    [menu showFromTabBarController:self.tabBarController WithX:x];
}

- (void)showMenu:(UIButton *)sender{
    
    IFMMenu *menu = [[IFMMenu alloc] initWithItems:self.menuItems];
    menu.menuBackgroundStyle = IFMMenuBackgroundStyleLight;
    menu.edgeInsets = UIEdgeInsetsMake(30, 20, 50, 10);
    menu.gapBetweenImageTitle = 50;
    menu.arrowHight = 20;
    menu.menuBackGroundColor = [UIColor orangeColor];
    menu.minMenuItemHeight = 45;
    menu.titleFont = [UIFont systemFontOfSize:20];
    menu.segmenteLineColor = [UIColor blueColor];
    menu.titleColor = [UIColor greenColor];
    menu.menuSegmenteLineStyle = IFMMenuSegmenteLineStyleFill;
    menu.menuCornerRadiu = 20;
    menu.showShadow = NO;

    [menu showFromRect:sender.frame inView:self.view];
}

@end
