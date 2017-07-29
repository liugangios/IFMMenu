//
//  IFMMenuItem.m
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/26.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMMenuItem.h"

@implementation IFMMenuItem

+ (instancetype)itemWithImage:(UIImage *)image
                        title:(NSString *)title
                       action:(void (^)(IFMMenuItem *item))action;
{
    return [[IFMMenuItem alloc] init:title
                              image:image
                             action:(void (^)(IFMMenuItem *item))action];
}
- (instancetype) init:(NSString *) title
      image:(UIImage *) image
     action:(void (^)(IFMMenuItem *item))action
{
    NSParameterAssert(title.length || image);
    
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _action = action;
    }
    return self;
}

- (void)clickMenuItem
{
    if (self.action) {
        self.action(self);
    }
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"<%@ #%p %@>", [self class], self, _title];
}

@end

