//
//  RevanMiddleView.h
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/15.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevanMiddleView : UIView

/**
 创建单例方法

 @return RevanMiddleView
 */
+ (nonnull instancetype)shareInstance;

+ (instancetype)middleView;

/** 控制是否正在播放 */
@property (nonatomic,assign) BOOL isPlaying;

/** 中间图片 */
@property (nonatomic,strong) UIImage *middleImage;

@property (nonatomic, copy) void(^middleClickBlock)(BOOL isPlaying);

@end
