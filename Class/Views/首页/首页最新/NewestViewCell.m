//
//  NewestViewCell.m
//  MyFm
//
//  Created by Qianfeng on 15/10/30.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "NewestViewCell.h"

@implementation NewestViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showDataWithArray:(NSArray *)array flag:(NSInteger)flag{
    self.modelArray = array;
    self.flag = flag;
    NSArray * labelArr = @[self.title1,self.title2,self.title3];
    NSArray * speakArr = @[self.speak1,self.speak2,self.speak3];
    NSArray * imageArr = @[self.imagView1,self.imagView2,self.imagView3];
    NSArray * arr1 = @[@"最新FM",@"最新心理课"];
    NSArray * arr2 = @[@"FM+",@"心理课+"];
    if (flag == 3) {
        self.topTitle.text = arr1[0];
        [self.MoreButton setTitle:arr2[0] forState:UIControlStateNormal];
    }else{
        self.topTitle.text = arr1[1];
        [self.MoreButton setTitle:arr2[1] forState:UIControlStateNormal];
    }
    self.topTitle.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    for (int i = 0; i < self.modelArray.count; i ++) {
        newfmModel * model = self.modelArray[i];
        UILabel * label = (UILabel *)labelArr[i];
        label.text = model.title;
        UILabel * speak = (UILabel *)speakArr[i];
        speak.text = [NSString stringWithFormat:@"主播:%@",model.speak];
        UIImageView * image = (UIImageView *)imageArr[i];
        [image sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
        image.frame = CGRectMake(8,35 +  WHeight / 3 / 5.5 * i + 10 * i, WHeight / 3 / 5.5, WHeight / 3 / 5.5);
        CGRect rect = image.frame;
        label.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] ];
        label.frame = CGRectMake(18 + WHeight / 3 / 5.5, rect.origin.y, WWidth - 18 + WHeight / 3 / 5.5, WHeight / 6 / 5.5);
        speak.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] ];
        speak.frame = CGRectMake(18 + WHeight / 3 / 5.5, label.frame.origin.y + label.frame.size.height + 5, WWidth - 18 + WHeight / 3 / 5.5, WHeight / 6 / 5.5);
        if (flag == 4) {
            flag += 10;
        }
        UIButton * button = [MyFactory createButton:CGRectMake(8,35 +  WHeight / 3 / 5.5 * i + 10 * i, WWidth, WHeight / 3 / 5.5) title:@"" NormalImage:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]  titleColor:[UIColor whiteColor] tint:[UIColor whiteColor] tag:110 + i + flag];
        [button addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    CGRect rect1 =  self.seperaLine.frame;
    rect1.origin.y = self.speak3.frame.origin.y + self.speak3.frame.size.height + [WJLFix numberForwidth:WWidth];
    self.seperaLine.frame = rect1;
    self.MoreButton.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    CGRect rect2 = self.MoreButton.frame;
    rect2.origin.y = rect1.origin.y + rect1.size.height +[WJLFix numberForwidth:WWidth];
    self.MoreButton.frame = rect2;
    self.MoreButton.titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    
}

- (void)cellClick:(UIButton *)btn{
    static NSInteger num = 0;
    if (btn.tag < 116) {
        num = btn.tag - 113;
    }else{
        num = btn.tag - 124;
    }
    newfmModel * model = self.modelArray[num];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HotTuiJian" object:model.id];
}

- (IBAction)MoreButton:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CategoryTable" object:[NSString stringWithFormat:@"%lu",self.flag]];
}
@end
