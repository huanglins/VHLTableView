//
//  ViewController.m
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "ViewController.h"
#import "VHLTableViewInfo.h"
#import "VHLTableViewSectionInfo.h"
#import "VHLTableViewCellInfo.h"

@interface ViewController () <VHLTableViewInfoDelegate, UITextFieldDelegate>
@property (nonatomic, strong) VHLTableViewInfo *tableViewInfo;
@property (nonatomic, weak) UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableViewInfo = [[VHLTableViewInfo alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableViewInfo.delegate = self;
    //[_tableViewInfo getTableView].backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_image.jpg"]];
    [self.view addSubview:[_tableViewInfo getTableView]];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self createNormalSection];
    [self createNormalSection1];
    [self createNormalSection11];
    [self createSwitchSection];
    [self createNormalSection2];
    [self createNormalSection3];
    [self createCenterSection];
}

- (void)createNormalSection {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_5"]];
    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:)
                                                                          target:self
                                                                            title:@"多语言"
                                                                        rightView:imageView
                                                                   accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"s_5"]];
    VHLTableViewCellInfo *normalCellInfo1 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:)
                                                                           target:self
                                                                            title:@"多语言"
                                                                        rightView:imageView1 imageName:@"s_5"
                                                                    accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:normalCellInfo1];
    [_tableViewInfo addSection:sectionInfo];
}
- (void)createNormalSection11 {
    
    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo editorCellForSel:@selector(cellInfo:) target:self title:@"姓名" margin:2 tip:@"请输入姓名" focus:NO text:@""];
    VHLTableViewCellInfo *badgeCellInfo = [VHLTableViewCellInfo badgeCellForSel:@selector(cellInfo:) target:self title:@"游戏" badge:@"New"];
    VHLTableViewCellInfo *badgeCellInfo1 = [VHLTableViewCellInfo badgeCellForSel:@selector(cellInfo:) target:self title:@"游戏" badge:@"1" rightValue:@"战报更新"];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:badgeCellInfo];
    [sectionInfo addCell:badgeCellInfo1];
    [_tableViewInfo addSection:sectionInfo];
}
- (void)createNormalSection1 {
    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"字体大小" rightValue:nil imageName:@"s_1" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    VHLTableViewCellInfo *normalCellInfo1 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"聊天背景" rightValue:nil imageName:@"s_2" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    VHLTableViewCellInfo *normalCellInfo2 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"我的表情" rightValue:nil imageName:@"s_3" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    VHLTableViewCellInfo *normalCellInfo3 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"照片和视频" rightValue:nil imageName:@"s_4" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:normalCellInfo1];
    [sectionInfo addCell:normalCellInfo2];
    [sectionInfo addCell:normalCellInfo3];
    [_tableViewInfo addSection:sectionInfo];
}
- (void)createSwitchSection {
    VHLTableViewCellInfo *switchCellInfo = [VHLTableViewCellInfo switchCellForSel:@selector(on:) target:self title:@"听筒模式" on:YES];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:switchCellInfo];
    [_tableViewInfo addSection:sectionInfo];
}
- (void)createNormalSection2 {
    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"性别" rightValue:@"男" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    VHLTableViewCellInfo *normalCellInfo1 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"地区" rightValue:@"中国 重庆" accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    VHLTableViewCellInfo *normalCellInfo2 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"个性签名" rightValue:@"你那么擅长安慰他人，一定度过了很多自己安慰自己的日子吧。" accessoryType:UITableViewCellAccessoryDisclosureIndicator isFixedWidth:YES];
    VHLTableViewCellInfo *normalCellInfo3 = [VHLTableViewCellInfo normalCellForTitle:@"签名" rightValue:@"我突然发现爱情公寓中有个神秘人物，提到他频率很高，却从未露面，他叫楼下小黑。" canRightValueCopy:YES];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:normalCellInfo1];
    [sectionInfo addCell:normalCellInfo2];
    [sectionInfo addCell:normalCellInfo3];
    [_tableViewInfo addSection:sectionInfo];
}
- (void)createNormalSection3 {
    
    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:)
                                                                           target:self
                                                                            title:@"聊天记录迁移"
                                                                    accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    VHLTableViewCellInfo *normalCellInfo1 = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:)
                                                                           target:self
                                                                            title:@"存储空间"
                                                                    accessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:normalCellInfo1];
    [_tableViewInfo addSection:sectionInfo];
}
- (void)createCenterSection {
    VHLTableViewCellInfo *centerCellInfo = [VHLTableViewCellInfo centerCellForSel:@selector(cellInfo:) target:self title:@"清空聊天记录"];
    [centerCellInfo addUserInfoValue:[UIColor redColor] forKey:@"titleColor"];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoHeader:@""];
    [sectionInfo addCell:centerCellInfo];
    [_tableViewInfo addSection:sectionInfo];
}
#pragma mark - delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[self.tableViewInfo getTableView] endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"开始编辑内容");
}
#pragma mark ---------------------------------------------------------------------------------------
- (void)on:(UISwitch *)switchView
{
    NSLog(@"%d", switchView.isOn);
}
- (void)cellInfo:(UITableViewCell *)cell {
    NSLog(@"cell");
}

- (IBAction)addSection:(id)sender {
    // 插入Cell
//    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo normalCellForSel:@selector(cellInfo:) target:self title:@"男" rightValue:@"" accessoryType:UITableViewCellAccessoryCheckmark];
//    [self.tableViewInfo  addCell:normalCellInfo At:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    // 插入分组
    VHLTableViewCellInfo *normalCellInfo = [VHLTableViewCellInfo editorCellForSel:@selector(cellInfo:) target:self title:@"姓名" margin:2 tip:@"请输入姓名" focus:NO text:@""];
    VHLTableViewCellInfo *badgeCellInfo = [VHLTableViewCellInfo badgeCellForSel:@selector(cellInfo:) target:self title:@"游戏" badge:@"1"];
    
    VHLTableViewSectionInfo *sectionInfo = [VHLTableViewSectionInfo sectionInfoDefault];
    [sectionInfo addCell:normalCellInfo];
    [sectionInfo addCell:badgeCellInfo];
    //[_tableViewInfo addSection:sectionInfo];
    [_tableViewInfo insertSection:sectionInfo At:1];
    
    // 删除
    //[_tableViewInfo removeSection:0];
    //[_tableViewInfo removeCellAt:[NSIndexPath indexPathForRow:0 inSection:0]];
}
@end
