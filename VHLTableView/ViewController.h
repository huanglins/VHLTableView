//
//  ViewController.h
//  VHLTableView
//
//  Created by vincent on 2017/9/13.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)addSection:(id)sender;

@end


/*
    https://github.com/tianguanghui/PPTableView
 */

/*
     iOS11 适配 tableView 偏移
 
 #ifdef __IPHONE_11_0
 if ([self.contentTableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
     self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
 }
 #endif
 */
