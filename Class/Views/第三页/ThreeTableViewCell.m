//
//  ThreeTableViewCell.m
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

//"id": "327",
//"user_id": "29247207",
//"title": "你在哪个瞬间决定要放弃ta了？",
//"content": "说说，你在哪个瞬间决定要放弃ta了？",
//"created": "6月前",
//"updated": "刚刚",
//"jin": "0",
//"commentnum": "2080",
//"user": {
//    "id": "29247207",
//    "nickname": "墨无画",
//    "avatar": "http://image.xinli001.com//20141229/010122/831437.jpg!80"
//},
//"absolute_url": "http://yiapi.xinli001.com/fm/forum-share-page/327",
//"images": []
#import "ThreeTableViewCell.h"

@implementation ThreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithModel:(threeModel *)model{
    self.model = model;
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"personFm1"]];
    self.name.text = model.nickname;
    self.time.text = model.updated;
    self.label1.text = model.title;
    self.label2.text = model.content;
    self.comments.text = model.commentnum;
    self.conmmontNum.image = [UIImage imageNamed:@"commentPao@2x"];
    
    //line
    self.line.frame = CGRectMake(0, 0, WWidth, 8);
    //头像
    self.coverImage.frame = CGRectMake(10, 20, WWidth / 7, WWidth / 7);
    //小评论气泡
    self.conmmontNum.frame = CGRectMake(WWidth - 10 - 20, 20, 20, 15);
    //评论条数
    self.comments.frame = CGRectMake(WWidth - 30 - WWidth / 8, 20, WWidth / 8, 15);
    self.comments.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.comments.textColor = [UIColor grayColor];
    
    //名字的label
    CGRect rect = self.coverImage.frame;
    self.name.frame =  CGRectMake(rect.origin.x + rect.size.width + 10, 20,WWidth * 0.6, 15);
    self.name.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    //更新时间
    self.time.frame = CGRectMake(self.name.frame.origin.x,self.name.frame.origin.y + 20 , 100, 15);
    self.time.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] - 2];
    self.time.textColor = [UIColor grayColor];
    //title
    self.label1.frame = CGRectMake(10, rect.origin.y + rect.size.height + 5, WWidth - 20, 15);
    self.label1.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]- 1];
    //content
    self.label2.frame = CGRectMake(10, self.label1.frame.origin.y + self.label1.frame.size.height + [WJLFix numberForwidth:WWidth], WWidth - 20, 15);
    self.label2.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] -1];
    self.label2.textColor = [UIColor grayColor];

}

@end














