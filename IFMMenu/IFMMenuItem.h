//
//  IFMMenuItem.h
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/26.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IFMMenuItem : NSObject
@property (nullable, nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void (^__nullable action)(IFMMenuItem *item);

- (void)clickMenuItem;
+ (instancetype)itemWithImage:(nullable UIImage *)image
                        title:(NSString *)title
                       action:(void (^__nullable)(IFMMenuItem *item))action;

@end

NS_ASSUME_NONNULL_END
