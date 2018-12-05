//
//  CCPostVC.m
//  SixTeenHourShoppingMall
//
//  Created by apple on 2018/10/10.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import "CCPostVC.h"
#import "CCPostNavView.h"
#import "CCPostCell.h"
#import "CCPostOneCell.h"
#import "CCPostFooter.h"
#import "CCChoosePhotoManager.h"
#import "SDPhotoBrowser.h"
#import "CCPostViewModel.h"
@interface CCPostVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDPhotoBrowserDelegate>

@property (strong,nonatomic)CCPostNavView *navView;

@property (strong,nonatomic)CCPostViewModel *postViewModel;

@property (strong,nonatomic)UICollectionView *collectionView;

@property (strong,nonatomic)NSMutableArray *imageArray;

@property (strong,nonatomic)NSString *mainTitle;

@property (strong,nonatomic)NSString *subTitle;

@property (strong,nonatomic)NSDictionary *data;
@end


@implementation CCPostVC

static NSString *const OneIdentifier = @"CCPostOneCell";
static NSString *const identifier = @"CCPostCell";
static NSString *const footer = @"CCPostFooter";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self imageArray];
    [self initData];
    
    [self setUpUI];
    [self block];
}

///MARK:--获取缓存
- (void)initData{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        NSDictionary *dic = [CCFileManager getFileWithFilePath:PostFilePath];
        if ([dic[@"images"] count] > 0 || ![Util isEmptyString:dic[@"title"]] || ![Util isEmptyString:dic[@"subTitle"]]) {
            __block NSMutableArray *images = [NSMutableArray array];
            [dic[@"images"] enumerateObjectsUsingBlock:^(NSString * _Nonnull string, NSUInteger idx, BOOL * _Nonnull stop) {
                [images addObject:[UIImage stringToImage:string]];
            }];
            self.imageArray = images.mutableCopy;
            if (self.imageArray.count < 9 && self.imageArray.count > 0) {
                [self.imageArray addObject:IMAGE(@"选图")];
            }
            self.mainTitle = dic[@"title"];
            self.subTitle = dic[@"subTitle"];
        }
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [self.collectionView reloadData];
        });
        
    });

   
    
}

///MARK:--Block管理
- (void)block{

    WeakSelf(self);
    [self.navView setButtonBlock:^(NSInteger tag) {
        if (tag == 0) {
            [weakself backAction];
            
        }else{
            
            [weakself postInvitation];
        }
    }];
}

///MARK:--UI
- (void)setUpUI{
    [self.view addSubview:self.navView];
    [self.view addSubview:self.collectionView];
}

#pragma mark ************* UICollectionViewDelegate && UICollectionViewDatasource************
///MARK:--cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.imageArray.count == 0) {
        return 1;
    }else{
        return self.imageArray.count;
    }
}

///MARK:--cell数据处理
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(self);
    if (self.imageArray.count == 0) {
        CCPostOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OneIdentifier forIndexPath:indexPath];
        return cell;
    }else{
        CCPostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.photo = _imageArray[indexPath.row];
        [cell setDeleteBtnBlock:^(CCPostCell * _Nonnull cell) {
            [weakself deleteImageWith:cell];
        }];
        
        
        return cell;
    }
}

///MARK:--footer数据处理
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(self);
    CCPostFooter *myFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer forIndexPath:indexPath];
    if (![Util isEmptyString:self.mainTitle]) {
        myFooter.textField.text = self.mainTitle;
    }
    if (![Util isEmptyString:self.subTitle]) {
        myFooter.textView.text = self.subTitle;
    }
    
    myFooter.textFiledBlock = ^(NSString * _Nonnull text) {
        weakself.mainTitle = text;
    };
    
    myFooter.textViewBlock = ^(NSString * _Nonnull text) {
        self.subTitle = text;
    };

    return myFooter;
}

///MARK:--cell选中时间
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self addImageWithIndex:indexPath.row];
}

///MARK:--cell大小设置
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imageArray.count == 0) {
        return CGSizeMake(SCREEN_WIDTH - 40, 82);
    }else{
        return CGSizeMake((SCREEN_WIDTH - 40 - 16* 3)/4,(SCREEN_WIDTH - 40 - 16* 3)/4);
    }
}

