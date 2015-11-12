//
//  HotTuiJiangTableViewCell.h
//  MyFm
//
//  Created by Qianfeng on 15/10/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTuiJianModel.h"

@interface HotTuiJiangTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *imageView1;
@property (weak, nonatomic) IBOutlet UIButton *imageView2;
@property (weak, nonatomic) IBOutlet UIButton *imageView3;
- (IBAction)imageView1:(UIButton *)sender;
- (IBAction)imageView2:(UIButton *)sender;
- (IBAction)imageView3:(UIButton *)sender;


@property (nonatomic,strong)NSArray * modelArray;
- (void)showDataWithArray:(NSArray *)array;
@end
