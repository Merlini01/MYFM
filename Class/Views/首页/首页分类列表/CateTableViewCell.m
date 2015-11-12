//
//  CateTableViewCell.m
//  MyFm
//
//  Created by Qianfeng on 15/10/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "CateTableViewCell.h"

@implementation CateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(SecondModel *)model{
    self.model = model;
    [self.Cover sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
    self.title.text = model.title;
    self.speak.text = [NSString stringWithFormat:@"主播 %@",model.speak];
    self.number.text = [NSString stringWithFormat:@"收听量 %@",model.viewnum];
    
    CGRect rect = self.Cover.frame;
    rect.origin.x = 15;
    rect.origin.y = 5;
    rect.size.width = WHeight / 8 - 10;
    rect.size.height = WHeight / 8 - 10;
    self.Cover.frame = rect;
    
    self.title.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.speak.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.number.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
}
@end
