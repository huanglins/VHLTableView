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


/*
    参考地址
    https://github.com/tianguanghui/PPTableView
 */
