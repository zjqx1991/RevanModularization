//
//  RevanNavigationBar.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/16.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanNavigationBar.h"

@implementation RevanNavigationBar

/**
 设置全局的导航栏背景图片

 @param globalImage 全局导航栏背景图片
 */
+ (void)setGlobalBackGroundImage:(UIImage *)globalImage {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(@"RevanNavigationController"), nil];
    [navBar setBackgroundImage:globalImage forBarMetrics:UIBarMetricsDefault];
}

+ (void)setGlobalTextColor:(UIColor *)globalTextColor fontSize:(CGFloat)fontSize {
    if (globalTextColor == nil) {
        return;
    }
    if (fontSize < 6 || fontSize > 40) {
        fontSize = 16;
    }
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:NSClassFromString(@"RevanNavigationController"), nil];
    ///设置导航栏颜色
    NSDictionary *titleDic = @{
                               NSForegroundColorAttributeName : globalTextColor,NSFontAttributeName : [UIFont systemFontOfSize:fontSize]
                               };
    [navBar setTitleTextAttributes:titleDic];
}

@end
