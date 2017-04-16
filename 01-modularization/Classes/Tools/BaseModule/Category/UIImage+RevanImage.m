//
//  UIImage+RevanImage.m
//  01-modularization
//
//  Created by 紫荆秋雪 on 2017/4/16.
//  Copyright © 2017年 Revan. All rights reserved.
//

#import "UIImage+RevanImage.h"

@implementation UIImage (RevanImage)

+ (UIImage *)originImageWithName:(NSString *)name {
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)circleImage {
    CGSize size = self.size;
    CGFloat drawWH = size.width < size.height ? size.width : size.height;
    
    ///开启图形上下文
    UIGraphicsBeginImageContext(CGSizeMake(drawWH, drawWH));
    ///绘制一个圆形区域，进行裁剪
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect clipRect = CGRectMake(0, 0, drawWH, drawWH);
    CGContextAddEllipseInRect(context, clipRect);
    CGContextClip(context);
    ///绘制大图片
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    [self drawInRect:drawRect];
    ///取出结果图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    ///关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
