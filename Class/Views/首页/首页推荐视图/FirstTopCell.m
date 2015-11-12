//
//  FirstTopCell.m
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FirstTopCell.h"

@implementation FirstTopCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(FirstTuiJian *)model{
    self.model = model;
    //[self.TuiJianImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
    self.TuiJianImage.image = [UIImage imageNamed:@"101256ss8sbqbpns68vjxa.jpg"];
}
@end
