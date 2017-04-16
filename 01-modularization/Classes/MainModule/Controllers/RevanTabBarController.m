//
//  RevanTabBarController.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/15.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanTabBarController.h"
#import "RevanNavigationViewController.h"
#import "revanBaseModuleManger.h"
#import "RevanTabBar.h"
#import "RevanMiddleView.h"

@interface RevanTabBarController ()

@end

static RevanTabBarController *_tabBarController = nil;
@implementation RevanTabBarController


+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tabBarController = [[RevanTabBarController alloc] init];
    });
    return _tabBarController;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (_tabBarController == nil) {
            _tabBarController = [super allocWithZone:zone];
        }
    });
    return _tabBarController;
}

- (instancetype)copy {
    return self;
}

- (instancetype)mutableCopy {
    return self;
}

+ (instancetype)revan_tabBarControllerWithAddChildVCsBlock:(void (^)(RevanTabBarController *))addChildVCBlock {
    RevanTabBarController *tabBarVC = [[RevanTabBarController alloc] init];
    if (addChildVCBlock) {
        addChildVCBlock(tabBarVC);
    }
    return tabBarVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    ///设置自定义tabBar
    [self setupTabBar];
}

/**
 设置自定义tabBar
 */
- (void)setupTabBar {
    [self setValue:[[RevanTabBar alloc] init] forKey:@"tabBar"];
}

/**
 根据参数，创建并添加对应的子控制器

 @param childVC          需要添加的子控制器
 @param normalImageName  normal状态的图片名称
 @param selectedName     selected状态下的图片名称
 @param isRequired       是否有标题
 */
- (void)revan_addChildVC:(UIViewController *)childVC normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedName isRequiredNavController:(BOOL)isRequired {
    if (isRequired) {
        RevanNavigationViewController *nav = [[RevanNavigationViewController alloc] initWithRootViewController:childVC];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedName]];
        [self addChildViewController:nav];
    }
    else {
        [self addChildViewController:childVC];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    
    UIViewController *vc = self.childViewControllers[selectedIndex];
    if (vc.view.tag == 666) {
        vc.view.tag = 888;
        // 给控制器添加中间的播放视图
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
        [vc.view addSubview:middleView];
//        RevanMiddleView *middleView = [RevanMiddleView shareInstance];
//        middleView.middleClickBlock = [RevanMiddleView shareInstance].middleClickBlock;
//        middleView.isPlaying = [RevanMiddleView shareInstance].isPlaying;
//        middleView.middleImage = [RevanMiddleView shareInstance].middleImage;
//        middleView.x = (RevanScreenWidth - 65) * 0.5;
//        middleView.y = RevanScreenHeight - 65;
//        [vc.view addSubview:middleView];
    }
}

@end
