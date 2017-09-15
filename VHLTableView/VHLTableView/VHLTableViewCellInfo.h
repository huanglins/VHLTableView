//
//  VHLTableViewCellInfo.h
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewUserInfo.h"
#import <UIKit/UIKit.h>

@class VHLTableViewCell;

@interface VHLTableViewCellInfo : VHLTableViewUserInfo

@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, assign) UITableViewCellEditingStyle editStyle;
@property (nonatomic, assign) UITextAutocorrectionType autoCorrectionType;

@property (nonatomic, assign) BOOL bNeedSeperateLine;
@property (nonatomic, assign) SEL  makeSel;
@property (nonatomic, assign) SEL  actionSel;
@property (nonatomic, assign) SEL  calHeightSel;

@property (nonatomic, weak) id makeTarget;
@property (nonatomic, weak) id actionTarget;
@property (nonatomic, weak) id actionTargetForSwitchCell;
@property (nonatomic, weak) id calHeightTarget;

@property (nonatomic, weak) VHLTableViewCell *cell;
@property (nonatomic, assign) CGFloat fCellHeight;

// normal Cell - 普通文字显示的Cell
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue;
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue canRightValueCopy:(BOOL)canCopy;
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType isFixedWidth:(BOOL)fixedWidth;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightView:(UIView *)rightView accessoryType:(UITableViewCellAccessoryType)accessoryType;

+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType isFixedWidth:(BOOL)fixedWidth;
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightView:(UIView *)rightView imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType;

// badge Cell - 带小红点的Cell
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge;
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue;
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue imageName:(NSString *)imageName;


// edit Cell - 带文本框的Cell
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text;
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text;
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin  tip:(NSString*)tip focus:(BOOL)focus text:(NSString *)text;
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin  tip:(NSString*)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text;

// swicth Cell - 开关Cell
+ (instancetype)switchCellForSel:(SEL)sel target:(id)target title:(NSString *)title on:(BOOL)on;

// center Cell - 中间文本Cell
+ (instancetype)centerCellForSel:(SEL)sel target:(id)target title:(NSString *)title;

// custom Cell - 自定义Cell
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget height:(CGFloat)height userInfo:(VHLTableViewUserInfo *)userInfo;
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget height:(CGFloat)height userInfo:(VHLTableViewUserInfo *)userInfo;
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget calHeightSel:(SEL)calHeightSel calHeightTarget:(id)calHeightTarget userInfo:(VHLTableViewUserInfo *)userInfo;

@end
