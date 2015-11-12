//
//  CateTableViewCell.h
//  MyFm
//
//  Created by Qianfeng on 15/10/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCatetoryModel.h"
#import "SecondModel.h"
@interface CateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *Cover;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *speak;
@property (weak, nonatomic) IBOutlet UILabel *number;

@property (nonatomic,strong)SecondModel * model;

-(void)showDataWithModel:(SecondModel *)model;

@end
