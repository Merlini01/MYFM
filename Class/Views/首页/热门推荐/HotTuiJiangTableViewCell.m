//
//  HotTuiJiangTableViewCell.m
//  MyFm
//
//  Created by Qianfeng on 15/10/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HotTuiJiangTableViewCell.h"
#import "UIButton+WebCache.h"

@implementation HotTuiJiangTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDataWithArray:(NSArray *)array{
    
    self.modelArray = array;
    self.title.text = @"热门推荐";
    self.title.frame = CGRectMake(10, 10, 70, 20);
    self.title.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 2];
    NSArray * labelArr = @[self.label1,self.label2,self.label3];
    NSArray * imageArr = @[self.imageView1,self.imageView2,self.imageView3];
    for (int i = 0; i < self.modelArray.count; i ++) {
        HotTuiJianModel * model = (HotTuiJianModel *)self.modelArray[i];
        UILabel * label =  (UILabel *)labelArr[i];
        label.text = model.hotfmTitle;
        UIButton * button = (UIButton *)imageArr[i];
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.hotfmCover] forState:UIControlStateNormal];
        button.tag = i + 50;
        button.frame = CGRectMake((WWidth - WWidth / 3.5 * 3) / 4 * (i + 1) + WWidth / 3.5 * i, self.title.frame.origin.y + 22, WWidth / 3.5, WWidth / 3.5 );
   
        label.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y + button.frame.size.height , button.frame.size.width,40);
        label.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] - 2];
    }
}
- (IBAction)imageView1:(UIButton *)sender {
    HotTuiJianModel * model = (HotTuiJianModel *)self.modelArray[0];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HotTuiJian" object:model.hotfmId];
}

- (IBAction)imageView2:(UIButton *)sender {
    HotTuiJianModel * model = (HotTuiJianModel *)self.modelArray[1];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HotTuiJian" object:model.hotfmId];
}

- (IBAction)imageView3:(UIButton *)sender {
    HotTuiJianModel * model = (HotTuiJianModel *)self.modelArray[2];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HotTuiJian" object:model.hotfmId];
}
@end
