//
//  CCCommentHeader.h
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CCCommendListModel;
NS_ASSUME_NONNULL_BEGIN

@interface CCCommentHeader : UIView
@property (strong,nonatomic)UIImageView *headerImage;
@property (strong,nonatomic)UILabel     *name;
@property (strong,nonatomic)UILabel     *Content;
@property(strong,nonatomic)CCCommendListModel *model;

@end

NS_ASSUME_NONNULL_END
