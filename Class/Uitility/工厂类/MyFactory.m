//
//  MyFactory.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyFactory.h"

@implementation MyFactory

+ (UIButton * )createButton:(CGRect)frame title:(NSString *)title NormalImage:(UIImage *)NormalImage selectedImage:(UIImage *)selectedImage titleColor:(UIColor *)titleColor tint:(UIColor *)tintColor tag:(NSInteger)tag{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:NormalImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTintColor:tintColor];
    button.frame = frame;
    button.tag = tag;
    return button;
}

+ (UIImageView *)createUIImageView:(CGRect)frame imageName:(NSString *)imageName{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d@2x.png",imageName,1]];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int index = 1; index<= 6; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d@2x.png",imageName,index]];
        [imageArray addObject:image];
    }

    imageView.animationImages = imageArray;
    imageView.animationDuration = 0.5;
    imageView.animationRepeatCount = 0;
    return imageView;
}

+ (UILabel *)createUIlabel:(CGRect)frame title:(NSString *)title font:(CGFloat)font{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

+ (UIButton * )createButton:(CGRect)frame title:(NSString *)title  titleColor:(UIColor *)titleColor  tag:(NSInteger)tag{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.frame = frame;
    button.tag = tag;
    return button;
}
+ (UIColor *)createInitColorWithR:(float)r G:(float)g B:(float)b{
    UIColor * color = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
    return color;
}

+ (NSArray *)allColor{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    UIColor * color = [self createInitColorWithR:239 G:141 B:140];
    
    UIColor * color1 = [self createInitColorWithR:140 G:167 B:180];
    
    UIColor * color2 = [self createInitColorWithR:141 G:178 B:91];
    
    UIColor * color3 = [self createInitColorWithR:223 G:127 B:75];
    
    UIColor * color5 = [self createInitColorWithR:239 G:100 B:121];
    
    UIColor * color7 = [self createInitColorWithR:166 G:134 B:202];
    
    UIColor * color8 = [self createInitColorWithR:139 G:165 B:177];
    
    UIColor * color9 = [self createInitColorWithR:239 G:100 B:121];
    [array addObject:color];
    [array addObject:color1];
    [array addObject:color2];
    [array addObject:color3];
    [array addObject:color3];
    [array addObject:color5];
    [array addObject:color1];
    [array addObject:color7];
    [array addObject:color2];
    
    
    [array addObject:color3];
    [array addObject:color1];
    [array addObject:color8];
    [array addObject:color7];
    [array addObject:color2];
    [array addObject:color3];
    [array addObject:color3];
    [array addObject:color9];
    [array addObject:color1];
    
   
    
    return array;
}
@end













