//
//  VHLTableViewSectionInfo.m
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewSectionInfo.h"

@interface VHLTableViewSectionInfo()

@property (nonatomic, strong) NSMutableArray<VHLTableViewCellInfo *> *cells;

@end

@implementation VHLTableViewSectionInfo

+ (instancetype)sectionInfoDefault {
    return [[VHLTableViewSectionInfo alloc] init];
}
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [sectionInfo setFHeaderHeight:-1.0f];
    }
    return sectionInfo;
}
+ (instancetype)sectionInfoFooter:(NSString *)footerTitle {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [sectionInfo setFFooterHeight:-1.0f];
    }
    return sectionInfo;
}
+ (instancetype)sectionInfoHeader:(NSString *)headerTitle footer:(NSString *)footerTitle {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [sectionInfo setFHeaderHeight:-1.0f];
    }
    [sectionInfo addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [sectionInfo setFFooterHeight:-1.0f];
    }
    return sectionInfo;
}
//
+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerView forKey:@"header"];
    [sectionInfo setFHeaderHeight:headerView.frame.size.height];
    return sectionInfo;
}
+ (instancetype)sectionInfoFooterWithView:(UIView *)footerView {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:footerView forKey:@"footer"];
    [sectionInfo setFFooterHeight:footerView.frame.size.height];
    return sectionInfo;
}
+ (instancetype)sectionInfoHeaderWithView:(UIView *)headerView footer:(UIView *)footerView {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addUserInfoValue:headerView forKey:@"header"];
    [sectionInfo setFHeaderHeight:headerView.frame.size.height];
    
    [sectionInfo addUserInfoValue:footerView forKey:@"footer"];
    [sectionInfo setFFooterHeight:footerView.frame.size.height];
    return sectionInfo;
}
//
+ (instancetype)sectionInfoHeaderMakeSel:(SEL)sel makeTarget:(id)target {
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo setMakeHeaderSel:sel];
    [sectionInfo setMakeHeaderTarget:target];
    return sectionInfo;
}
// ------------------------------------------ init
- (instancetype)init {
    if (self = [super init]) {
        _makeHeaderSel = nil;
        _makeFooterSel = nil;
        _fHeaderHeight = 0;
        _fFooterHeight = 0;
        _cells = @[].mutableCopy;
    }
    return self;
}
#pragma mark - setter
- (void)setHeaderTitle:(NSString *)headerTitle {
    [self addUserInfoValue:headerTitle forKey:@"headerTitle"];
    if (headerTitle.length) {
        [self setFHeaderHeight:-1.0f];
    }
}
- (void)setFooterTitle:(NSString *)footerTitle {
    [self addUserInfoValue:footerTitle forKey:@"footerTitle"];
    if (footerTitle.length) {
        [self setFFooterHeight:-1.0f];
    }
}
- (void)setHeaderView:(UIView *)headerView {
    [self addUserInfoValue:headerView forKey:@"header"];
    [self setFHeaderHeight:headerView.frame.size.height];
}
- (void)setFooterView:(UIView *)footerView {
    [self addUserInfoValue:footerView forKey:@"footer"];
    [self setFFooterHeight:footerView.frame.size.height];
}
#pragma mark - getter
- (UIView *)getHeaderView {
    return [self getUserInfoValueForKey:@"header"];
}
- (UIView *)getFooterView {
    return [self getUserInfoValueForKey:@"footer"];
}
- (NSUInteger)getCellCount {
    return _cells.count;
}
- (VHLTableViewCellInfo *)getCellAt:(NSUInteger)row {
    if (_cells.count >= row) {
        return _cells[row];
    }
    return nil;
}
#pragma mark - option
- (void)addCell:(VHLTableViewCellInfo *)cell {
    [_cells addObject:cell];
}
- (void)insertCell:(VHLTableViewCellInfo *)cell At:(NSUInteger)row {
    if (row < _cells.count) {
        [_cells insertObject:cell atIndex:row];
    }
}
- (void)updateCell:(VHLTableViewCellInfo *)cell At:(NSUInteger)row {
    if (row < _cells.count && cell) {
        NSMutableArray *newCellArray = [_cells mutableCopy];
        [newCellArray replaceObjectAtIndex:row withObject:cell];
        _cells = newCellArray;
    }
}
- (void)removeCellAt:(NSUInteger)row {
    [_cells removeObjectAtIndex:row];
}

@end
