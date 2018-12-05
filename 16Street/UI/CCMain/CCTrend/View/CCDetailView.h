//
//  CCDetailView.h
//  16Street
//
//  Created by apple on 2018/11/26.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCDetailView : UIView<UIWebViewDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)UIWebView *webView;

- (instancetype)initWithFrame:(CGRect)frame urlString:(NSString *)urlString;

@property (copy,nonatomic)void(^GetWebHeightBlock)(CGFloat height);
@end

NS_ASSUME_NONNULL_END
