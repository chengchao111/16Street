//
//  XDSildeItem.m
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import "XDTitleItem.h"

@interface XDTitleItem()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *line;
@end
@implementation XDTitleItem
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _line = [[UILabel alloc]init];
    }
    return _title;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatMainUI];
    }
    return self;
}

- (void)creatMainUI {
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:_line];
}

- (void)configItemByTitle:(NSString *)title atIndex:(NSIndexPath *)idx highlightIdx:(NSInteger)hidx font:(UIFont *)font defaultTextColor:(UIColor *)dfColor highlightTextColor:(UIColor *)hlColor lineColor:(UIColor *)lineColor lineSise:(CGSize)lineSize{
    [self.title setFrame:self.bounds];
    CGFloat xd_width =  self.bounds.size.width;
    CGFloat lineWidth = lineSize.width;
    CGFloat lineHeight = lineSize.height;
    [_line setFrame:CGRectMake((xd_width-lineWidth)/2.0, self.bounds.size.height-lineHeight, lineWidth, lineHeight)];
    
    _line.backgroundColor = lineColor;
    self.title.font = font;
    
    //选中时的状态
    if (idx.row == hidx) {
        self.title.textColor = hlColor;
        _line.hidden = NO;
        
    } else {
        self.title.textColor = dfColor;
        _line.hidden = YES;
    }
    self.title.text = title;
}
@end
