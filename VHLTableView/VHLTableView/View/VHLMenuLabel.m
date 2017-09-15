//
//  VHLMenuLabel.m
//  VHLTableView
//
//  Created by vincent on 2017/9/14.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLMenuLabel.h"

@implementation VHLMenuLabel

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
// 初始化长按手势
- (void)setupCopyMenu {
    self.userInteractionEnabled = YES;
    // 长按手势
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)]];
    // 菜单隐藏监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuItemHidden:)name:UIMenuControllerWillHideMenuNotification object:nil];
}

- (void)longPress {
    self.backgroundColor = [UIColor colorWithRed:0.78 green:0.78 blue:0.80 alpha:1.00];
    
    //1.设置label为第一响应者
    //通过设置第一响应者UIMenuController可以获得支持哪些操作的信息,操作怎么处理
    [self becomeFirstResponder];
    
    //2.设置UIMenuController
    UIMenuController * menu = [UIMenuController sharedMenuController];
    //当长按label的时候，这个方法会不断调用，menu就会出现一闪一闪不断显示，需要在此处进行判断
    if (menu.isMenuVisible) return;
    
    //自定义 UIMenuController
    UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuCopyContent:)];
    menu.menuItems = @[item1];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}
#pragma mark - notification
- (void)menuItemHidden:(NSNotification *)noti {
    self.backgroundColor = [UIColor clearColor];
}
- (void)menuCopyContent:(id)sender {
    [UIPasteboard generalPasteboard].string = self.text;
    self.backgroundColor = [UIColor clearColor];
}
#pragma mark - 对控件权限进行设置
/**
 *  设置label可以成为第一响应者
 *
 *  @注意：不是每个控件都有资格成为第一响应者
 */
- (BOOL)canBecomeFirstResponder {
    return YES;
}
/**
 *  设置label能够执行那些具体操作
 *
 *  @param action 具体操作
 *
 *  @return YES:支持该操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(menuCopyContent:));
}

@end
