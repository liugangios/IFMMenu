//
//  IFMMenuView.m
//  IFMMenuDemo
//
//  Created by 刘刚 on 2017/7/26.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "IFMMenuView.h"
#import "IFMMenuItem.h"
#import "IFMMenuContainerView.h"
#import "IFMMenu.h"

typedef NS_ENUM(NSInteger, IFMMenuViewArrowDirection) {
    IFMMenuViewArrowDirectionNone,
    IFMMenuViewArrowDirectionUp,
    IFMMenuViewArrowDirectionDown,
};

@interface IFMMenuView()
@property (strong, readwrite, nonatomic) IFMMenu *menu;

@property (nonatomic, assign) IFMMenuViewArrowDirection arrowDirection;//箭头方向
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, assign) CGFloat arrowPosition;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation IFMMenuView

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }
    
    return self;
}

- (void) dealloc {
  NSLog(@"dealloc %@", self);
}

//判断箭头方向
- (void) setupFrameInView:(UIView *)view fromRect:(CGRect)fromRect
{
    //内容大小
    const CGSize contentSize = _contentView.frame.size;
    //屏幕宽高
    const CGFloat outerWidth = view.bounds.size.width;
    const CGFloat outerHeight = view.bounds.size.height;
    
    //箭头指向点X
    const CGFloat rectXM = fromRect.origin.x + fromRect.size.width * 0.5f;
    const CGFloat rectY0 = fromRect.origin.y;
    //箭头指向点Y
    const CGFloat rectY1 = fromRect.origin.y + fromRect.size.height;
    
    //内容+箭头高度
    const CGFloat heightPlusArrow = contentSize.height + _menu.arrowHight;
    const CGFloat widthHalf = contentSize.width * 0.5f;
    
    const CGFloat kMargin = 5.f;//弹出框与屏幕最小间隙
    
    if (heightPlusArrow < (outerHeight - rectY1)) { //箭头point下方有足够距离
        
        _arrowDirection = IFMMenuViewArrowDirectionUp;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY1
        };
        
        //左边距离小于5
        if (point.x < kMargin)
            point.x = kMargin;
        
        //右边距离小于5
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){0, _menu.arrowHight, contentSize};
        
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + _menu.arrowHight
        };
        
    } else if (heightPlusArrow < rectY0) { //箭头point上方有足够距离
        
        _arrowDirection = IFMMenuViewArrowDirectionDown;
        CGPoint point = (CGPoint){
            rectXM - widthHalf,
            rectY0 - heightPlusArrow
        };
        
        if (point.x < kMargin)
            point.x = kMargin;
        
        if ((point.x + contentSize.width + kMargin) > outerWidth)
            point.x = outerWidth - contentSize.width - kMargin;
        
        _arrowPosition = rectXM - point.x;
        _contentView.frame = (CGRect){CGPointZero, contentSize};
        
        self.frame = (CGRect) {
            point,
            contentSize.width,
            contentSize.height + _menu.arrowHight
        };
        
    } else { //内容太多，居中显示
    
        _arrowDirection = IFMMenuViewArrowDirectionNone;
        
        self.frame = (CGRect) {
            (outerWidth - contentSize.width)   * 0.5f,
            (outerHeight - contentSize.height) * 0.5f,
            contentSize,
        };
    }
}

- (void)showMenuInView:(UIView *)view
              fromRect:(CGRect)rect
                  menu:(IFMMenu *)menu
             menuItems:(NSArray *)menuItems
{
    _menu = menu;
    _menuItems = menuItems;
    
    _contentView = [self makeContentView];
    [self addSubview:_contentView];
    
    [self setupFrameInView:view fromRect:rect];
    
    IFMMenuContainerView *overlay = [[IFMMenuContainerView alloc] initWithFrame:view.bounds];
    [overlay addSubview:self];
    [view addSubview:overlay];
    
    _contentView.hidden = YES;
    const CGRect toFrame = self.frame;
    self.frame = (CGRect){self.arrowPoint, 1, 1};
    
    [UIView animateWithDuration:0.2 animations:^(void) {
         self.alpha = 1.0f;
         self.frame = toFrame;
     } completion:^(BOOL completed) {
         _contentView.hidden = NO;
     }];
}

- (void)dismissMenu:(BOOL)animated
{
    if (!animated) {//没有动画
        [self.superview removeFromSuperview];
        [self removeFromSuperview];
        return;
    }
    
    _contentView.hidden = YES;
    const CGRect toFrame = (CGRect){self.arrowPoint, 1, 1};
    
    [UIView animateWithDuration:0.2 animations:^(void) {
         self.alpha = 0;
         self.frame = toFrame;
     } completion:^(BOOL finished) {
         [self.superview removeFromSuperview];
         [self removeFromSuperview];
     }];
}

