//
//  FourthViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FourthViewController.h"
#import "LoginViewController.h"
#import "SuccessModel.h"

@interface FourthViewController ()<UMSocialUIDelegate>
@property (nonatomic)UITextField * username;
@property (nonatomic)UITableView * password;
@property (nonatomic)BOOL isLoad;
@property (nonatomic)BOOL isSaveLoad;
@property (nonatomic)NSData * token;
@property (nonatomic)UIImageView * cover;
@property (nonatomic)NSArray * dataSource;
@property (nonatomic)NSMutableArray * saveData;
@property (nonatomic)UILabel * myName;
@property (nonatomic)BOOL  isQianDao;
@end

@implementation FourthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isLoad = NO;
    self.saveData = [[NSMutableArray alloc]init];
    [self initBackgroup];
    [self initAnimation];
    //[self createTextFiled];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray * phones = [defaults objectForKey:@"phone"];
    if (phones.count == 2) {
        self.token = [phones lastObject];
        [self fetchDataFromServer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark - 创建UI
- (void)initBackgroup{
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WWidth, WWidth * 0.6)];
    image.image = [UIImage imageNamed:@"zhuanti_img_5.jpg"];
    [self.view addSubview:image];
    
    //头像
    self.cover  = [[UIImageView alloc]initWithFrame:CGRectMake(WWidth / 2 - WWidth / 12, WWidth * 0.6 - WWidth / 12, WWidth / 6, WWidth / 6)];
    self.cover.image = [UIImage imageNamed:@"fm100"];
    self.cover.layer.cornerRadius = WWidth / 12;
    self.cover.layer.masksToBounds = YES;
    [self.view addSubview:self.cover];
    
    //用户名
    self.myName = [[UILabel alloc]initWithFrame:CGRectMake(WWidth / 2 - 100, WWidth * 0.6 - WWidth / 12 + WWidth / 6 + 10, 200, 20)];
    self.myName.textColor = [UIColor orangeColor];
    self.myName.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 1];
    self.myName.text = @"未登录";
    self.myName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.myName];
    
    CGRect rect = self.myName.frame;
    CGFloat bottom = rect.origin.y + rect.size.height + 10;
    
    CGFloat buttonHeight = [WJLFix SettingButton:WHeight];
    CGFloat buttonline = [WJLFix SettingButtonLine:WHeight];
    
    //登陆
    UIButton * button = [MyFactory createButton:CGRectMake(WWidth / 6, bottom , WWidth - WWidth / 3, buttonHeight) title:@"登陆" titleColor:[UIColor whiteColor] tag:800];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(Click1:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 2];
    button.layer.cornerRadius = 8 / WWidth * 375;
    [self.view addSubview:button];
    
    //设置
    UIButton * button1 = [MyFactory createButton:CGRectMake(WWidth / 6, bottom + buttonHeight + buttonline, WWidth - WWidth / 3, buttonHeight) title:@"设置" titleColor:[UIColor whiteColor] tag:801];
    button1.backgroundColor = [UIColor orangeColor];
    button1.layer.cornerRadius = 8 / WWidth * 375;
    [button1 addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    button1.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 2];
    [self.view addSubview:button1];
    
    //签到
    UIButton * button2 = [MyFactory createButton:CGRectMake(WWidth / 6,bottom + (buttonHeight + buttonline) * 2, WWidth - WWidth / 3, buttonHeight) title:@"签到" titleColor:[UIColor whiteColor] tag:802];
    button2.backgroundColor = [UIColor orangeColor];
    button2.layer.cornerRadius = 8 / WWidth * 375;
    [button2 addTarget:self action:@selector(qianDaoClick:) forControlEvents:UIControlEventTouchUpInside];
    button2.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 2];
    [self.view addSubview:button2];
    
    //我的金币
    UIButton * button3 = [MyFactory createButton:CGRectMake(WWidth / 6, bottom + (buttonHeight + buttonline) * 3, WWidth - WWidth / 3, buttonHeight) title:@"金币 0" titleColor:[UIColor whiteColor] tag:803];
    button3.backgroundColor = [UIColor orangeColor];
    button3.layer.cornerRadius = 8 / WWidth * 375;
    [button3 addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    button3.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 2];
    button3.userInteractionEnabled = NO;
    [self.view addSubview:button3];
    
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, WHeight - 49, WWidth, 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    

    

    
    
}
#pragma mark -
#pragma mark - 签到
- (void)qianDaoClick:(UIButton *)btn{
    NSString * str = btn.titleLabel.text;
    if ([str isEqualToString:@"签到"]) {
        if (self.isSaveLoad == NO) {
            UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"请先登陆" preferredStyle:UIAlertControllerStyleAlert];
            [ alter addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alter removeFromParentViewController];
            }]];
            [self presentViewController:alter animated:YES completion:nil];
        }else{
            NSString * head = [NSString stringWithFormat:QIANDAO,self.token];
            [[NetDataEngine sharedInstance]requestMessageFrom:head success:^(id responsData) {
                if (responsData) {
                    self.isQianDao = YES;
                    [self parsingDataFrom:responsData];
                    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:nil];
                    //NSLog(@"%@",dic);
                    NSInteger flag = [dic[@"code"] integerValue];
                    if (flag == -1) {
                        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"已经签过到了哦,明天再来" preferredStyle:UIAlertControllerStyleAlert];
                        [ alter addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [alter removeFromParentViewController];
                        }]];
                        [self presentViewController:alter animated:YES completion:nil];
                    }else{
                        [btn setTitle:@"已签到" forState:UIControlStateNormal];
                    }
                }

            } failed:^(NSError *error) {
                
            }];
            
        }
        
    }else if([str isEqualToString:@"已签到"]){
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"已经签过到了哦,明天再来" preferredStyle:UIAlertControllerStyleAlert];
        [ alter addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alter removeFromParentViewController];
        }]];
        [self presentViewController:alter animated:YES completion:nil];
    }
}
#pragma mark -
#pragma mark - 创建动画
- (void)initAnimation{
    for (int i = 0; i < 3; i ++) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake((WWidth - WWidth / 6.5 * 3) / 4 * (i + 1) + WWidth / 6.5 * i, WHeight, WWidth / 6.5, WWidth / 6.5)];
        view.userInteractionEnabled = YES;
        if (i == 0) {
            view.backgroundColor = [UIColor colorWithRed: 255 / 255.0 green: 165 / 255.0 blue: 79 / 255.0 alpha:1];
            UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [view addGestureRecognizer:ges];
            
            NSUInteger fileSize = [[SDImageCache sharedImageCache] getSize];
            //换算成 M
            CGFloat size = fileSize/1024.0/1024.0;
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, WWidth / 13 - 10, WWidth / 6.5, 20)];
            label.text = [NSString stringWithFormat:@"缓存%.0fM",size];
            label.textAlignment = NSTextAlignmentCenter;
            label.tag = 1000;
            label.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] - 1];
            [view addSubview:label];
        }
        if (i == 1) {
            view.backgroundColor = [UIColor colorWithRed: 34 / 255.0 green: 139 / 255.0 blue: 34 / 255.0 alpha:1];
            UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick1:)];
            [view addGestureRecognizer:ges];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, WWidth / 13 - 10, WWidth / 6.5, 20)];
            label.text = @"分享";
            label.tag = 1001;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] - 1];
            [view addSubview:label];
        }
        if (i == 2) {
            view.backgroundColor = [UIColor colorWithRed: 0 / 255.0 green: 191 / 255.0 blue: 255 / 255.0 alpha:1];
            UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick2:)];
            [view addGestureRecognizer:ges];
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, WWidth / 13 - 10, WWidth / 6.5, 20)];
            label.text = @"我";
            label.tag = 1002;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] - 1];
            [view addSubview:label];
        }
        

        view.layer.cornerRadius = WWidth / 13;
        view.tag = 600 + i;
        [self.view addSubview:view];
    }
}
- (void)tapClick:(UIGestureRecognizer *)gesture{
    UILabel * label = (UILabel *)[self.view viewWithTag:1000];
    label.text = @"缓存0M";
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];

}
- (void)tapClick1:(UIGestureRecognizer *)gesture{

    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561092ea67e58e05840005f2"
                                      shareText:@"一切都是最好的安排--余音fm"
                                     shareImage:[UIImage imageNamed:@"latest_fm_img_2.jpg"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToDouban,UMShareToRenren,UMShareToEmail,nil]
                                       delegate:self];
}
- (void)tapClick2:(UIGestureRecognizer *)gesture{
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"王家亮~617022101@qq.com" preferredStyle:UIAlertControllerStyleAlert];
    [ alter addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alter removeFromParentViewController];
    }]];
    [self presentViewController:alter animated:YES completion:nil];
}
#pragma mark -
#pragma mark - 返回请求url
- (NSString *)getMyInfoUrl{
   
    return [NSString stringWithFormat:MYInfo,[NSString stringWithFormat:@"%@",self.token]];
}
#pragma mark -
#pragma mark - 解析数据
- (void)parsingDataFrom:(id)responsData{
    self.isSaveLoad = YES;
    self.dataSource = [SuccessModel detailModelList:responsData];
    
    SuccessModel * model = (SuccessModel *)self.dataSource[0];
    
    [self.saveData removeAllObjects];
    [self.saveData addObject:[NSString stringWithFormat:@"%d",self.isSaveLoad]];
    [self.saveData addObject:[NSString stringWithFormat:@"%@",self.token]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.saveData forKey:@"phone"];
    [defaults synchronize];
    if (self.isQianDao == YES) {
        
    }else{
        [self reloadData:model];
    }
    self.isQianDao = NO;
    
}
#pragma mark -
#pragma mark - 登陆成功重载数据
- (void)reloadData:(SuccessModel *)model{
    self.myName.text = model.nickname;
    [self.cover sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"three"]];
    
    UIButton * loadButton = (UIButton *)[self.view viewWithTag:800];
    [loadButton setTitle:@"退出" forState:UIControlStateNormal];
    
    UIButton * qiandaoButton = (UIButton *)[self.view viewWithTag:802];
    if (model.qiandao == NO) {
        [qiandaoButton setTitle:@"签到" forState:UIControlStateNormal];
    }else{
        [qiandaoButton setTitle:@"已签到" forState:UIControlStateNormal];
    }
    
    UIButton * goldButton = (UIButton *)[self.view viewWithTag:803];
    [goldButton setTitle:[NSString stringWithFormat:@"金币 %lu",model.bitcoin] forState:UIControlStateNormal];
}
//#pragma -mark tabbar
- (void)fetchDataFromServer {
    NSString *head = [self getMyInfoUrl];
    [[NetDataEngine sharedInstance]requestMessageFrom:head success:^(id responsData) {
        self.isQianDao = NO;
        [self parsingDataFrom:responsData];
    } failed:^(NSError *error) {

    }];
}
#pragma mark -
#pragma mark - 登陆button
- (void)Click1:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString: @"登陆"]) {
        LoginViewController * longin = [[LoginViewController alloc]init];
        longin.Myblock = ^(BOOL isSuccessLoad,NSData * data){
            self.isLoad = isSuccessLoad;
            self.token = data;
            [self fetchDataFromServer];
        };
        [self.navigationController pushViewController:longin animated:YES];
    }else{
        self.token = [NSData alloc];
        self.isSaveLoad = NO;
        [self.saveData removeAllObjects];
        [btn setTitle:@"登陆" forState:UIControlStateNormal];
        
        [self.saveData addObject:[NSString stringWithFormat:@"%d",self.isSaveLoad]];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.saveData forKey:@"phone"];
        [defaults synchronize];
        //退出账号 清除数据
        [self clearData];
    }
    
}
#pragma mark -
#pragma mark - 退出账号 清除数据
- (void)clearData{
    
    self.myName.text = @"未登陆";
    self.cover.image = [UIImage imageNamed:@"fm100"];
    
    UIButton * qiandaoButton = (UIButton *)[self.view viewWithTag:802];
    [qiandaoButton setTitle:@"签到" forState:UIControlStateNormal];

    UIButton * goldButton = (UIButton *)[self.view viewWithTag:803];
    [goldButton setTitle:@"金币 0" forState:UIControlStateNormal];
}
#pragma mark -
#pragma mark - 设置的动画
- (void)Click{
    static NSInteger num = 2;

    if (num % 2 == 0) {
        [self expand];
    }else{
        [self close];
    }
    
    num ++;

}
- (void)expand{
    for (int i = 0; i < 4; i++) {
        UIView *view = [self.view viewWithTag:600 + i];
        CGPoint center = view.center;
        [UIView animateWithDuration:2 delay:i * 0.05 usingSpringWithDamping:0.5 initialSpringVelocity:20 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGPoint newCenter = CGPointMake(center.x, center.y - 150 / 414.0 * WWidth);
           // CGPoint newCenter = CGPointMake(center.x - WWidth, center.y );
            view.center = newCenter;

        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)close{
    for (int i = 0; i < 4; i++) {
        UIView *view = [self.view viewWithTag:600+i];
        CGPoint center = view.center;
        [UIView animateWithDuration:2 delay:i*0.05 usingSpringWithDamping:0.7 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGPoint newCenter = CGPointMake(center.x, center.y + 150 / 414.0 * WWidth );
            //CGPoint newCenter = CGPointMake(center.x + WWidth, center.y);
            view.center = newCenter;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark - 
#pragma mark - textfiled

- (void)createTextFiled{
    self.username = [[UITextField alloc]initWithFrame:CGRectMake(WWidth / 5, WHeight / 7, WWidth / 2, WWidth / 12)];
    self.username.placeholder = @"输入11位正确手机号";
    [self.username setValue:[UIColor orangeColor] forKeyPath:@"_placeholderLabel.textColor"];
    //self.username.layer.borderWidth = 1;
    self.username.layer.borderColor=[UIColor orangeColor ].CGColor;
    self.username.backgroundColor = [UIColor clearColor];
    self.username.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.username];
}

@end






























