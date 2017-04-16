//
//  RevanMiddleView.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/15.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "RevanMiddleView.h"
#import "revanBaseModuleManger.h"


static NSString *RevanPlayAnnimation = @"playAnnimation";
static NSString *RevanNotificationNamePlayState = @"RevanNotificationNamePlayState";
static NSString *RevanNotificationNamePlayImage = @"RevanNotificationNamePlayImage";

@interface RevanMiddleView ()

/**
 播放内容视图
 */
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;

/**
 播放按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation RevanMiddleView

static RevanMiddleView *_revanMiddleView = nil;

+ (nonnull instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _revanMiddleView = [RevanMiddleView middleView];
    });
    return _revanMiddleView;
}

#pragma mark - 加载xib文件
+ (instancetype)middleView {
    RevanMiddleView *middleView = [[[NSBundle mainBundle] loadNibNamed:@"RevanMiddleView" owner:nil options:nil] firstObject];
    return middleView;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (_revanMiddleView == nil) {
            _revanMiddleView = [super allocWithZone:zone];
        }
    });
    return _revanMiddleView;
}

- (instancetype)copy {
    return self;
}

- (instancetype)mutableCopy {
    return self;
}

#pragma mark - 初始化xib
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.middleImageView.layer.masksToBounds = YES;
    self.middleImage = self.middleImageView.image;
    [self.middleImageView.layer removeAnimationForKey:RevanPlayAnnimation];
    ///给中间的内容视图添加图层动画
    [self.middleImageView.layer revan_rotationBasicAnnimationKeyPath:@"transform.rotation.z" key:RevanPlayAnnimation];
    ///监听按钮的点击事件
    [self.playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    ///监听播放状态的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isPlayerPlay:) name:RevanNotificationNamePlayState object:nil];
    ///监听播放图片的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setPlayImage:) name:RevanNotificationNamePlayImage object:nil];
}

#pragma mark - 监听播放按钮的点击
- (void)playButtonClick:(UIButton *)btn {
    ///执行block
    if (self.middleClickBlock) {
        self.middleClickBlock(self.isPlaying);
    }
}

#pragma mark - 监听播放状态通知
- (void)isPlayerPlay:(NSNotification *)notification {
    self.isPlaying = [notification.object boolValue];

}

#pragma mark - 监听当前播放图片
- (void)setPlayImage:(NSNotification *)notification {
    UIImage *img = [notification object];
    self.middleImage = img;
}

#pragma mark - 播放状态的set方法
- (void)setIsPlaying:(BOOL)isPlaying {
    if (_isPlaying == isPlaying) {
        return;
    }
    _isPlaying = isPlaying;
    if (isPlaying) {
        [self.playButton setImage:nil forState:UIControlStateNormal];
        [self.middleImageView.layer revan_resumeAnimate];
    }
    else {
        UIImage *image = [UIImage imageNamed:@"tabbar_np_play"];
        [self.playButton setImage:image forState:UIControlStateNormal];
        [self.middleImageView.layer revan_pauseAnimate];
    }
}

#pragma mark - 播放内容图片的set方法
- (void)setMiddleImage:(UIImage *)middleImage {
    _middleImage = middleImage;
    self.middleImageView.image = middleImage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.middleImageView.layer.cornerRadius = self.middleImageView.frame.size.width * 0.5;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
