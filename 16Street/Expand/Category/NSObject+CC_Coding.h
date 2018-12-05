//
//  NSObject+CC_Coding.h
//  奶爸钱包
//
//  Created by 王毅 on 2018/3/8.
//  Copyright © 2018年 MYJF. All rights reserved.
//


#define CCCoding \
-(void)encodeWithCoder:(NSCoder *)aCoder\
{\
[self CC_encode:aCoder];\
}\
-(instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
if (self = [super init]) {\
[self CC_decode:aDecoder];\
}return self; \
}

#import <Foundation/Foundation.h>

@interface NSObject (CC_Coding)

- (void)CC_encode:(NSCoder *)aCoder;

- (void)CC_decode:(NSCoder *)aDecoder;
@end
