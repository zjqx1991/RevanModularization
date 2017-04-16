//
//  RevanTabBar.h
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/15.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanTabBar : UITabBar

/**
 点击中间按钮的执行代码块
 */
@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);

@end
