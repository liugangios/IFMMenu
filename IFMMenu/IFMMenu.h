//
//  IFMMenu.h
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/26.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IFMMenuItem.h"

NS_ASSUME_NONNULL_BEGIN

#define     IFMColor(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define     BlackForMenu     IFMColor(71, 70, 73, 1.0)
#define     BlackForMenuHL   IFMColor(65, 64, 67, 1.0)
#define     GrayLine         [UIColor colorWithWhite:0.5 alpha:0.3]

typedef NS_ENUM(NSInteger, IFMMenuBackgroundStyle) {
    IFMMenuBackgroundStyleDark,
    IFMMenuBackgroundStyleLight
};

typedef NS_ENUM(NSInteger, IFMMenuSegmenteLineStyle) {
    IFMMenuSegmenteLineStylefollowContent,
    IFMMenuSegmenteLineStyleFill
};

@interface IFMMenu : NSObject
@property (nullable, nonatomic, strong) UIColor *titleColor; //标题颜色
@property (nullable, nonatomic, strong) UIFont *titleFont; // 标题字体
@property (nullable, nonatomic, strong) UIColor *menuBackGroundColor; //背景颜色
@property (nullable, nonatomic, strong) UIColor *segmenteLineColor;//分割线颜色

@property (nonatomic, assign) CGFloat arrowHight;    //指向按钮的箭头的高度
@property (nonatomic, assign) CGFloat menuCornerRadiu;   //下拉框的圆角
@property (nonatomic, assign) CGFloat minMenuItemHeight;  //按钮最小高度
@property (nonatomic, assign) CGFloat minMenuItemWidth;  //按钮最小宽度
@property (nonatomic, assign) UIEdgeInsets edgeInsets;   //下拉框的内边距
@property (nonatomic, assign) CGFloat gapBetweenImageTitle;  //图片和标题间距
@property (nonatomic, assign) IFMMenuBackgroundStyle menuBackgroundStyle;    //背景类型
@property (nonatomic, assign) IFMMenuSegmenteLineStyle menuSegmenteLineStyle;    //分割线类型
@property (nonatomic, assign) BOOL showShadow;  //是否显示阴影

- (instancetype)initWithItems:(NSArray *)items;
- (instancetype)initWithItems:(NSArray *)items BackgroundStyle:(IFMMenuBackgroundStyle)backgroundStyle;

- (void)addMenuItem:(IFMMenuItem *)menuItem;

- (void)showFromRect:(CGRect)rect inView:(UIView *)view;
- (void)showFromNavigationController:(UINavigationController *)navigationController WithX:(CGFloat)x;
- (void)showFromTabBarController:(UITabBarController *)tabBarController WithX:(CGFloat)x;

- (void) dismissMenu;

@end

NS_ASSUME_NONNULL_END
