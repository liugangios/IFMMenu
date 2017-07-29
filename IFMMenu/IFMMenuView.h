//
//  IFMMenuView.h
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/26.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IFMMenu.h"

NS_ASSUME_NONNULL_BEGIN

@interface IFMMenuView : UIView

- (void)dismissMenu:(BOOL)animated;
- (void)showMenuInView:(UIView *)view
              fromRect:(CGRect)rect
                  menu:(IFMMenu *)menu
             menuItems:(NSArray *)menuItems;

@end

NS_ASSUME_NONNULL_END
