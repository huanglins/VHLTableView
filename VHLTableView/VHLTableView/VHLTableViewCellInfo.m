//
//  VHLTableViewCellInfo.m
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLTableViewCellInfo.h"
#import "VHLTableViewCell.h"
// view
#import "VHLMenuLabel.h"
#import "VHLBadgeView.h"

@implementation VHLTableViewCellInfo

- (instancetype)init {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.editStyle = UITableViewCellEditingStyleNone;
        self.autoCorrectionType = UITextAutocorrectionTypeYes;
        self.cellStyle = UITableViewCellStyleValue1;
    }
    return self;
}
// 设置默认的 CELL 高度
+ (void)setDefaultCellHeight {
    
}
#pragma mark - normal Cell -------------------------------------------------------------------------
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:nil target:nil title:title rightValue:rightValue accessoryType:0];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cellInfo;
}
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue canRightValueCopy:(BOOL)canCopy {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:nil target:nil title:title rightValue:rightValue accessoryType:0];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cellInfo addUserInfoValue:@(canCopy) forKey:@"canCopy"];
    return cellInfo;
}
+ (instancetype)normalCellForTitle:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForTitle:title rightValue:rightValue];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title accessoryType:(UITableViewCellAccessoryType)accessoryType {
    return [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:nil accessoryType:accessoryType];
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType {
    return [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightView:nil imageName:imageName accessoryType:accessoryType];
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType {
    VHLTableViewCellInfo *cellInfo = [[VHLTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeNormalCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTarget:target];
    [cellInfo setFCellHeight:DEFAULT_CELL_HEIGHT];
    [cellInfo setAccessoryType:accessoryType];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:rightValue forKey:@"rightValue"];
    
    return cellInfo;
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue accessoryType:(UITableViewCellAccessoryType)accessoryType isFixedWidth:(BOOL)fixedWidth {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue accessoryType:accessoryType];
    [cellInfo addUserInfoValue:@(fixedWidth) forKey:@"isFixedWidth"];
    return cellInfo;
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightView:(UIView *)rightView accessoryType:(UITableViewCellAccessoryType)accessoryType {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:nil accessoryType:accessoryType];
    [cellInfo addUserInfoValue:rightView forKey:@"rightView"];
    return cellInfo;
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue accessoryType:accessoryType];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightValue:(NSString *)rightValue imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType isFixedWidth:(BOOL)fixedWidth {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue imageName:imageName accessoryType:accessoryType];
    [cellInfo addUserInfoValue:@(fixedWidth) forKey:@"isFixedWidth"];
    return cellInfo;
}
+ (instancetype)normalCellForSel:(SEL)sel target:(id)target title:(NSString *)title rightView:(UIView *)rightView imageName:(NSString *)imageName accessoryType:(UITableViewCellAccessoryType)accessoryType {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightView:rightView accessoryType:accessoryType];
    [cellInfo addUserInfoValue:imageName forKey:@"imageName"];
    return cellInfo;
}
// UI
- (void)makeNormalCell:(VHLTableViewCell *)cell {
    _cell = cell;
    NSString *title = [self getUserInfoValueForKey:@"title"];
    UIColor *titleColor = [self getUserInfoValueForKey:@"titleColor"];
    UIFont *titleFont = [self getUserInfoValueForKey:@"titleFont"];
    NSString *rightValue = [self getUserInfoValueForKey:@"rightValue"];
    UIColor *rightValueColor = [self getUserInfoValueForKey:@"rightValueColor"];
    UIFont *rightFont = [self getUserInfoValueForKey:@"rightFont"];
    NSString *imageName = [self getUserInfoValueForKey:@"imageName"];
    UIView *rightView = [self getUserInfoValueForKey:@"rightView"];
    BOOL canCopy = [[self getUserInfoValueForKey:@"canCopy"] boolValue];
    BOOL isFixedWidth = [[self getUserInfoValueForKey:@"isFixedWidth"] boolValue];
    UIView *selectedBackgroundView = [self getUserInfoValueForKey:@"selectedBackgroundView"];
    
    cell.selectionStyle = _selectionStyle;
    cell.accessoryType  = _accessoryType;
    cell.backgroundView.hidden = NO;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    UIImageView *imageView = nil;
    if (imageName.length) {
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(15.0f,
                                     (cell.frame.size.height - imageView.frame.size.height) * 0.5f,
                                     imageView.frame.size.width, imageView.frame.size.height);
        [cell.contentView addSubview:imageView];
    }
    
    UILabel *titleLabel = nil;
    if (title.length) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.textColor = titleColor?:[UIColor blackColor];
        titleLabel.font = titleFont?:[UIFont systemFontOfSize:16.0f];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [titleLabel sizeToFit];
        titleLabel.frame = CGRectMake(15.0f + CGRectGetMaxX(imageView.frame),
                                      (cell.frame.size.height - titleLabel.frame.size.height) * 0.5f,
                                      titleLabel.frame.size.width, titleLabel.frame.size.height);
        [cell.contentView addSubview:titleLabel];
    }
    
    VHLMenuLabel *rightLabel = nil;
    if (rightValue.length) {
        rightLabel = [[VHLMenuLabel alloc] init];
        rightLabel.userInteractionEnabled = YES;
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.text = rightValue;
        rightLabel.font = rightFont?:[UIFont systemFontOfSize:15.0f];
        rightLabel.textColor = rightValueColor?:[UIColor grayColor];
        rightLabel.numberOfLines = isFixedWidth?1:0;
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        CGFloat rightLabelMaxWidth = _cell.bounds.size.width - titleLabel.frame.size.width - 15.0f - 30;
        if (cell.accessoryType != UITableViewCellAccessoryNone) {
            rightLabelMaxWidth -= 23.0f;
        }
        CGFloat rightLabelHeight =  [rightLabel.text vhltableview_sizeWithFont:rightLabel.font maxWidth:rightLabelMaxWidth maxHeight:CGFLOAT_MAX].height;
        [rightLabel sizeToFit];
        CGFloat left = titleLabel.frame.size.width + 15.0f + 20.0f;
        
        rightLabel.frame = CGRectMake(left, (self.fCellHeight - rightLabelHeight) / 2, rightLabelMaxWidth, rightLabelHeight);
        [cell.contentView addSubview:rightLabel];
        
        if (!isFixedWidth && rightLabelHeight > titleLabel.frame.size.height) {
            self.fCellHeight = DEFAULT_CELL_HEIGHT + (rightLabelHeight - titleLabel.frame.size.height);
            titleLabel.center = CGPointMake(titleLabel.center.x, self.fCellHeight / 2);
            rightLabel.center = CGPointMake(rightLabel.center.x, self.fCellHeight / 2);
        }
        // 添加长按拷贝
        if (canCopy) {
            [rightLabel setupCopyMenu];
        }
    }
    
    if (rightView) {
        CGFloat left = _cell.bounds.size.width - rightView.frame.size.width - 10.0f;
        if (cell.accessoryType != UITableViewCellAccessoryNone) {
            left -= 23.0f;
        }
        rightView.frame = CGRectMake(left, (cell.frame.size.height - rightView.frame.size.height) * 0.5f, rightView.frame.size.width, rightView.frame.size.height);
        [cell.contentView addSubview:rightView];
        //rightView.center = CGPointMake(rightView.center.x, cell.contentView.center.y);
    }
    // ------------------------------- 小红点 -------------------------------
    NSString *badge = [self getUserInfoValueForKey:@"badge"];
    if (badge.length) {
        VHLBadgeView *badgeView = [[VHLBadgeView alloc] initWithFrame:CGRectZero];
        [badgeView setString:badge];
        badgeView.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 15.0f, 0, badgeView.frame.size.width, badgeView.frame.size.height);
        badgeView.center = CGPointMake(badgeView.center.x, titleLabel.center.y);
        [cell.contentView addSubview:badgeView];
    }
}
#pragma mark - badge Cell -------------------------------------------------------------------------
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:nil accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cellInfo addUserInfoValue:badge forKey:@"badge"];
    return cellInfo;
}
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cellInfo addUserInfoValue:badge forKey:@"badge"];
    return cellInfo;
}
+ (instancetype)badgeCellForSel:(SEL)sel target:(id)target title:(NSString *)title badge:(NSString *)badge rightValue:(NSString *)rightValue imageName:(NSString *)imageName {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo normalCellForSel:sel target:target title:title rightValue:rightValue imageName:imageName accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cellInfo addUserInfoValue:badge forKey:@"badge"];
    return cellInfo;
}
#pragma mark - edit Cell -------------------------------------------------------------------------
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus text:(NSString *)text {
    return [VHLTableViewCellInfo editorCellForSel:sel target:target title:nil margin:0 tip:tip focus:focus text:text];
}
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target tip:(NSString *)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text {
    return [VHLTableViewCellInfo editorCellForSel:sel target:target title:nil margin:0 tip:tip focus:focus autoCorrect:autoCorrect text:text];
}
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin  tip:(NSString*)tip focus:(BOOL)focus text:(NSString *)text {
    return [VHLTableViewCellInfo editorCellForSel:sel target:target title:title margin:margin tip:tip focus:focus autoCorrect:NO text:text];
}
+ (instancetype)editorCellForSel:(SEL)sel target:(id)target title:(NSString *)title margin:(CGFloat)margin  tip:(NSString*)tip focus:(BOOL)focus autoCorrect:(BOOL)autoCorrect text:(NSString *)text {
    VHLTableViewCellInfo *cellInfo = [[VHLTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeEditorCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTarget:target];
    [cellInfo setFCellHeight:DEFAULT_CELL_HEIGHT];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cellInfo setAccessoryType:UITableViewCellAccessoryNone];
    UITextAutocorrectionType autocorrectionType = UITextAutocorrectionTypeNo;
    if (autoCorrect) {
        autocorrectionType = UITextAutocorrectionTypeYes;
    }
    [cellInfo setAutoCorrectionType:autocorrectionType];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:tip forKey:@"tip"];
    [cellInfo addUserInfoValue:text forKey:@"text"];
    [cellInfo addUserInfoValue:@(margin) forKey:@"fEditorLMargin"];
    [cellInfo addUserInfoValue:@(focus) forKey:@"focus"];
    
    return cellInfo;
}
- (void)makeEditorCell:(VHLTableViewCell *)cell {
    _cell = cell;
    NSString *title = [self getUserInfoValueForKey:@"title"];
    NSString *text = [self getUserInfoValueForKey:@"text"];
    NSString *tip = [self getUserInfoValueForKey:@"tip"];
    UIFont *font = [self getUserInfoValueForKey:@"font"];
    BOOL focus = [[self getUserInfoValueForKey:@"focus"] boolValue];
    BOOL secureTextEntry = [[self getUserInfoValueForKey:@"secureTextEntry"] boolValue];
    UIKeyboardType keyboardType = [[self getUserInfoValueForKey:@"keyboardType"] integerValue];
    CGFloat margin = [[self getUserInfoValueForKey:@"fEditorLMargin"] floatValue];
    UIView *selectedBackgroundView = [self getUserInfoValueForKey:@"selectedBackgroundView"];
    
    CGFloat left = 15.0f;
    CGFloat screenWidth = _cell.bounds.size.width;
    if (title.length) {
        cell.textLabel.text = title;
        left += [title vhltableview_sizeWithFont:[UIFont systemFontOfSize:17.0f] maxWidth:screenWidth maxHeight:CGFLOAT_MAX].width + margin + 15.0f;
    }
    CGRect textFieldFrame = CGRectMake(left, 0, screenWidth - left - 5, cell.bounds.size.height);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.borderStyle = UITextBorderStyleNone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.keyboardType = keyboardType;
    textField.font = font;
    textField.autocorrectionType = _autoCorrectionType;
    textField.returnKeyType = UIReturnKeyDone;
    textField.enablesReturnKeyAutomatically = YES;
    textField.secureTextEntry = secureTextEntry;
    if ([_actionTarget conformsToProtocol:@protocol(UITextFieldDelegate)]) {
        textField.delegate = _actionTarget;
    }
    [textField addTarget:self action:@selector(actionEditorCell:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:_actionTarget action:_actionSel forControlEvents:UIControlEventEditingDidEndOnExit];
    textField.text = text;
    textField.placeholder = tip;
    if (focus) {
        [textField becomeFirstResponder];
    }
    [cell.contentView addSubview:textField];
    cell.selectionStyle = _selectionStyle;
    cell.accessoryType = _accessoryType;
    cell.selectedBackgroundView = selectedBackgroundView;
    [self addUserInfoValue:textField forKey:@"editor"];
}
- (void)actionEditorCell:(UITextField *)textField {
    if (textField.text.length) {
        [self addUserInfoValue:textField.text forKey:@"text"];
    } else {
        [self addUserInfoValue:@"" forKey:@"text"];
    }
}
#pragma mark - swicth Cell -------------------------------------------------------------------------
+ (instancetype)switchCellForSel:(SEL)sel target:(id)target title:(NSString *)title on:(BOOL)on {
    VHLTableViewCellInfo *cellInfo = [[VHLTableViewCellInfo alloc] init];
    [cellInfo setMakeSel:@selector(makeSwitchCell:)];
    [cellInfo setMakeTarget:cellInfo];
    [cellInfo setActionSel:sel];
    [cellInfo setActionTargetForSwitchCell:target];
    [cellInfo setFCellHeight:DEFAULT_CELL_HEIGHT];
    [cellInfo setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cellInfo setAccessoryType:UITableViewCellAccessoryNone];
    [cellInfo addUserInfoValue:title forKey:@"title"];
    [cellInfo addUserInfoValue:@(on) forKey:@"on"];
    return cellInfo;
}
- (void)makeSwitchCell:(VHLTableViewCell *)cell {
    [self makeNormalCell:cell];
    BOOL on = [[self getUserInfoValueForKey:@"on"] boolValue];
    UISwitch *switchView = [[UISwitch alloc] init];
    [switchView addTarget:self action:@selector(actionSwitchCell:) forControlEvents:UIControlEventValueChanged];
    [switchView addTarget:_actionTargetForSwitchCell action:_actionSel forControlEvents:UIControlEventValueChanged];
    [switchView setOn:on];
    [cell setAccessoryView:switchView];
    [self addUserInfoValue:switchView forKey:@"switch"];
}
- (void)actionSwitchCell:(UISwitch *)switchView {
    [self addUserInfoValue:@(switchView.isOn) forKey:@"on"];
}
#pragma mark - center Cell -------------------------------------------------------------------------
+ (instancetype)centerCellForSel:(SEL)sel target:(id)target title:(NSString *)title {
    VHLTableViewCellInfo *cellInfo = [[VHLTableViewCellInfo alloc] init];
    cellInfo.makeSel = @selector(makeCenterCell:);
    cellInfo.makeTarget = cellInfo;
    cellInfo.actionSel = sel;
    cellInfo.actionTarget = target;
    cellInfo.fCellHeight = DEFAULT_CELL_HEIGHT;
    cellInfo.accessoryType = UITableViewCellAccessoryNone;
    cellInfo.cellStyle = UITableViewCellStyleDefault;
    [cellInfo addUserInfoValue:title forKey:@"title"];
    return cellInfo;
}
- (void)makeCenterCell:(VHLTableViewCell *)cell {
    _cell = cell;
    NSString *title = [self getUserInfoValueForKey:@"title"];
    UIColor *titleColor = [self getUserInfoValueForKey:@"titleColor"];
    UIFont *titleFont = [self getUserInfoValueForKey:@"titleFont"];
    UIView *selectedBackgroundView = [self getUserInfoValueForKey:@"selectedBackgroundView"];
    
    cell.textLabel.text = title;
    cell.textLabel.font = titleFont?:[UIFont systemFontOfSize:17.0f];
    cell.textLabel.textColor = titleColor?:[UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = _selectionStyle;
    cell.accessoryType = _accessoryType;
    cell.selectedBackgroundView = selectedBackgroundView;
}
#pragma mark - custom Cell -------------------------------------------------------------------------
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget height:(CGFloat)height userInfo:(VHLTableViewUserInfo *)userInfo {
    VHLTableViewCellInfo *cellInfo = [VHLTableViewCellInfo cellForMakeSel:makeSel
                                                               makeTarget:makeTarget
                                                                actionSel:nil actionTarget:nil
                                                                   height:height userInfo:userInfo];
    cellInfo.selectionStyle = UITableViewCellSelectionStyleNone;
    cellInfo.accessoryType = UITableViewCellAccessoryNone;
    return cellInfo;
}
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget height:(CGFloat)height userInfo:(VHLTableViewUserInfo *)userInfo {
    VHLTableViewCellInfo *cellInfo = [[VHLTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.fCellHeight = height;
    cellInfo.userInfo = userInfo;
    
    return cellInfo;
}
+ (instancetype)cellForMakeSel:(SEL)makeSel makeTarget:(id)makeTarget actionSel:(SEL)actionSel actionTarget:(id)actionTarget calHeightSel:(SEL)calHeightSel calHeightTarget:(id)calHeightTarget userInfo:(VHLTableViewUserInfo *)userInfo {
    VHLTableViewCellInfo *cellInfo = [[VHLTableViewCellInfo alloc] init];
    cellInfo.makeSel = makeSel;
    cellInfo.makeTarget = makeTarget;
    cellInfo.actionSel = actionSel;
    cellInfo.actionTarget = actionTarget;
    cellInfo.calHeightSel = calHeightSel;
    cellInfo.calHeightTarget = calHeightTarget;
    cellInfo.userInfo = userInfo;
    return cellInfo;
}
@end
