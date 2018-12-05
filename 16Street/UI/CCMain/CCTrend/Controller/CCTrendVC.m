//
//  CCTrendVC.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCTrendVC.h"


#import "CCWaterFullVC.h"
#import "XDSlideView.h"

@interface CCTrendVC ()<XDSlideViewDataSourceAndDelegate>

@property (strong,nonatomic)UIButton *searchBtn;

@property (nonatomic,strong)XDSlideView *slidView;

@property (nonatomic,strong)NSArray *titles;

@end

@implementation CCTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = @[@"潮流",@"潮牌",@"潮搭",@"潮服",@"潮人"];
    [self initSearchBtn];
    [self.view addSubview:self.slidView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark ************* 懒加载************
//搜索按钮点击
-(void)initSearchBtn{
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 40);
    [_searchBtn setImage:[UIImage imageNamed:@"顶部搜索"] forState:(UIControlStateNormal)];
    [_searchBtn setTitle:@"在潮show搜索内容\用户" forState:UIControlStateNormal];
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0);
    _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_searchBtn setTitleColor:Color(155, 155, 155) forState:(UIControlStateNormal)];
    _searchBtn.backgroundColor  = BasicViewColor;
    _searchBtn.layer.cornerRadius = 20;
    [_searchBtn addTarget:self action:@selector(showAllQuestions) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _searchBtn;
}

#pragma mark ************* 懒加载************
-(XDSlideView *)slidView{
    if (!_slidView) {
        //很关键，数组中的名字不能有重复项
        
        CGRect rect = self.view.bounds;
        _slidView = [[XDSlideView alloc]initWithFrame:rect dataSourceAndDelegateInBaseCongtroller:self];
        //设置起始页，默认为0
        _slidView.beginPage = 0;
        
        _slidView.titleBarItemSize = CGSizeMake(SCREEN_WIDTH/5, 44);
        //设置缓存数（最大同时存在页数），默认为MAXFLOAT
        _slidView.cacheNumber = 5;
        //设置时候有横向反弹效果，默认为NO
        _slidView.slideBounces = YES;
        //设置标题大小，默认为16
        _slidView.titleBartextFont = BOLDSYSTEMFONT(16);
        //设置下方线的颜色
        _slidView.lineColor = kClearColor;
        
        //设置选中时的标题颜色，默认为橘黄
        _slidView.titleBarHighlightTintColor = Color(251, 88, 118);
        
        //设置默认标题颜色，默认为黑色
        _slidView.titleBarDefaultTintColor = Color(155, 155, 155);
        
        //设置标题栏背景颜色，默认白色
        //        _slidView.titleBarBackColor = [UIColor cyanColor];
        
        //上方空余64
        _slidView.edgeInsetTop = 0;
        
        //标题栏距上方距离
        _slidView.titleBarMarginTop = StatusBarHeight;
        
    }
    return _slidView;
}
#pragma mark ************* 搜索按钮************
-(void)showAllQuestions{
    
}

#pragma mark ************* XDSlideViewDataSourceAndDelegate************
#pragma mark -- 必须实现代理
- (NSArray<NSString *> *)xd_slideViewPageTitles {
    return _titles;
}

- (UIViewController *)xd_slideViewChildControllerToSlideView:(XDSlideView *)slideView forIndex:(NSInteger)index {
    
    //复用
    UIViewController *pageVc = [slideView dequeueReusablePageForIndex:index];
    NSLog(@"index = %ld",(long)index);
    if (!pageVc) {
        //这里可以通过自定义控制器的init实现控制器传参，用于控制器的review
        //注意:该子控制器中的必须包含一个可滚动的子view
        pageVc = [[CCWaterFullVC alloc]initWithTag:index frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT - TabbarHeight)];
       
    }
    
    
    return pageVc;
}

#pragma mark -- 非必须实现代理
- (void)xd_slideViewDidChangeToPageController:(UIViewController *const)pageController title:(NSString *)pageTitle pageIndex:(NSInteger)pageIndex {
    //页面已经变化时调用
    NSLog(@"XDSlideViewDidToTitle:%@ --- index: %ld",pageTitle, (long)pageIndex);
    NSLog(@"pageController = %@",pageController);
    
}

- (void)xd_slideViewVerticalScrollOffsetyChanged:(CGFloat)changedy {
    //垂直变动
    NSLog(@"XDSlideView_Y:%f",changedy);
    
}

- (void)xd_slideViewHorizontalScrollOffsetxChanged:(CGFloat)changedx {
    //水平变动
    NSLog(@"XDSlideView_X:%f",changedx);
    
}

@end
