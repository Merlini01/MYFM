//
//  searchViewCell.m
//  MyFm
//
//  Created by Qianfeng on 15/11/3.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "searchViewCell.h"

@implementation searchViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(searchModel *)model{
    self.model = model;
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
    self.label1.text = model.title;
    self.label2.text = [NSString stringWithFormat:@"主播 %@",model.speak];
    self.label3.text = [NSString stringWithFormat:@"收听量 %@",model.viewnum];
    
    CGRect rect = self.coverImage.frame;
    rect.origin.x = 15;
    rect.origin.y = 5;
    rect.size.width = WHeight / 8 - 10;
    rect.size.height = WHeight / 8 - 10;
    self.coverImage.frame = rect;
    
    self.label1.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.label2.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.label3.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
}

@end
