//
//  FirstTopCell.h
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FirstTuiJian.h"

@interface FirstTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TuiJianImage;

@property (nonatomic,strong)FirstTuiJian * model;

-(void)showDataWithModel:(FirstTuiJian *)model;
@end
