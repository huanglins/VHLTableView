//
//  VHLTableViewInfo.h
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewUserInfo.h"
#import <UIKit/UIKit.h>
#import "VHLTableView.h"

@class VHLTableViewSectionInfo;
@class VHLTableViewCellInfo;

// protocol
@protocol VHLTableViewInfoDelegate <NSObject, UIScrollViewDelegate, VHLTableViewDelegate>
@optional
- (void)commitEditingForRowAtIndexPath:(NSIndexPath *)indexPath cell:(VHLTableViewCellInfo *)cellInfo;
- (void)accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath cell:(VHLTableViewCellInfo *)cellInfo;

@end

@interface VHLTableViewInfo : VHLTableViewUserInfo

@property (nonatomic, weak) id<VHLTableViewInfoDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;

- (void)addSection:(VHLTableViewSectionInfo *)section;
- (void)addCell:(VHLTableViewCellInfo *)cell At:(NSIndexPath *)indexPath;
- (void)insertSection:(VHLTableViewSectionInfo *)section At:(NSUInteger)index;
- (void)insertCell:(VHLTableViewCellInfo *)cell At:(NSIndexPath *)indexPath;
- (void)removeSection:(NSUInteger)section;
- (void)removeCellAt:(NSIndexPath *)indexPath;
- (void)clearAllSection;

- (UITableView *)getTableView;
- (NSUInteger)getSectionCount;
- (VHLTableViewSectionInfo *)getSectionAt:(NSUInteger)section;
- (VHLTableViewCellInfo *)getCellAtSection:(NSUInteger)section row:(NSUInteger)row;

@end
