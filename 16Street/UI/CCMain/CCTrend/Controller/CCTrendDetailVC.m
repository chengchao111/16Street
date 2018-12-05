//
//  CCTrendDetailVC.m
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCTrendDetailVC.h"

#import "CCTrendDetailViewModel.h"

#import "CCTrendDetailBarView.h"
#import "CCTrendDetailView.h"

#import "CCDetailView.h"
#import "CCCommentTextView.h"

#import "CCCommentCell.h"
#import "CCCommentHeader.h"
#import "CCCommentFooter.h"

#import <IQKeyboardManager.h>
@interface CCTrendDetailVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
//主视图
@property (strong,nonatomic)CCTrendDetailView      *trendView;
//下边工具栏
@property (strong,nonatomic)CCTrendDetailBarView   *barView;
//webView
@property (strong,nonatomic)CCDetailView           *detailView;
//键盘输入框
@property (strong,nonatomic)CCCommentTextView      *textView;
//评论ViewModel
@property (strong,nonatomic)CCTrendDetailViewModel *viewModel;
//用户信息模型
@property (strong,nonatomic)CCLoginModel *userInfo;

//header
@property (strong,nonatomic)CCCommentHeader *headerView;
//footer
@property (strong,nonatomic)CCCommentFooter *footerView;

//数据数组（里面装了评论模型）
@property(strong,nonatomic)NSMutableArray *commentArray;

@end

static NSString *const cellIdentifier = @"CCCommentCell";

@implementation CCTrendDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [MBManager showLoadingInView:self.view];
    self.userInfo = [CCArchiveManager unarchiveObjectWithfilePath:UserInfoPath];
    [self webViewLoad];
    [self setUpUI];
    [self layout];
    [self block];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setUpUI{
    
    [self.view addSubview:self.trendView];
    [self.view addSubview:self.barView];
    [self.view addSubview:self.textView];
    
}

- (void)block{
    WeakSelf(self);
    //:web加载完成回调；
    [self.detailView setGetWebHeightBlock:^(CGFloat height) {
        NSLog(@"%.2f",height);
        weakself.detailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        weakself.detailView.webView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        [weakself loadData];
    }];
    
    [self.barView setBarBtnBlock:^(NSInteger index) {
       
        switch (index) {
            case 0://分享
                
                break;
            case 1://评论
            {
                
                 NSLog(@"index = %ld",(long)index);
                [weakself.textView.textView becomeFirstResponder];
                
            }
                break;
            case 2://点赞
                {
                    
                }
                
                break;
            default:
                break;
        }
    }];
    
    [self.textView setButtonBlock:^(NSInteger tag) {
        [weakself.view endEditing:YES];
        if (tag== 0) {//取消
            
        }else{//评论
            NSDictionary *params = @{@"pId":@"0",@"id":CHECK_STRING(weakself.userInfo.Id) ,@"type":weakself.type,@"content":weakself.textView.textView.text,@"fkId":weakself.model.Id};
            [weakself addComentWithParams:params];
        }
    }];
    
   
}
#pragma mark ************* Action************

///MARK:--alert事件
-(void)aleartClickWithIndex:(NSInteger)index model:(CCCommendListModel *)model{
    
    if ([model.TelePhone isEqualToString:self.userInfo.phone]) {
        switch (index) {
            case 0://复制
                [self copyCommentWithModel:model];
                break;
            case 1://删除
               {
                   NSDictionary *dic = @{@"id":self.userInfo.Id,@"cId":model.KeyID};
                   [self deleteComentWithParams:dic];
                
               }
                break;
                
            default:
                break;
        }
    }else{
        switch (index) {
            case 0://回复
                 {
                     
                     [self.textView.textView becomeFirstResponder];
                     
//                 NSDictionary *params = @{@"pId":model.KeyID,@"id":CHECK_STRING(self.userInfo.Id) ,@"type":self.type,@"content":@"666 😂",@"fkId":self.model.Id};
//                 [self addComentWithParams:params];
                     
                 }
                
                break;
            case 1://复制
                [self copyCommentWithModel:model];
                break;
            case 2://举报
                [self reportCommentWithModel:model];
                break;
                
            default:
                break;
        }
    }
    
}

