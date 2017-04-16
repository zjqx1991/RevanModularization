//
//  RevanTabBarController.h
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/15.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanTabBarController : UITabBarController

/**
 获取单例对象

 @return TabBarController
 */
+ (instancetype)shareInstance;

/**
 添加子控制器的block

 @param addChildVCBlock 添加代码块
 @return TabBarController
 */
+ (instancetype)revan_tabBarControllerWithAddChildVCsBlock:(void(^)(RevanTabBarController *tabBarVC)) addChildVCBlock;

/**
 添加子控制器

 @param childVC         子控制器
 @param normalImageName 普通状态下图片
 @param selectedName    选中状态下图片
 @param isRequired      是否需要包装导航控制器
 */
- (void)revan_addChildVC:(UIViewController *) childVC normalImageName:(NSString *) normalImageName selectedImageName:(NSString *) selectedName isRequiredNavController:(BOOL) isRequired;

@end
