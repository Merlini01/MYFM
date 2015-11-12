//
//  WJLFix.m
//  MyFm
//
//  Created by Qianfeng on 15/10/28.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "WJLFix.h"

@implementation WJLFix

+ (CGFloat)FontWithScreenWidth:(CGFloat)ScreenWidth{
    //6 plus
    if (ScreenWidth == 414) {
        return 15;
    }else if(ScreenWidth == 375){
        return 13;
    }else if(ScreenWidth == 320){
        return 11;
    }
    return 0;
}

+ (UIEdgeInsets)tabBarButtonEdge:(CGFloat)ScreenWidth{
    //6
    if (ScreenWidth == 375) {
        return UIEdgeInsetsMake(30, - WWidth / 4 / 1.9, 0, 0);
    }else if(ScreenWidth == 414){
        //6plus
        return UIEdgeInsetsMake(30, - WWidth / 4 / 2.1, 0, 0);
    }else if(ScreenWidth == 320){
        //5 4
        return UIEdgeInsetsMake(30, - WWidth / 4 / 1.65, 0, 0);
    }
    return UIEdgeInsetsMake(30, - WWidth / 4 / 2.1, 0, 0);
}

+ (CGFloat)numberForwidth:(CGFloat)ScreenWidth{
    //6 plus
    if (ScreenWidth == 414) {
        return 8;
    }else if(ScreenWidth == 375){
        return 6;
    }else if(ScreenWidth == 320){
        return 2;
    }
    return 0;
}

//首页热门推荐高度适配
+ (CGFloat)firstHotFix:(CGFloat)ScreenHeight{
    if (ScreenHeight == 736) {
        return ScreenHeight / 4 + 10;
    }else if(ScreenHeight == 667){
        return ScreenHeight / 4 + 10;
    }else if(ScreenHeight == 568){
        return ScreenHeight / 4 + 20;;
    }else if(ScreenHeight == 480){
        return ScreenHeight / 4 + 35;;
    }
    return 0;
}

//首页最新高度适配
+ (CGFloat)firstNewFix:(CGFloat)ScreenHeight{
    if (ScreenHeight == 736) {
        return ScreenHeight / 3;
    }else if(ScreenHeight == 667){
        return ScreenHeight / 3 ;
    }else if(ScreenHeight == 568){
        return ScreenHeight / 3 ;
    }else if(ScreenHeight == 480){
        return ScreenHeight / 3 + 15;
    }
    return 0;
}
+ (CGFloat)secondTableLabelHeightFix:(CGFloat)ScreenHeight{
    if (ScreenHeight == 736) {
        return 23;
    }else if(ScreenHeight == 667){
        return 21;
    }else if(ScreenHeight == 568){
        return 18;
    }else if(ScreenHeight == 480){
        return 18;
    }
    return 0;
}
//设置页的橙色button
+(CGFloat)SettingButton:(CGFloat)ScreenHeight{
    if (ScreenHeight == 736) {
        return 40;
    }else if(ScreenHeight == 667){
        return 35;
    }else if(ScreenHeight == 568){
        return 25;
    }else if(ScreenHeight == 480){
        return 20;
    }
    return 0;
}
//设置页的橙色button间隙
+(CGFloat)SettingButtonLine:(CGFloat)ScreenHeight{
    if (ScreenHeight == 736) {
        return 20;
    }else if(ScreenHeight == 667){
        return 15;
    }else if(ScreenHeight == 568){
        return 15;
    }else if(ScreenHeight == 480){
        return 8;
    }
    return 0;
}
@end