#pragma mark ************* 数据请求************
- (void)loadData{
    WeakSelf(self);
    NSDictionary *dic = @{@"id":CHECK_STRING(self.userInfo.Id),@"type":self.type,@"page":@"1",@"rows":@"20",@"fkId":self.model.Id};
    NSLog(@"dic = %@",dic);
    [MBManager dismiss];
    [self.viewModel requestCommentListWith:dic success:^(NSArray * _Nonnull models) {
        weakself.commentArray = models.mutableCopy;
        [weakself.trendView.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

///MARK:--删除评论
- (void)deleteComentWithParams:(NSDictionary *)params{
    WeakSelf(self);
    [self.viewModel deleteCommentWithParams:params success:^{
        [weakself loadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

///MARK:--添加评论
- (void)addComentWithParams:(NSDictionary *)params{
    WeakSelf(self);
    [self.viewModel addCommentWithParams:params success:^() {
        [weakself loadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
   
}
///MARK:--举报评论
- (void)reportCommentWithModel:(CCCommendListModel *)model{
    
}
///MARK:--复制评论
- (void)copyCommentWithModel:(CCCommendListModel *)model{
    
}

#pragma mark ************* 控件约束************
-(void)layout{
    //工具栏约束
    [self.barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50 + NoTababarHeight);
    }];
    
    //主视图约束
    [self.trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.barView.mas_top);
        make.top.left.width.mas_equalTo(self.view);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
        make.top.mas_equalTo(self.view.mas_bottom);
    }];
    
}

///MARK：--加载webView
- (void)webViewLoad{
    NSString *urlString = [NSString stringWithFormat:@"%@web/trend?id=%@&fkId=%@",BaseURL,_model.Id,CHECK_STRING(self.userInfo.Id)];
    _detailView = [[CCDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) urlString:urlString];
}

#pragma mark ************* 懒加载************
///MAERK：--数据源
-(NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
}

///MAERK：--工具栏
-(CCTrendDetailBarView *)barView{
    if (!_barView) {
        _barView = [[CCTrendDetailBarView alloc]init];
    }
    return _barView;
}

///MAERK：--主视图
-(CCTrendDetailView *)trendView{
    if (!_trendView) {
        _trendView = [[CCTrendDetailView alloc]init];
        _trendView.tableView.delegate = self;
        _trendView.tableView.dataSource = self;
        _trendView.tableView.tableHeaderView = self.detailView;
        [_trendView.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CCCommentCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
        
    }
    return _trendView;
}

-(CCCommentTextView *)textView{
    if (!_textView) {
        _textView = [[CCCommentTextView alloc]init];
    }
    return _textView;
}

///MAERK：--ViewModel
-(CCTrendDetailViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[CCTrendDetailViewModel alloc]init];
    }
    return _viewModel;
}


#pragma mark ************* UITableViewDataSource && UITableViewDelegate************
///MARK：--section个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.commentArray.count;
}

///MARK：--每个section的cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    CCCommendListModel *model = [CCCommendListModel mj_objectWithKeyValues:self.commentArray[section]];
    NSLog(@"count = %lu",(unsigned long)model.SubComments.count);
    return model.SubComments.count;
}

///MARK：--设置数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CCCommendListModel *model = [CCCommendListModel mj_objectWithKeyValues:self.commentArray[indexPath.section]];
     CCCommendListModel *subModel = [CCCommendListModel mj_objectWithKeyValues:model.SubComments[indexPath.row]];
    CCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[CCCommentCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    cell.model = subModel;
    return cell;
}

///MARK：--hedear
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CCCommendListModel *model = [CCCommendListModel mj_objectWithKeyValues:self.commentArray[section]];
    CGFloat height = [NSString getTextSizeWithStr:model.Content withSize:CGSizeMake(SCREEN_WIDTH - 96, MAXFLOAT) withFont:SYSTEMFONT(12)].height;
    _headerView = [[CCCommentHeader alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    _headerView.model = model;
    return self.headerView;
    
}

///MARK：--footer
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WeakSelf(self);
    CCCommendListModel *model = [CCCommendListModel mj_objectWithKeyValues:self.commentArray[section]];
    _footerView = [[CCCommentFooter alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    _footerView.model = model;
    [_footerView setFooterBlock:^{
        NSArray *buttonArr;
        if ([model.TelePhone isEqualToString:weakself.userInfo.phone]) {
            buttonArr = @[@"复制",@"删除",@"取消"];
        }else{
            buttonArr = @[@"回复",@"复制",@"举报",@"取消"];
        }
        [weakself showAleratWithModel:model buttonArray:buttonArr];
       
    }];
    return self.footerView;
}

///MARK：--cell选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CCCommendListModel *model = [CCCommendListModel mj_objectWithKeyValues:self.commentArray[indexPath.section]];
    CCCommendListModel *cellModel = [CCCommendListModel mj_objectWithKeyValues:model.SubComments[indexPath.row]];
    NSArray *buttonArr;
    if ([cellModel.TelePhone isEqualToString:self.userInfo.phone]) {
        buttonArr = @[@"复制",@"删除",@"取消"];
    }else{
        buttonArr = @[@"回复",@"复制",@"举报",@"取消"];
    }
    [self showAleratWithModel:cellModel buttonArray:buttonArr];
    
}

- (void)showAleratWithModel:(CCCommendListModel *)model buttonArray:(NSArray *)buttonArray{
    [self showAlertWithTitle:@"评论" message:@"" type:(UIAlertControllerStyleActionSheet) buttonArr:buttonArray alerAction:^(NSInteger index) {
        [self aleartClickWithIndex:index model:model];
    }];
}


#pragma mark ************* 监听************
#pragma mark -键盘监听方法
- (void)keyBoardWillShow:(NSNotification *)notification
{
    //     获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:notification.userInfo];
    // 获取键盘高度
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    // 获取键盘动画时间
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];

    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.textView.transform = CGAffineTransformMakeTranslation(0, -(keyBoardHeight + 150));
    };

    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

//键盘回收
- (void)keyBoardWillHide:(NSNotification *)notificaiton
{
    // 获取用户信息
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:notificaiton.userInfo];
    // 获取键盘动画时间

    CGFloat animationTime= [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 定义好动作
    void (^animation)(void) = ^void(void) {
        self.textView.transform = CGAffineTransformIdentity;
    };

    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
   
}

@end
