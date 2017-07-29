//
//  IFMMenuContainerView.m
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/26.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMMenuContainerView.h"
#import "IFMMenuView.h"

@implementation IFMMenuContainerView

- (void) dealloc { NSLog(@"dealloc %@", self); }

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *gestureRecognizer;
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(singleTap:)];
        [self addGestureRecognizer:gestureRecognizer];
    }
    return self;
}

- (void)singleTap:(UITapGestureRecognizer *)recognizer
{
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[IFMMenuView class]] && [subview respondsToSelector:@selector(dismissMenu:)]) {
            [subview performSelector:@selector(dismissMenu:) withObject:@(YES)];
        }
    }
}

@end

