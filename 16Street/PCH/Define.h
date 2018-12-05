//
//  Define.h
//  项目框架
//
//  Created by apple on 2018/7/24.
//  Copyright © 2018年 ChengChao. All rights reserved.
//

#ifndef Define_h
#define Define_h

//1.获取屏幕宽度与高度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

//获取屏幕比例
#define SCREENW(X) [[UIScreen mainScreen] bounds].size.width / 375 *(X)
#define SCREENH(Y) [[UIScreen mainScreen] bounds].size.height / 667 *(Y)

#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define Is_iPhoneX (kStatusBarHeight > 20.0f)

//#define Is_iPhoneX (SCREEN_WIDTH == 375.f && SCREENH_HEIGHT == 812.f)

//有导航栏的时候，导航栏和状态难的总高度
#define NavHeight (Is_iPhoneX ? 88.f : 64.f)

//没有导航栏的时候，状态栏的高度
#define StatusBarHeight      (Is_iPhoneX ? 44.f : 20.f)

#define SafaHeight      (Is_iPhoneX ? 24.f : 0.f)

//有tabbar的时候的高度
#define  TabbarHeight         (Is_iPhoneX ? (49.f+34.f) : 49.f)

//没有Tabbar的时候的高度
#define  NoTababarHeight         (Is_iPhoneX ? 34.f : 0.f)

//
#define SafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

//2.获取通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]

//3.设置随机颜色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//4.设置RGB颜色/设置RGBA颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define AColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]

#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )

#define CHECK_STRING(a) ([[NSString stringWithFormat:@"%@",a] isEqualToString:@"(null)"]  ? @"" : ([[NSString stringWithFormat:@"%@",a] isEqualToString:@"<null>"] ? @"" : a))

#define WeakSelf(type)  __weak typeof(type) weak##type = type;

#define StrongSelf(type)  __strong typeof(type) type = weak##type;

//获取图片资源
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])

//判断 iOS 8 或更高的系统版本
#define iOS8Later (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))
#define iOS7Later (([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)? (YES):(NO))
//.沙盒目录文件

//获取temp
#define PathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

///设备的UDID号
#define UDID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//获取AppDelegate
#define kAppdelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//app主体颜色
#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

#define BasicViewColor      Color(248, 248, 248)
#define BasicNavColor       Color(254, 228, 90)
#define DeSelectTextColor   Color(202,202,202)
#define SelectTextColor     Color(51,51,51)
#define NormalColor          Color(155,155,155)
#define ThemeOrangeColor    Color(255,178,51)

//#define ThemeOrangeColor    [UIColor colorOfHex:0xFFE64C]
#define ThemeGreenColor     [UIColor colorOfHex:0x64C962]
#define ThemeBGColor        [UIColor colorOfHex:0xF5F4F4]
#define ThemeLineColor      [UIColor colorOfHex:0xECECEC]
#define ThemeLightGrayColor [UIColor colorOfHex:0x9B9B9B]
#define ThemeGrayColor      [UIColor colorOfHex:0x4A4A4A]
#define ThemeBlackColor     [UIColor colorOfHex:0x000000]
#define ThemeRedColor       [UIColor colorOfHex:0xFF5722]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#endif /* Define_h */
