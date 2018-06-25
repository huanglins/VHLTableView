//
//  VHLBadgeView.m
//  VHLTableView
//
//  Created by vincent on 2017/9/14.
//  Copyright © 2017年 Darnel Studio. All rights reserved.
//

#import "VHLBadgeView.h"

@implementation VHLBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpView];
    }
    return self;
}
#pragma mark - init
- (void)setUpView {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    label.tag = 10032;
    [self addSubview:label];
    _pOriginPoint = CGPointZero;
    _fAddedWidth = 20.0f;
}

- (UILabel *)labelView {
    return [self viewWithTag:10032];
}
#pragma mark - setter
- (void)setValue:(NSUInteger)value {
    if (value >= 100) {
        [self setString:@(value).stringValue];
    } else {
        [self setString:[NSString stringWithFormat:@"%zd", value]];
    }
}

- (void)setString:(NSString *)string {
    BOOL isPureNumandCharacters = [self isPureNumandCharacters:string];
    [self setStringImage:isPureNumandCharacters dotImage:nil];
    UILabel *label = [self labelView];
    label.hidden = NO;
    if (isPureNumandCharacters) {
        label.text = string;
    } else {
        label.text = [string lowercaseString];
    }
    [label sizeToFit];
    if (isPureNumandCharacters) {
        self.bounds = CGRectMake(0, 0, self.image.size.width, self.image.size.height);
    } else {
        self.bounds = CGRectMake(0, 0, label.frame.size.width + 20.0f, label.frame.size.height + 20.0f);
    }
    label.center = CGPointMake(self.frame.size.width * 0.5f, self.frame.size.height * 0.5f);
}
- (void)setString:(NSString *)string dogImage:(UIImage *)image {
    [self setString:string];
    BOOL isPureNumandCharacters = [self isPureNumandCharacters:string];
    [self setStringImage:isPureNumandCharacters dotImage:image];
}
#pragma mark - private
- (BOOL)isPureNumandCharacters:(NSString *)string {
    if (string.length <= 1) {
        if ([string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]].length == 0) {
            return YES;
        }
    }
    return NO;
}

- (void)setStringImage:(BOOL)isPureNumandCharacters dotImage:(UIImage *)image {
    if (!image) {
        image = [UIImage imageNamed:@"vhltableview_badge"];
    }
    if (isPureNumandCharacters) {
        self.image = image;
    } else {
        self.image = [image stretchableImageWithLeftCapWidth:15.0f topCapHeight:0];
    }
}

@end
