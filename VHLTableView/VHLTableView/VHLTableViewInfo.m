//
//  VHLTableViewInfo.m
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewInfo.h"

#define LineColor [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]

@interface VHLTableViewInfo () <UITableViewDataSource, UITableViewDelegate, VHLTableViewDelegate>

@property (nonatomic, strong) VHLTableView *tableView;
@property (nonatomic, strong) NSMutableArray<VHLTableViewSectionInfo *> *sections;

@end

@implementation VHLTableViewInfo

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView.m_delegate = nil;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super init]) {
        _tableView = [[VHLTableView alloc] initWithFrame:frame style:style];
        _tableView.delegate = self;
        _tableView.dataSource = self;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_10_3
        if (@available(iOS 11.0, *)) {
            if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_8_4
        if([_tableView respondsToSelector:@selector(cellLayoutMarginsFollowReadableWidth)]) {
            _tableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
#endif
        _sections = @[].mutableCopy;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
    return self;
}
- (void)deviceOrientationChanged:(NSNotification *)noti {
    [self.tableView reloadData];
}
#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sections[section] getCellCount];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
    NSString *identifier = [NSString stringWithFormat:@"VHLTableViewCellInfo_%zd_%f", cellInfo.cellStyle, cellInfo.fCellHeight];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:cellInfo.cellStyle reuseIdentifier:identifier];
    } else {
        for (UIView *subview in cell.contentView.subviews) {
            [subview removeFromSuperview];
        }
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = nil;
        cell.accessoryView = nil;
    }
    //
    if (cellInfo.makeTarget) {
        /** cell 取宽度第一次是 320,显示会有问题*/
        if (cell.frame.size.width != tableView.frame.size.width) {
            CGRect cellFrame = cell.frame;
            cellFrame.size.width = tableView.frame.size.width;
            cellFrame.size.height = cellInfo.fCellHeight;
            cell.frame = cellFrame;
        }
        cellInfo.cell = (VHLTableViewCell *)cell;
        cellInfo.indexPath = indexPath;
        if ([cellInfo.makeTarget respondsToSelector:cellInfo.makeSel]) {
            NoWarningPerformSelector(cellInfo.makeTarget, cellInfo.makeSel, cell, cellInfo);
        }
        if (cellInfo.bNeedSeperateLine && tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0.5f)];
            line.backgroundColor = LineColor;//[UIColor lightGrayColor];
            [cell.contentView addSubview:line];
        }
    }
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section < _sections.count) {
        return [_sections[section] getUserInfoValueForKey:@"headerTitle"];
    }
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section < _sections.count) {
        return [_sections[section] getUserInfoValueForKey:@"footerTitle"];
    }
    return nil;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if (cellInfo.editStyle != UITableViewCellEditingStyleNone) {
                return YES;
            }
        }
    }
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if ([_delegate respondsToSelector:@selector(commitEditingForRowAtIndexPath:cell:)]) {
                [_delegate commitEditingForRowAtIndexPath:indexPath cell:cellInfo];
            }
        }
    }
}
#pragma mark - TableView Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section < _sections.count) {
        VHLTableViewSectionInfo *sectionInfo = _sections[section];
        id target = sectionInfo.makeHeaderTarget;
        if (target) {
            if ([target respondsToSelector:sectionInfo.makeHeaderSel]) {
                return NoWarningPerformSelector(target, sectionInfo.makeHeaderSel, sectionInfo, nil);
            } else {
                NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
                if (headerTitle) {
                    return [VHLTableViewInfo genHeaderView:headerTitle andIsUseDynamic:sectionInfo.bUseDynamicSize];
                }
            }
        } else {
            UIView *headerView = [sectionInfo getUserInfoValueForKey:@"header"];
            if (headerView) {
                return headerView;
            } else if ([_delegate respondsToSelector:sectionInfo.makeHeaderSel]) {
                return NoWarningPerformSelector(_delegate, sectionInfo.makeHeaderSel, sectionInfo, nil);
            } else {
                NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
                if (headerTitle) {
                    return [VHLTableViewInfo genHeaderView:headerTitle andIsUseDynamic:sectionInfo.bUseDynamicSize];
                }
            }
        }
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section < _sections.count) {
        VHLTableViewSectionInfo *sectionInfo = _sections[section];
        id target = sectionInfo.makeFooterTarget;
        if (target) {
            if ([target respondsToSelector:sectionInfo.makeFooterSel]) {
                return  NoWarningPerformSelector(target, sectionInfo.makeFooterSel, sectionInfo, nil);
            } else {
                NSString *footerTitle = [self tableView:tableView titleForFooterInSection:section];
                if (footerTitle) {
                    return [VHLTableViewInfo genFooterView:footerTitle];
                }
            }
        } else {
            UIView *footerView =  [sectionInfo getUserInfoValueForKey:@"footer"];
            if (footerView) {
                return footerView;
            } else if ([_delegate respondsToSelector:sectionInfo.makeFooterSel]) {
                return NoWarningPerformSelector(_delegate, sectionInfo.makeFooterSel, sectionInfo, nil);
            } else {
                NSString *footerTitle = [self tableView:tableView titleForFooterInSection:section];
                if (footerTitle) {
                    return [VHLTableViewInfo genFooterView:footerTitle];
                }
            }
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < _sections.count) {
        NSString *headerTitle = [self tableView:tableView titleForHeaderInSection:section];
        if (headerTitle) {
            return [headerTitle vhltableview_sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:_tableView.bounds.size.width maxHeight:CGFLOAT_MAX].height;
        } else {
            VHLTableViewSectionInfo *sectionInfo = _sections[section];
            if (!sectionInfo.makeHeaderTarget) {
                if(section == 0) {
                    return 10;
                }
                return sectionInfo.fHeaderHeight;
            } else {
                UIView *headerView = [sectionInfo getUserInfoValueForKey:@"header"];
                if (headerView) {
                    return headerView.frame.size.height;
                } else {
                    return sectionInfo.fHeaderHeight;
                }
            }
        }
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section < _sections.count) {
        NSString *footerTitle = [self tableView:tableView titleForFooterInSection:section];
        if (footerTitle) {
            return [footerTitle vhltableview_sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:_tableView.bounds.size.width maxHeight:CGFLOAT_MAX].height;
        } else {
            VHLTableViewSectionInfo *sectionInfo = _sections[section];
            if (!sectionInfo.makeHeaderTarget) {
                return sectionInfo.fHeaderHeight;
            } else {
                UIView *footerView = [sectionInfo getUserInfoValueForKey:@"footer"];
                if (footerView) {
                    return footerView.frame.size.height;
                } else {
                    return sectionInfo.fHeaderHeight;
                }
            }
        }
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        if (indexPath.row < [_sections[indexPath.section] getCellCount]) {
            VHLTableViewCellInfo *cellInfo = [_sections[indexPath.section] getCellAt:indexPath.row];
            id target = cellInfo.calHeightTarget;
            if (target && [target respondsToSelector:cellInfo.calHeightSel]) {
                NoWarningPerformSelector(target, cellInfo.calHeightSel, cellInfo, nil);
            }
            return cellInfo.fCellHeight;
        }
    }
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {   // && cellInfo.selectionStyle != UITableViewCellSelectionStyleNone
            id target = cellInfo.actionTarget;
            if (target) {
                if ([target respondsToSelector:cellInfo.actionSel]) {
                    NoWarningPerformSelector(target, cellInfo.actionSel, cellInfo ,nil);
                }
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if ([_delegate respondsToSelector:@selector(accessoryButtonTappedForRowWithIndexPath:cell:)]) {
                [_delegate accessoryButtonTappedForRowWithIndexPath:indexPath cell:cellInfo];
            }
        }
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            return cellInfo.editStyle;
        }
    }
    return UITableViewCellEditingStyleNone;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < _sections.count) {
        VHLTableViewCellInfo *cellInfo = [self getCellAtSection:indexPath.section row:indexPath.row];
        if (cellInfo) {
            if (cellInfo.editStyle != UITableViewCellEditingStyleNone) {
                return YES;
            }
        }
    }
    return NO;
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_delegate scrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_delegate scrollViewWillBeginDragging:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}
#pragma mark - VHLTableView Delegate
- (void)touchesBegan_TableView:(NSSet *)set withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(touchesBegan_TableView:withEvent:)]) {
        [_delegate touchesBegan_TableView:set withEvent:event];
    }
}
- (void)touchesEnded_TableView:(NSSet *)set withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(touchesEnded_TableView:withEvent:)]) {
        [_delegate touchesEnded_TableView:set withEvent:event];
    }
}
- (void)touchesMoved_TableView:(NSSet *)set withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(touchesMoved_TableView:withEvent:)]) {
        [_delegate touchesMoved_TableView:set withEvent:event];
    }
}
- (void)touchesCancelled_TableView:(NSSet *)set withEvent:(UIEvent *)event {
    if ([_delegate respondsToSelector:@selector(touchesCancelled_TableView:withEvent:)]) {
        [_delegate touchesCancelled_TableView:set withEvent:event];
    }
}
- (void)didFinishedLoading:(id)arg1 {
    if ([_delegate respondsToSelector:@selector(didFinishedLoading:)]) {
        [_delegate didFinishedLoading:arg1];
    }
}
#pragma mark - public method -----------------------------------------------------------------------
#pragma mark - getter
- (UITableView *)getTableView {
    return _tableView;
}
- (NSUInteger)getSectionCount {
    return _sections.count;
}
- (VHLTableViewSectionInfo *)getSectionAt:(NSUInteger)section {
    if (section < _sections.count) {
        return _sections[section];
    }
    return nil;
}
- (VHLTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row {
    if (_sections.count >= section && [_sections[section] getCellCount] >= row) {
        return [_sections[section] getCellAt:row];
    }
    return nil;
}
+ (UIView *)genHeaderView:(NSString *)headerTitle andIsUseDynamic:(BOOL)dynamic {
    return [self createHeaderOrFooterViewWithTitle:headerTitle];
}
+ (UIView *)genFooterView:(NSString *)footerTitle {
    return [self createHeaderOrFooterViewWithTitle:footerTitle];
}
+ (UIView *)createHeaderOrFooterViewWithTitle:(NSString *)title {
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor grayColor];
    label.text = title;
    label.numberOfLines = 0;
    label.frame = (CGRect){{15.0f, 8}, [title vhltableview_sizeWithFont:label.font maxWidth:[UIScreen mainScreen].bounds.size.width - 30 maxHeight:CGFLOAT_MAX]};
    [view addSubview:label];
    view.frame = CGRectMake(0, 0, 0, CGRectGetHeight(label.frame));
    return view;
}
// -------------------------------------------------------------------------------------------------
- (NSUInteger)sectionIndexWithSectionInfo:(VHLTableViewSectionInfo *)sectionInfo {
    return [self.sections indexOfObject:sectionInfo];
}
- (void)addSection:(VHLTableViewSectionInfo *)section {
    [_sections addObject:section];
    [_tableView reloadData];
    //[_tableView reloadSections:[NSIndexSet indexSetWithIndex:(_sections.count - 1)] withRowAnimation:UITableViewRowAnimationTop];
}
- (void)addCell:(VHLTableViewCellInfo *)cell At:(NSIndexPath *)indexPath {
    VHLTableViewSectionInfo *sectionInfo = [self getSectionAt:indexPath.section];
    if (sectionInfo) {
        [sectionInfo insertCell:cell At:indexPath.row];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (void)insertSection:(VHLTableViewSectionInfo *)section At:(NSUInteger)index {
    if (index > _sections.count ) {
        return;
    }
    [_sections insertObject:section atIndex:index];
    [_tableView insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)insertCell:(VHLTableViewCellInfo *)cell At:(NSIndexPath *)indexPath {
    VHLTableViewSectionInfo *sectionInfo = [self getSectionAt:indexPath.section];
    if (sectionInfo) {
        [sectionInfo insertCell:cell At:indexPath.row];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (void)updateSection:(VHLTableViewSectionInfo *)section At:(NSUInteger)index Animation:(UITableViewRowAnimation)animation{
    if (index < _sections.count && section) {
        NSMutableArray *newSectionArray = [_sections mutableCopy];
        [newSectionArray replaceObjectAtIndex:index withObject:section];
        _sections = newSectionArray;
        
        [_sections replaceObjectAtIndex:index withObject:section];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
    }
}
- (void)updateCell:(VHLTableViewCellInfo *)cell At:(NSIndexPath *)indexPath Animation:(UITableViewRowAnimation)animation{
    if (!cell || !indexPath) {
        return;
    }
    VHLTableViewSectionInfo *sectionInfo = [self getSectionAt:indexPath.section];
    if (sectionInfo) {
        [sectionInfo updateCell:cell At:indexPath.row];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    }
}
- (void)removeSection:(NSUInteger)section {
    if (section > _sections.count || _sections.count <= 0) { return; }
    
    [_sections removeObjectAtIndex:section];
    [_tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
}
- (void)removeCellAt:(NSIndexPath *)indexPath {
    VHLTableViewSectionInfo *sectionInfo = [self getSectionAt:indexPath.section];
    if (sectionInfo) {
        [sectionInfo removeCellAt:indexPath.row];
        if ([sectionInfo getCellCount]) {
            [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [self removeSection:indexPath.section];
        }
    }
}
- (void)clearAllSection {
    [_sections removeAllObjects];
    [_tableView reloadData];
}

@end