#pragma mark ************* SDPhotoBrowserDelegate************
///MARK:-- 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.imageArray[index];
    
}


#pragma mark ************* 内部使用方法************
///MARK:--添加图片
- (void)addImageWithIndex:(NSInteger)index{
    WeakSelf(self);
    if (self.imageArray.count == 0) {//数组里面没有图片的时候
        
        [CCChoosePhotoManager choosePhotosWithController:self MaxImageCount:9 fromSystemPhotosLibraayCompltion:^(NSArray *images) {
            //若选中的图片大于0 小于9张，添加上选图的图片
            if (images.count < 9 && images.count > 0) {
                [weakself.imageArray addObjectsFromArray:images];
                [weakself.imageArray addObject:IMAGE(@"选图")];
            }else if (images.count == 9){
                [weakself.imageArray addObjectsFromArray:images];
            }else{
                
            }
            [weakself.collectionView reloadData];
        }];
        
    }else if (self.imageArray.count > 0 && self.imageArray.count < 9){//数组里面的图片大于0小于9张的时候
        
        if (index == self.imageArray.count - 1) {//如果选中的是最后一张占位图,调用图片选择器
            [CCChoosePhotoManager choosePhotosWithController:self MaxImageCount:10 -self.imageArray.count fromSystemPhotosLibraayCompltion:^(NSArray * _Nonnull images) {
                //如果选中的图片达到最大数量，先移除占位选图图片，再添加选中图片
                if (images.count == 10 -self.imageArray.count) {
                    [weakself.imageArray removeLastObject];
                    [weakself.imageArray addObjectsFromArray:images];
                }else if (images.count > 0 && images.count < 10 -self.imageArray.count){
                    [weakself.imageArray removeLastObject];
                    [weakself.imageArray addObjectsFromArray:images];
                    [weakself.imageArray addObject:IMAGE(@"选图")];
                }
                [weakself.collectionView reloadData];
            }];
            
        }else{//如果选中的是照片，就查看大图
            NSMutableArray *arr = self.imageArray.mutableCopy;
            [arr removeLastObject];
            [self showBrowserWithIndex:index withImageArray:arr];
        }
    }else{//当数组里有9张图片的时候
        if ([self isContainAddImage]) {//有添加图片
            if (index == self.imageArray.count - 1) {//选中添加图片
                [CCChoosePhotoManager choosePhotosWithController:self MaxImageCount:1 fromSystemPhotosLibraayCompltion:^(NSArray * _Nonnull images) {
                    [weakself.imageArray removeLastObject];
                    [weakself.imageArray addObjectsFromArray:images];
                }];
            }else{
                NSMutableArray *arr = self.imageArray.mutableCopy;
                [arr removeLastObject];
                [self showBrowserWithIndex:index withImageArray:arr];
            }
        }else{//没有添加图片
            [self showBrowserWithIndex:index withImageArray:self.imageArray];
        }
    }
}

///MARK:--删除图片
-(void)deleteImageWith:(CCPostCell *)cell{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    [self.imageArray removeObjectAtIndex:indexPath.row];
    if (self.imageArray.count == 1) {//如果只有一张图片，说明只有一张占位图
        [self.imageArray removeAllObjects];
    }else if (self.imageArray.count == 8){
        //判断是否包含选图
        if (![self isContainAddImage]) {
            [self.imageArray addObject:IMAGE(@"选图")];
        }
    }
    [self.collectionView reloadData];
}


///MARK:-- 查看大图
- (void)showBrowserWithIndex:(NSInteger)index withImageArray:(NSArray *)imageArray{
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = index;
    photoBrowser.imageCount = imageArray.count;
    photoBrowser.sourceImagesContainerView = self.collectionView;
    [photoBrowser show];
}


///MARK:--判断imageArray中是否包含添加图片
- (BOOL)isContainAddImage{
    UIImage *image = IMAGE(@"选图");
    NSData *data = UIImagePNGRepresentation(image);
    NSData *data1 = UIImagePNGRepresentation(self.imageArray.lastObject);
    if (![data1 isEqual:data]) {//说明9张全是选中图片
        return NO;
    }else{
        return YES;
    }
}

