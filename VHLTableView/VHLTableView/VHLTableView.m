//
//  VHLTableView.m
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableView.h"

@implementation VHLTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        if (style == UITableViewStyleGrouped) {
            self.backgroundView  = nil;
            self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
            self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            self.separatorColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
            self.sectionHeaderHeight = 10.0f;
            self.sectionFooterHeight = 10.0f;
            self.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
        }
        self.tableHeaderView = [UIView new];
        self.tableFooterView = [UIView new];
        //self.sectionIndexColor = [UIColor darkGrayColor];
        self.sectionIndexBackgroundColor = [UIColor clearColor];
        self.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark - touch event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(touchesBegan_TableView:withEvent:)]) {
        [_m_delegate touchesBegan_TableView:touches withEvent:event];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(touchesMoved_TableView:withEvent:)]) {
        [_m_delegate touchesMoved_TableView:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(touchesEnded_TableView:withEvent:)]) {
        [_m_delegate touchesEnded_TableView:touches withEvent:event];
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    if (_m_delegate && [_m_delegate respondsToSelector:@selector(touchesCancelled_TableView:withEvent:)]) {
        [_m_delegate touchesCancelled_TableView:touches withEvent:event];
    }
}

@end
