//
//  RevanNavigationViewController.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/16.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanNavigationViewController.h"
#import "RevanNavigationBar.h"
#import "RevanMiddleView.h"

@interface RevanNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation RevanNavigationViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setValue:[[RevanNavigationBar alloc] init] forKey:@"navigationBar"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupGestureRecognizer];
}

/**
 初始化手势
 */
- (void)setupGestureRecognizer {
    //设置手势代理
    UIGestureRecognizer *gester = self.interactivePopGestureRecognizer;
    //自定义手势
    //手势加载谁身上，手势执行谁的什么方法
    UIPanGestureRecognizer *panGester = [[UIPanGestureRecognizer alloc] initWithTarget:gester.delegate action:NSSelectorFromString(@"handleNavigationTransition")];
    //其实就是控制器的容器视图
    [gester.view addGestureRecognizer:panGester];
    gester.delaysTouchesBegan = YES;
    panGester.delegate = self;
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    ///拦截每一个push的控制器，进行统一设置
    ///过滤第一个根控制器
    if (self.childViewControllers.count > 0) {
        // 统一设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_n"] style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(@"back")];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
    if (viewController.view.tag == 666) {
        viewController.view.tag = 888;
        RevanMiddleView *middleView = [RevanMiddleView middleView];
        
        middleView.middleClickBlock = [RevanMiddleView shareInstance].middleClickBlock;
        middleView.isPlaying = [RevanMiddleView shareInstance].isPlaying;
        middleView.middleImage = [RevanMiddleView shareInstance].middleImage;
        
        CGRect frame = middleView.frame;
        frame.size.width = 65;
        frame.size.height = 65;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        frame.origin.x = (screenSize.width - 65) * 0.5;
        frame.origin.y = screenSize.height - 65;
        middleView.frame = frame;
        [viewController.view addSubview:middleView];
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    //如果根控制器也要返回手势有效，就会造成假死状态
    //所以，需要过滤根控制器
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    return YES;
}

@end
