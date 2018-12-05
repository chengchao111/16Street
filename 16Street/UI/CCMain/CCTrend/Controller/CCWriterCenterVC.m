//
//  CCWriterCenterVC.m
//  16Street
//
//  Created by apple on 2018/10/25.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCWriterCenterVC.h"

#import "CCWaterFullVC.h"
#import "XDSlideView.h"
#import "CCMineTopView.h"

#import "UserInfoViewModel.h"

@interface CCWriterCenterVC ()<XDSlideViewDataSourceAndDelegate>
@property (nonatomic,strong)XDSlideView *slidView;
@property (nonatomic,strong)CCMineTopView *headerView;
@property (nonatomic,strong)NSArray *titles;
@end

@implementation CCWriterCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.titles = @[@"潮show"];
    [self.view addSubview:self.slidView];
    CGFloat height = 184 + StatusBarHeight;
    _headerView = [[CCMineTopView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    _headerView.settingBtn.hidden = YES;
    _headerView.backBtn.hidden = NO;
    self.slidView.headerView = self.headerView;
    [self managerBlock];
    [self reFreshHeaderUI];
    // Do any additional setup after loading the view.
}

#pragma mark ************* Block处理************
- (void)managerBlock{
    WeakSelf(self);
    [self.headerView setButtonBlock:^(NSInteger tag) {
        NSLog(@"tag = %ld",(long)tag);
        switch (tag - 100) {
            case 0://返回
            {
                [weakself.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 1://设置
            {
                
            }
                break;
            case 2://头像
            {
                
            }
                break;
                
            default:
                break;
        }
    }];
    
    
    
    
}


#pragma mark ************* 懒加载************
-(XDSlideView *)slidView{
    if (!_slidView) {
        //很关键，数组中的名字不能有重复项
        
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT);
        _slidView = [[XDSlideView alloc]initWithFrame:rect dataSourceAndDelegateInBaseCongtroller:self];
        //设置起始页，默认为0
        _slidView.beginPage = 0;
        
        _slidView.titleBarItemSize = CGSizeMake(SCREEN_WIDTH, 0);
        //设置缓存数（最大同时存在页数），默认为MAXFLOAT
        _slidView.cacheNumber = 2;
        //设置时候有横向反弹效果，默认为NO
        _slidView.slideBounces = YES;
        //设置标题大小，默认为16
        _slidView.titleBartextFont = BOLDSYSTEMFONT(14);
        
        //设置选中时的标题颜色，默认为橘黄
        _slidView.titleBarHighlightTintColor = Color(51, 51, 51);
        
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

#pragma mark ************* 刷新header************
- (void)reFreshHeaderUI{

    NSLog(@"===%@",Image_Url_Path(self.model.headImg));
    [self.headerView.headerBtn sd_setImageWithURL:[NSURL URLWithString:Image_Url_Path(self.model.headImg)] forState:(UIControlStateNormal) placeholderImage:IMAGE(@"defaultHead")];
    self.headerView.nikeName.text = self.model.nickname;
    self.headerView.likeAndFollow.text = [NSString stringWithFormat:@"关注|获赞%@",self.model.likenum];
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
        pageVc = [[CCWaterFullVC alloc]initWithTag:index frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        
     
    }
    
    
    return pageVc;
}

#pragma mark -- 非必须实现代理
- (void)xd_slideViewDidChangeToPageController:(UIViewController *const)pageController title:(NSString *)pageTitle pageIndex:(NSInteger)pageIndex {
    //页面已经变化时调用
    NSLog(@"XDSlideViewDidToTitle:%@ --- index: %ld",pageTitle, (long)pageIndex);
    [self reFreshHeaderUI];
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
