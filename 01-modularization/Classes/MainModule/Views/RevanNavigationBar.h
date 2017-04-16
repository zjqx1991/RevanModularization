//
//  RevanNavigationBar.h
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/16.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanNavigationBar : UINavigationBar

/**
 设置全局的导航栏背景图片

 @param globalImage 全局导航栏背景图片
 */
+ (void)setGlobalBackGroundImage:(UIImage *)globalImage;

/**
 设置全局导航栏标题颜色和文字大小

 @param globalTextColor 全局导航栏标题颜色
 @param fontSize        全局导航栏文字大小
 */
+ (void)setGlobalTextColor:(UIColor *)globalTextColor fontSize:(CGFloat)fontSize;

@end
