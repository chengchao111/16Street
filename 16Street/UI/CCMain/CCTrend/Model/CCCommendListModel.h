//
//  CCCommendListModel.h
//  16Street
//
//  Created by apple on 2018/11/23.
//  Copyright © 2018年 toerax. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCCommendListModel : NSObject
//头像
@property (strong,nonatomic)NSString *HeadUrl;
//父类Id（是给谁评论的）0表示第一级
@property (strong,nonatomic)NSString *ParentID;
//评论内容
@property (strong,nonatomic)NSString *Content;
//
@property (strong,nonatomic)NSString *IsDelete;
//评论者的电话号码
@property (strong,nonatomic)NSString *TelePhone;
//
@property (strong,nonatomic)NSString *KeyID;
//评论者名字
@property (strong,nonatomic)NSString *RealName;
//父级的名字
@property (strong,nonatomic)NSString *ParentName;
//评论时间
@property (strong,nonatomic)NSString *AddTimeStr;
//
@property (strong,nonatomic)NSString *NewsId;
//点赞数量
@property (strong,nonatomic)NSString *PraiseNum;
//子类评论
@property (strong,nonatomic)NSArray *SubComments;
//评论内容链接
@property (strong,nonatomic)NSString *link;
//帖子的类型：5为潮show
@property (strong,nonatomic)NSString *Type;
@end

NS_ASSUME_NONNULL_END
