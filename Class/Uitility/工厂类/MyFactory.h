//
//  MyFactory.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyFactory : NSObject

+ (UIButton * )createButton:(CGRect)frame title:(NSString *)title NormalImage:(UIImage *)NormalImage selectedImage:(UIImage *)selectedImage titleColor:(UIColor *)titleColor tint:(UIColor *)tintColor tag:(NSInteger)tag;
+ (UIImageView *)createUIImageView:(CGRect)frame imageName:(NSString *)imageName;
+ (UILabel *)createUIlabel:(CGRect)frame title:(NSString *)title font:(CGFloat)font;
+ (UIButton * )createButton:(CGRect)frame title:(NSString *)title  titleColor:(UIColor *)titleColor  tag:(NSInteger)tag;
+ (UIColor *)createInitColorWithR:(float)r G:(float)g B:(float)b;
+ (NSArray *)allColor;
@end