- (void)menuItemClick:(UIButton *)sender
{
    [self dismissMenu:YES];
    
    UIButton *button = (UIButton *)sender;
    IFMMenuItem *menuItem = _menuItems[button.tag];
    [menuItem clickMenuItem];
}

//画出每一个控件，不使用tableView，不用实现代理和数据源方法，使代码更集中
- (UIView *)makeContentView{
    //移除所有子控件
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    if (!_menuItems.count) return nil;
    
    //是否给边框加阴影
    if (_menu.showShadow) {
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(2, 2);
        self.layer.shadowRadius = 2;
    }
    
    CGFloat maxItemWidth = 0;
    CGFloat maxItemHeight = 0;
    UIButton *calculateBtn;
    //获得最大item的宽度和高度
    for (IFMMenuItem *menuItem in _menuItems) {
        calculateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [calculateBtn.titleLabel setFont:_menu.titleFont];
        [calculateBtn setTitle:menuItem.title forState:UIControlStateNormal];
        [calculateBtn setImage:menuItem.image forState:UIControlStateNormal];
        [calculateBtn sizeToFit];
        
        maxItemWidth = MAX(calculateBtn.frame.size.width, maxItemWidth);
        maxItemHeight = MAX(calculateBtn.frame.size.height, maxItemHeight);
    }
    //加上各种间距
    maxItemWidth = maxItemWidth +_menu.edgeInsets.left+_menu.edgeInsets.right+_menu.gapBetweenImageTitle;
    maxItemWidth  = MAX(maxItemWidth, _menu.minMenuItemWidth);
    maxItemHeight = MAX(maxItemHeight, _menu.minMenuItemHeight);
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.autoresizingMask = UIViewAutoresizingNone;
    contentView.backgroundColor = [UIColor clearColor];
    
    CGFloat itemY = _menu.edgeInsets.top;
    NSUInteger itemNum = 0;
    
    for (IFMMenuItem *menuItem in _menuItems) {
        
        //画UIButton
        const CGRect itemFrame = (CGRect){0, itemY, maxItemWidth, maxItemHeight};
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = itemNum;
        button.frame = itemFrame;
        button.autoresizingMask = UIViewAutoresizingNone;
        
       //自定义样式
        if (_menu.menuBackgroundStyle == IFMMenuBackgroundStyleDark) {
            button.backgroundColor = BlackForMenu;
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else if(_menu.menuBackgroundStyle == IFMMenuBackgroundStyleLight){
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:BlackForMenu forState:UIControlStateNormal];
        }
        if (_menu.menuBackGroundColor) {
            button.backgroundColor = _menu.menuBackGroundColor;
        }
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(button.imageEdgeInsets.top, _menu.edgeInsets.left, button.imageEdgeInsets.bottom, button.imageEdgeInsets.right);
        button.imageEdgeInsets = imageEdgeInsets;
        UIEdgeInsets titleEdgeInsets = UIEdgeInsetsMake(button.titleEdgeInsets.top, _menu.edgeInsets.left+_menu.gapBetweenImageTitle, button.titleEdgeInsets.bottom, button.titleEdgeInsets.right);
        button.titleEdgeInsets = titleEdgeInsets;
        
        [button setTitle:menuItem.title forState:UIControlStateNormal];
        [button.titleLabel setFont:_menu.titleFont];
        if (_menu.titleColor) {
            [button setTitleColor:_menu.titleColor forState:UIControlStateNormal];
        }
        //给第一个按钮画圆角
        if (itemNum == 0) {
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:button.layer.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(_menu.menuCornerRadiu, _menu.menuCornerRadiu)];
            CAShapeLayer * maskLayer = [CAShapeLayer new];
            maskLayer.frame = button.layer.bounds;
            maskLayer.path = maskPath.CGPath;
            button.layer.mask = maskLayer;
        }
        //给最后一个按钮画圆角
        if (itemNum == _menuItems.count - 1) {
            UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:button.layer.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(_menu.menuCornerRadiu, _menu.menuCornerRadiu)];
            CAShapeLayer * maskLayer = [CAShapeLayer new];
            maskLayer.frame = button.layer.bounds;
            maskLayer.path = maskPath.CGPath;
            button.layer.mask = maskLayer;
        }
        
        [button setImage:menuItem.image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(menuItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:[self createImageWithColor:BlackForMenuHL] forState:UIControlStateHighlighted];
        [contentView addSubview:button];
        
        //画分割线
        if (itemNum < _menuItems.count - 1) {
            
            UIView *segmenteLine = [[UIView alloc] init];
            
            if (_menu.menuSegmenteLineStyle == IFMMenuSegmenteLineStylefollowContent) {
                segmenteLine.frame = CGRectMake(_menu.edgeInsets.left, maxItemHeight-0.5, maxItemWidth - _menu.edgeInsets.left - _menu.edgeInsets.right, 0.5);
            }else if (_menu.menuSegmenteLineStyle == IFMMenuSegmenteLineStyleFill) {
                segmenteLine.frame = CGRectMake(0, maxItemHeight-0.5, maxItemWidth, 0.5);
            }
            if (_menu.menuBackgroundStyle == IFMMenuBackgroundStyleDark) {
                segmenteLine.backgroundColor = GrayLine;
            }else if(_menu.menuBackgroundStyle == IFMMenuBackgroundStyleLight){
                segmenteLine.backgroundColor = GrayLine;
            }
            if (_menu.segmenteLineColor) {
                segmenteLine.backgroundColor = _menu.segmenteLineColor;
            }
            [button addSubview:segmenteLine];
        }
        
        itemY += maxItemHeight;
        ++itemNum;
    }
    contentView.frame = (CGRect){0, 0, maxItemWidth, itemY + _menu.edgeInsets.bottom};
    return contentView;
}

