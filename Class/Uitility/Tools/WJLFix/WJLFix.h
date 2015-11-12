//
//  WJLFix.h
//  MyFm
//
//  Created by Qianfeng on 15/10/28.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJLFix : NSObject

+ (CGFloat)FontWithScreenWidth:(CGFloat)ScreenWidth;

+ (UIEdgeInsets)tabBarButtonEdge:(CGFloat)ScreenWidth;

+ (CGFloat)numberForwidth:(CGFloat)ScreenWidth;
+ (CGFloat)firstHotFix:(CGFloat)ScreenHeight;
+ (CGFloat)firstNewFix:(CGFloat)ScreenHeight;
+ (CGFloat)secondTableLabelHeightFix:(CGFloat)ScreenHeight;
+(CGFloat)SettingButton:(CGFloat)ScreenHeight;
+(CGFloat)SettingButtonLine:(CGFloat)ScreenHeight;
@end
