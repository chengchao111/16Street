//
//  XDSildeItem.h
//  XDSlideController
//
//  Created by 谢兴达 on 2018/8/9.
//  Copyright © 2018年 谢兴达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDTitleItem : UICollectionViewCell

- (void)configItemByTitle:(NSString *)title atIndex:(NSIndexPath *)idx highlightIdx:(NSInteger)hidx font:(UIFont *)font defaultTextColor:(UIColor *)dfColor highlightTextColor:(UIColor *)hlColor lineColor:(UIColor *)lineColor lineSise:(CGSize)lineSize;

@end
