//
//  DetailTableViewCell.m
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showDataWithModel:(commontModels *)model{
    self.model = model;
    [self.cover sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"personFm1"]];
    self.name.text = [NSString stringWithFormat:@"%@ 楼",model.floor];
    self.floor.text = model.nickname;
    self.comments.text = model.content;
    self.time.text = model.created;
    //分割uiview
    self.line.frame = CGRectMake(0, 0, WWidth, 8);
    //头像
    self.cover.frame = CGRectMake(10, 15, WWidth / 8, WWidth / 8);
    self.cover.layer.cornerRadius = WWidth / 40;
    self.cover.layer.masksToBounds = YES;
    CGRect rect = self.cover.frame;
    //楼层
    self.name.frame = CGRectMake(rect.origin.x + rect.size.width + 10, 15, WWidth / 7, 15);
    self.name.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 1];
    self.name.textColor = [UIColor grayColor];
    //名字
    self.floor.frame = CGRectMake(rect.origin.x + rect.size.width + self.name.frame.size.width + 20, 15, 200, 15);
    self.floor.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 1];
    self.floor.textColor = [UIColor grayColor];
    //评论内容
    CGRect rect1 = self.comments.frame;
    CGFloat commentFont = [WJLFix FontWithScreenWidth:WWidth] + 1;
    self.comments.font = [UIFont systemFontOfSize:commentFont];
    rect1.size.height = [WJLHelper textHeightFromTextString:model.content width:WWidth - WWidth / 8 - 40 fontSize:commentFont];
    rect1.origin.x = rect.origin.x + rect.size.width + 10;
    rect1.origin.y = 40;
    rect1.size.width = WWidth - WWidth / 8 - 40;
    self.comments.frame = rect1;
    //时间
    self.time.frame = CGRectMake(rect.origin.x + rect.size.width + 10, rect1.origin.y + rect1.size.height + 10 , 200, 15);
    self.time.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 1];
    self.time.textColor = [UIColor grayColor];
}
@end
