- (CGPoint) arrowPoint
{
    CGPoint point;
    
    if (_arrowDirection == IFMMenuViewArrowDirectionUp) {
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition,CGRectGetMinY(self.frame) };
    } else if (_arrowDirection == IFMMenuViewArrowDirectionDown) {
        point = (CGPoint){ CGRectGetMinX(self.frame) + _arrowPosition,CGRectGetMaxY(self.frame) };
    } else {
        point = self.center;
    }
    return point;
}

- (void) drawRect:(CGRect)rect
{
    [self drawBackground:self.bounds inContext:UIGraphicsGetCurrentContext()];
}

//绘制带箭头的背景图
- (void)drawBackground:(CGRect)frame inContext:(CGContextRef) context
{
    CGFloat X0 = frame.origin.x;
    CGFloat X1 = frame.origin.x + frame.size.width;
    CGFloat Y0 = frame.origin.y;
    CGFloat Y1 = frame.origin.y + frame.size.height;
    
    // 画箭头
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    // 箭头和圆角矩形重合的高度
    const CGFloat kEmbedFix = 3.f;
    
    if (_arrowDirection == IFMMenuViewArrowDirectionUp) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - _menu.arrowHight;
        const CGFloat arrowX1 = arrowXM + _menu.arrowHight;
        const CGFloat arrowY0 = Y0;
        const CGFloat arrowY1 = Y0 + _menu.arrowHight + kEmbedFix;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY0}];
        
        if (_menu.menuBackgroundStyle == IFMMenuBackgroundStyleDark) {
            [BlackForMenu set];
        }else if(_menu.menuBackgroundStyle == IFMMenuBackgroundStyleLight){
            [[UIColor whiteColor] set];
        }
        if (_menu.menuBackGroundColor) {
            [_menu.menuBackGroundColor set];
        }
        
        Y0 += _menu.arrowHight;
        
    } else if (_arrowDirection == IFMMenuViewArrowDirectionDown) {
        
        const CGFloat arrowXM = _arrowPosition;
        const CGFloat arrowX0 = arrowXM - _menu.arrowHight;
        const CGFloat arrowX1 = arrowXM + _menu.arrowHight;
        const CGFloat arrowY0 = Y1 - _menu.arrowHight - kEmbedFix;
        const CGFloat arrowY1 = Y1;
        
        [arrowPath moveToPoint:    (CGPoint){arrowXM, arrowY1}];
        [arrowPath addLineToPoint: (CGPoint){arrowX1, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowX0, arrowY0}];
        [arrowPath addLineToPoint: (CGPoint){arrowXM, arrowY1}];
        
        if (_menu.menuBackgroundStyle == IFMMenuBackgroundStyleDark) {
            [BlackForMenu set];
        }else if(_menu.menuBackgroundStyle == IFMMenuBackgroundStyleLight){
            [[UIColor whiteColor] set];
        }
        if (_menu.menuBackGroundColor) {
            [_menu.menuBackGroundColor set];
        }
        
        Y1 -= _menu.arrowHight;
   }
    
    [arrowPath fill];
    
    // 画圆角矩形背景
    const CGRect bodyFrame = {X0, Y0, X1 - X0, Y1 - Y0};
    
    CGContextSetLineWidth(context, 0.5);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bodyFrame cornerRadius:_menu.menuCornerRadiu];//设置圆角
    CGContextAddPath(context, bezierPath.CGPath);
    
    if (_menu.menuBackgroundStyle == IFMMenuBackgroundStyleDark) {
        [BlackForMenu set];
    }else if(_menu.menuBackgroundStyle == IFMMenuBackgroundStyleLight){
        [[UIColor whiteColor] set];
    }
    if (_menu.menuBackGroundColor) {
        [_menu.menuBackGroundColor set];
    }
    CGContextEOFillPath(context);
}

- (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end