///MARK:--请求参数组织
- (NSDictionary *)getParamsWithImages:(NSArray *)images{
    CCLoginModel *model = [CCArchiveManager unarchiveObjectWithfilePath:UserInfoPath];
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i < images.count; i ++) {
        NSData *data = UIImageJPEGRepresentation(images[i], 0.1);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [imageArr addObject:encodedImageStr];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:imageArr options:(NSJSONWritingPrettyPrinted) error:&error];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:(NSUTF8StringEncoding)];
    NSDictionary *dic = @{@"imgs":jsonStr,@"title":self.mainTitle,@"intro":self.subTitle,@"fkId":CHECK_STRING(model.Id)};
    
    return dic;
}

///MARK:--上传帖子
- (void)postInvitation{
    WeakSelf(self);
    [self.view endEditing:YES];
    if ([Util isEmptyString:self.mainTitle]) {
        [MBManager showTips:@"请输入标题"];
        return;
    }
    
    if ([Util isEmptyString:self.subTitle]) {
        [MBManager showTips:@"请输入帖子内容"];
        return;
    }
    //如果含有添加图片
    NSMutableArray *images = self.imageArray.mutableCopy;
    if ([self isContainAddImage]) {
        [images removeLastObject];
    }
    
    if (images.count > 0) {
        NSDictionary *parmas = [self getParamsWithImages:images];
        [MBManager showWaitingWithTitle:@"上传中"];
        [self.postViewModel requestWithRequstParams:parmas handleDataWithSuccess:^(NSDictionary * _Nonnull dic) {
            
            [MBManager dismiss];
            [MBManager showTips:@"发布成功，请耐心等待审核！"];
            [weakself dismissViewControllerAnimated:YES completion:nil];
        }];
    }else{
        [MBManager showTips:@"请添加想要上传的图片"];
        return;
    }
}

///MARK:--返回
- (void)backAction{
    WeakSelf(self);
    if (self.imageArray.count > 0 || ![Util isEmptyString:self.mainTitle] || ![Util isEmptyString:self.subTitle]){
        if (self.imageArray.count == 0) {
            self.imageArray = @[].mutableCopy;
        }
        if ([Util isEmptyString:self.mainTitle]) {
            self.mainTitle = @"";
        }
        if ([Util isEmptyString:self.subTitle]) {
            self.subTitle = @"写下你的潮言";
        }
        __block NSMutableArray *images = [NSMutableArray array];
        NSMutableArray *imageArray = self.imageArray.mutableCopy;
        if ([self isContainAddImage]) {
            [imageArray removeLastObject];
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            // 处理耗时操作的代码块...
            if (imageArray > 0) {
                [imageArray enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *base64 = [NSString imageTobase64String:image];
                    [images addObject:base64];
                }];
            }
            //通知主线程刷新
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                NSDictionary *dic = @{@"images":images,@"title":weakself.mainTitle,@"subTitle":weakself.subTitle};
                [self showAlertWithTitle:@"提示" message:@"是否保存草稿" type:(UIAlertControllerStyleAlert) buttonArr:@[@"不保存",@"保存"] alerAction:^(NSInteger index) {
                    if (index == 0) {//不保存
                        [CCFileManager deleteFileWithFilePath:PostFilePath];
                        [weakself dismissViewControllerAnimated:YES completion:nil];
                        
                    }else{//保存
                        
                        [weakself saveScratchWithData:dic];
                        
                    }
                }];
            });
            
        });
        
       
       
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

///MARK:--保存草稿
- (void)saveScratchWithData:(NSDictionary *)data{
    [CCFileManager saveFileWithData:data filePath:PostFilePath];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ************* 懒加载************
-(CCPostNavView *)navView{
    if (!_navView) {
        _navView = [[CCPostNavView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavHeight)];
    }
    return _navView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 16;
        layout.minimumLineSpacing = 16;
        layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.footerReferenceSize = CGSizeMake(SCREEN_WIDTH, SCREENH_HEIGHT -NavHeight - (SCREEN_WIDTH - 40 - 16* 3)/4 - NoTababarHeight);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREENH_HEIGHT - NavHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = kClearColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CCPostFooter class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CCPostOneCell class]) bundle:nil] forCellWithReuseIdentifier:OneIdentifier];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CCPostCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    }
    return _collectionView;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(CCPostViewModel *)postViewModel{
    if (!_postViewModel) {
        _postViewModel = [[CCPostViewModel alloc]init];
    }
    return _postViewModel;
}

@end
