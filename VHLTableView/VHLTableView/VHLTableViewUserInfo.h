//
//  VHLTableViewUserInfo.h
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 忽略警告执行方法
#define NoWarningPerformSelector(target, action, object, object1) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
[target performSelector:action withObject:object withObject:object1] \
_Pragma("clang diagnostic pop") \

@interface VHLTableViewUserInfo : NSObject

@property (nonatomic, strong) VHLTableViewUserInfo *userInfo;

- (id)getUserInfoValueForKey:(NSString *)key;
- (void)addUserInfoValue:(id)value forKey:(NSString *)key;

@end

// Category

@interface NSString (VHLTableView)
- (CGSize)vhltableview_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
@end
