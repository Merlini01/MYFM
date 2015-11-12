//
//  NewestViewCell.h
//  MyFm
//
//  Created by Qianfeng on 15/10/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "newfmModel.h"

@interface NewestViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imagView1;
@property (weak, nonatomic) IBOutlet UIImageView *imagView2;
@property (weak, nonatomic) IBOutlet UIImageView *imagView3;
@property (weak, nonatomic) IBOutlet UILabel *title1;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UILabel *title3;
@property (weak, nonatomic) IBOutlet UILabel *speak1;
@property (weak, nonatomic) IBOutlet UILabel *speak2;
@property (weak, nonatomic) IBOutlet UILabel *speak3;
@property (weak, nonatomic) IBOutlet UIView *seperaLine;
@property (weak, nonatomic) IBOutlet UIButton *MoreButton;
- (IBAction)MoreButton:(UIButton *)sender;

@property (nonatomic,strong)NSArray * modelArray;
@property (nonatomic,assign)NSInteger  flag;
- (void)showDataWithArray:(NSArray *)array flag:(NSInteger)flag;

@end
