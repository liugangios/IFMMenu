# IFMMenu
仿微信首页添加菜单

# Demo展示
![展示图](http://upload-images.jianshu.io/upload_images/953487-26b88310ebdae1c7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
# GIF展示
![动图.gif](http://upload-images.jianshu.io/upload_images/953487-68193b87b16e8f69.gif?imageMogr2/auto-orient/strip)

#安装
 **CocoaPods**

1. 在 `Podfile` 中添加 `pod 'IFMMenu'`
2. 执行 `pod install` 或 `pod update`
3. 导入 `<IFMMenu/IFMMenu.h> `

**手动安装**

1. 下载`IFMMenu`文件夹内的所有内容。
2. 将`IFMMenu`内的源文件添加(拖放)到你的工程。
3. 导入`IFMMenu.h`

# 使用

```
NSMutableArray *menuItems = [[NSMutableArray alloc] initWithObjects:
                                 
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

[menu showFromRect:sender.frame inView:self.view];

```
除了这种展示方法，还提供了从导航栏和TabBar弹出的方法

```
[menu showFromNavigationController:self.navigationController WithX:100];
[menu showFromTabBarController:self.tabBarController WithX:100];
```

# 个性化设置
支持弹出框的多种自定义设置


```
menu.menuBackgroundStyle = IFMMenuBackgroundStyleLight; //menu样式
menu.edgeInsets = UIEdgeInsetsMake(30, 20, 50, 10); //下拉框的内边距
menu.gapBetweenImageTitle = 50; //图片和标题间距
menu.arrowHight = 20;   //指向控件的箭头的高度
menu.menuBackGroundColor = [UIColor orangeColor];   //背景颜色
menu.minMenuItemHeight = 45;    //Item最小高度
menu.minMenuItemWidth = 100;    //Item最小宽度
menu.titleFont = [UIFont systemFontOfSize:20];  //Item字体
menu.segmenteLineColor = [UIColor blueColor];   //分割线颜色
menu.titleColor = [UIColor greenColor]; //Item颜色
menu.menuSegmenteLineStyle = IFMMenuSegmenteLineStyleFill;  //分割线类型
menu.menuCornerRadiu = 20;  //menu的圆角大小
menu.showShadow = NO;   //是否显示阴影
```


