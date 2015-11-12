//
//  FirstrCategoryCell.m
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FirstrCategoryCell.h"


@implementation FirstrCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createButton{

    self.Myscroller.delegate = self;
    self.Myscroller.frame = CGRectMake(0, 0, WWidth, WHeight / 7);
    self.Myscroller.contentSize = CGSizeMake(WWidth * 2, WHeight / 7.5);
    self.Myscroller.showsHorizontalScrollIndicator = NO;
    
    NSArray * titleName = @[@"自我成长",@"情绪管理",@"人际沟通",@"恋爱婚姻",@"职场管理",@"亲子家庭",@"心理科普",@"课程讲座"];
    for (int i  = 0; i < 8; i ++) {
        UIButton * button = [MyFactory createButton:CGRectMake(WWidth / 4 * i + 20 / 414.0 * WWidth , WWidth / 41, WHeight / 11, WHeight / 11) title:nil NormalImage:[UIImage imageNamed:[NSString stringWithFormat:@"btn%d",i + 1]] selectedImage:nil titleColor:nil tint:nil tag:40 + i];
        [button addTarget:self action:@selector(catrClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.Myscroller addSubview:button];
        CGRect rect = button.frame;
        UILabel * label = [MyFactory createUIlabel:CGRectMake(rect.origin.x, rect.origin.y + rect.size.height + 5,rect.size.width, 10) title:titleName[i] font:10];
        [self.Myscroller addSubview:label];
    }

    
}

- (void)catrClick:(UIButton *)button{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CategoryTable" object:[NSString stringWithFormat:@"%ld",(long)button.tag]];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

- (void)showDataWithModel:(FirstCatetoryModel *)model{
    
}
@end
