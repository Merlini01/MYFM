//
//  searchViewCell.h
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchModel.h"

@interface searchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (nonatomic,strong)searchModel * model;

-(void)showDataWithModel:(searchModel *)model;
@end
