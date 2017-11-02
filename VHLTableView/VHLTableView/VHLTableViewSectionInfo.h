//
//  VHLTableViewSectionInfo.h
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewUserInfo.h"

@class VHLTableViewCellInfo;

@interface VHLTableViewSectionInfo : VHLTableViewUserInfo

@property (nonatomic, assign) CGFloat fHeaderHeight;
@property (nonatomic, assign) CGFloat fFooterHeight;
@property (nonatomic, weak) id makeHeaderTarget;
@property (nonatomic, weak) id makeFooterTarget;
@property (nonatomic, assign) SEL makeHeaderSel;
@property (nonatomic, assign) SEL makeFooterSel;
@property (nonatomic, assign) BOOL bUseDynamicSize;

+ (instancetype)sectionInfoDefault;
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle;
+ (instancetype)sectionInfoFooter:(NSString *)footerTitle;
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle footer:(NSString *)footerTitle;
+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView;
+ (instancetype)sectionInfoFooterWithView:(UIView *)footerView;
+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView footer:(UIView *)footerView;
+ (instancetype)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target;

- (void)setHeaderTitle:(NSString *)headerTitle;
- (void)setFooterTitle:(NSString *)footerTitle;
- (void)setHeaderView:(UIView *)headerView;
- (void)setFooterView:(UIView *)footerView;
- (__kindof UIView *)getHeaderView;
- (__kindof UIView *)getFooterView;

- (NSUInteger)getCellCount;
- (VHLTableViewCellInfo *)getCellAt:(NSUInteger)row;
- (void)addCell:(VHLTableViewCellInfo *)cell;
- (void)insertCell:(VHLTableViewCellInfo *)cell At:(NSUInteger)row;
- (void)updateCell:(VHLTableViewCellInfo *)cell At:(NSUInteger)row;
- (void)removeCellAt:(NSUInteger)row;

@end
