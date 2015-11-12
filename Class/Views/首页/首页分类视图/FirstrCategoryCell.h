//
//  FirstrCategoryCell.h
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCatetoryModel.h"

@interface FirstrCategoryCell : UITableViewCell <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *Myscroller;

- (void)createButton;
-(void)showDataWithModel:(FirstCatetoryModel *)model;
@end
