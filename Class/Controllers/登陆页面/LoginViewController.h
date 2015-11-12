//
//  LoginViewController.h
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JxbLoginShowType) {
    JxbLoginShowType_NONE,
    JxbLoginShowType_USER,
    JxbLoginShowType_PASS
};

typedef void(^myblock)(BOOL isSuccessLoad,NSData * token);
@interface LoginViewController : UIViewController
@property (nonatomic,copy)myblock Myblock;
@end
