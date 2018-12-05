//
//  XDSlideBar.m
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import "XDTitleBar.h"
#import "XDTitleBarLayout.h"
#import "XDTitleItem.h"

#define itemID @"XDTitleItemID"
@interface XDTitleBar()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, assign) CGSize defaultItemSize;
@property (nonatomic, strong) XDTitleBarLayout *layout;
@property (nonatomic, strong) UICollectionView *bar;

@property (nonatomic, assign) __block NSInteger highlightIndex;
@end

@implementation XDTitleBar
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (_bar) {
        [_bar reloadData];
    }
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
    if (itemSize.height == 0) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    //改变slideBar的frame，同时要注意同步里面的collectionView（如果存在的话）的bounds
    CGRect barFrame = self.frame;
    barFrame.size.height = itemSize.height;
    self.frame = barFrame;
    if (self.bar) {
        self.bar.frame = self.bounds;
    }
    if (_layout) {
        [_layout reloadLayout];
    }
    [self.bar reloadData];
}

- (void)setDefaultTintColor:(UIColor *)defaultTintColor {
    if (!_bar) {
        return;
    }
    _defaultTintColor = defaultTintColor;
    [_bar reloadData];
}

- (void)setHighlightTintColor:(UIColor *)highlightTintColor {
    if (!_bar) {
        return;
    }
    _highlightTintColor = highlightTintColor;
    [_bar reloadData];
}

- (void)setBarBackColor:(UIColor *)barBackColor {
    if (!_bar) {
        return;
    }
    _barBackColor = barBackColor;
    _bar.backgroundColor = barBackColor;
}

- (void)setTextFont:(UIFont *)textFont {
    if (!_bar) {
        return;
    }
    _textFont = textFont;
    [_bar reloadData];
}

-(void)setLineColor:(UIColor *)lineColor{
    if (!_bar) {
        return;
    }
    _lineColor = lineColor;
    [_bar reloadData];
}

-(void)setLineSize:(CGSize)lineSize{
    if (!_bar) {
        return;
    }
    _lineSize = lineSize;
    [_bar reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //默认大小为80*40
        _defaultItemSize = CGSizeMake(80, 40);
        self.itemSize = _defaultItemSize;
        _highlightIndex = 0;
        _textFont = [UIFont systemFontOfSize:16];
        _defaultTintColor = [UIColor blackColor];
        _highlightTintColor = [UIColor orangeColor];
        _lineColor = Color(251, 88, 118);
        _lineSize = CGSizeMake(30, 2);
        
        [self creatMainUI];
    }
    return self;
}

- (void)creatMainUI {
    _layout = [[XDTitleBarLayout alloc]init];
    __weak typeof(self) weakSelf = self;
    _layout.itemSizeBlock = ^CGSize(NSIndexPath *indexPath) {
        return weakSelf.itemSize;
    };
    _bar = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:_layout];
    _bar.dataSource = self;
    _bar.delegate = self;
    _bar.showsVerticalScrollIndicator = NO;
    _bar.showsHorizontalScrollIndicator = NO;
    _bar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bar];
    [_bar registerClass:[XDTitleItem class] forCellWithReuseIdentifier:itemID];
    
    //页面更换通知
    self.barIndexChangedBlock = ^(NSInteger index) {
        if (!weakSelf.bar || weakSelf.highlightIndex == index) {
            return;
        }
        //先要完成布局，然后才能进行准确的滚动
        [weakSelf.bar layoutSubviews];
        [weakSelf.bar scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        weakSelf.highlightIndex = index;
        [weakSelf.bar reloadData];
    };
}

#pragma mark -- datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XDTitleItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    [item configItemByTitle:_titles[indexPath.row]
                    atIndex:indexPath
               highlightIdx:_highlightIndex
                       font:_textFont
           defaultTextColor:_defaultTintColor
         highlightTextColor:_highlightTintColor
                  lineColor:_lineColor
                  lineSise:_lineSize];
    return item;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(xd_titleBarItemTapAtIndex:)]) {
        [self.delegate xd_titleBarItemTapAtIndex:indexPath];
    }
}

@end
