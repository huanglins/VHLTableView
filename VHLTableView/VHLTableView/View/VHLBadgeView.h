//
//  VHLBadgeView.h
//  VHLTableView
//
//  Created by vincent on 2017/9/14.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    小红点View
 */
@interface VHLBadgeView : UIImageView

@property (nonatomic, assign) CGFloat m_range;
@property (nonatomic, assign) CGFloat fAddedWidth;
@property (nonatomic, assign) CGFloat fOriginWidth;
@property (nonatomic, assign) CGPoint pOriginPoint;

- (void)setUpView;
- (UILabel *)labelView;
- (void)setValue:(NSUInteger)value;
- (void)setString:(NSString *)string;

- (void)setString:(NSString *)string dogImage:(UIImage *)image;

@end
