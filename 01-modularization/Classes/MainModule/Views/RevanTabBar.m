//
//  RevanTabBar.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/15.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanTabBar.h"
#import "RevanMiddleView.h"
#import "revanBaseModuleManger.h"

@interface RevanTabBar ()
/** 中间视图 */
@property (nonatomic,weak) RevanMiddleView *middleView;

@end

@implementation RevanTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    ///设置样式，去除tabbar上面的黑线
    self.barStyle = UIBarStyleBlack;
    ///设置tabbar背景图片
    self.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
}

#pragma mark - 中间视图view懒加载
- (RevanMiddleView *)middleView {
    if (_middleView == nil) {
        RevanMiddleView *middleView = [RevanMiddleView shareInstance];
        [self addSubview:middleView];
        _middleView = middleView;
    }
    return _middleView;
}

- (void)setMiddleClickBlock:(void (^)(BOOL))middleClickBlock {
    self.middleView.middleClickBlock = middleClickBlock;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger countItems = self.items.count;
    CGFloat itemW = self.width / (countItems + 1);
    CGFloat itemH = self.height;
    CGFloat itemY = 5.0;
    ///记录下标
    NSInteger index = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            ///处理中间位置
            if (index == countItems / 2) {CGFloat width = 65;
                CGFloat height = 65;
                self.middleView.frame = CGRectMake((RevanScreenWidth - width) * 0.5, (RevanScreenHeight - height), width, height);
                index++;
            }
            CGFloat itemX = index * itemW;
            subView.frame = CGRectMake(itemX, itemY, itemW, itemH);
            index++;
        }
        self.middleView.centerX = self.frame.size.width * 0.5;
        self.middleView.y = self.height - self.middleView.height;
    }
}

/**
 处理中间view超出父控件部分点击无响应

 @param point <#point description#>
 @param event <#event description#>
 @return <#return value description#>
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    ///设置允许交互的区域
    ///转换点击在tabbar上的坐标点，到中间按钮上
    CGPoint pointInMiddleView = [self convertPoint:point toView:self.middleView];
    ///确定中共建按钮的圆心
    CGPoint middleViewCenter = CGPointMake(33, 33);
    ///计算点击的位置距离圆心的距离
    CGFloat distance = sqrt(pow(pointInMiddleView.x - middleViewCenter.x, 2) + pow(pointInMiddleView.y - middleViewCenter.y, 2));
    ///判定中共建按钮区域之外
    if (distance > 33 && pointInMiddleView.y < 18) {
        return NO;
    }
    
    return YES;
}

@end
