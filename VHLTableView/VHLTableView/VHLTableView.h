//
//  VHLTableView.h
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VHLTableViewUserInfo.h"
#import "VHLTableViewSectionInfo.h"
#import "VHLTableViewCellInfo.h"

@protocol VHLTableViewDelegate <NSObject>
@optional
- (void)touchesEnded_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)touchesMoved_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)touchesBegan_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)touchesCancelled_TableView:(NSSet *)set withEvent:(UIEvent *)event;
- (void)didFinishedLoading:(id)arg1;

@end

@interface VHLTableView : UITableView

@property (nonatomic, weak) id<VHLTableViewDelegate> m_delegate;

@end


/**
 如何使用：
 1. 初始化 tableview
 2. 初始化 section
 3. 初始化 cell
 3. 将cell 添加到 section，将section 添加到 tableview
 
 // 导入 -> UITableViewInfo
 核心类：UITableViewInfo / UITableViewSectionInfo / UITableViewCellInfo
 
 _tableViewInfo = [[VHLTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
 _tableViewInfo.delegate = self;
 [self.view addSubview:[_tableViewInfo getTableView]];
 
 
*/

/*
    参考地址
    https://github.com/tianguanghui/PPTableView
 */
