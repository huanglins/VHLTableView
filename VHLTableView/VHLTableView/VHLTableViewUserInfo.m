//
//  VHLTableViewUserInfo.m
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewUserInfo.h"

@interface VHLTableViewUserInfo()

@property (nonatomic, strong) NSMutableDictionary *dicInfo;

@end

@implementation VHLTableViewUserInfo

- (id)getUserInfoValueForKey:(NSString *)key {
    if (_dicInfo) {
        return [_dicInfo objectForKey:key];
    }
    return nil;
}
- (void)addUserInfoValue:(id)value forKey:(NSString *)key {
    if (!_dicInfo) {
        _dicInfo = [[NSMutableDictionary alloc] init];
    }
    if (value) {
        [_dicInfo setObject:value forKey:key];
    }
}

@end

// Category
@implementation NSString (VHLTableView)
- (CGSize)vhltableview_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    if (self.length) {
        NSDictionary *attributes = @{NSFontAttributeName : font};
        CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
        return [self boundingRectWithSize:maxSize
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:attributes
                                  context:nil].size;
    } else {
        return CGSizeZero;
    }
}

@end
