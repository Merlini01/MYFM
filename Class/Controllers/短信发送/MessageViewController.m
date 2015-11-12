//
//  MessageViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
@property (nonatomic)UITextField * phoneNum;
@property (nonatomic)UITextField * PhoneId;
@property (nonatomic)UITextField * UserName;
@property (nonatomic)UITextField * password;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self NaviBarRightButton];
    [self createTextFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)NaviBarRightButton{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"注册";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orange1"] style:UIBarButtonItemStylePlain target:self action:@selector(ReturnClick)];
    self.navigationItem.leftBarButtonItem = left;
    UIView * image = [[UIView alloc]initWithFrame:CGRectMake(10, 64, WWidth - 20, 1)];
    image.backgroundColor = [UIColor grayColor];
    [self.view addSubview:image];
}

- (void)ReturnClick{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)createTextFile{
    
    self.phoneNum = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, WWidth - 70 - 70, 30)];
    self.phoneNum.placeholder = @"输入11位正确手机号";
    self.phoneNum.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.phoneNum];
    
    UIView * image = [[UIView alloc]initWithFrame:CGRectMake(20, 181, WWidth - 40, 1)];
    image.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:image];
    
    
    UIButton * regButton = [MyFactory createButton:CGRectMake(20, 191, 100, 20) title:@"获取验证码" titleColor:[UIColor orangeColor] tag:910];
    regButton.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    [regButton addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
    
    self.PhoneId = [[UITextField alloc]initWithFrame:CGRectMake(20, 220, WWidth - 70 - 70, 30)];
    self.PhoneId.placeholder = @"输入验证码";
    self.PhoneId.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.PhoneId];
    
    UIView * image1 = [[UIView alloc]initWithFrame:CGRectMake(20, 251, WWidth - 40, 1)];
    image1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:image1];
    
    
    self.UserName = [[UITextField alloc]initWithFrame:CGRectMake(20, 280, WWidth - 70 - 70, 30)];
    self.UserName.placeholder = @"输入昵称";
    self.UserName.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.UserName];
    
    UIView * image2 = [[UIView alloc]initWithFrame:CGRectMake(20,311, WWidth - 40, 1)];
    image2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:image2];
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(20, 342, WWidth - 70 - 70, 30)];
    self.password.placeholder = @"输入密码";
    self.password.borderStyle = UITextBorderStyleNone;
    self.password.secureTextEntry = YES;
    [self.view addSubview:self.password];
    
    UIView * image3 = [[UIView alloc]initWithFrame:CGRectMake(20,378, WWidth - 40, 1)];
    image3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:image3];
    
    
    UIButton * ZCButton = [MyFactory createButton:CGRectMake(20, 390, 100, 20) title:@"注册" titleColor:[UIColor orangeColor] tag:911];
    ZCButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    ZCButton.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    [ZCButton addTarget:self action:@selector(zhuceClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ZCButton];
    
}

- (void)phone{
    if(self.phoneNum.text.length > 0){
        for (int  i = 0; i < self.phoneNum.text.length; i ++) {
            unichar ch = [self.phoneNum.text characterAtIndex:i];
            if (ch >= '0' && ch <= '9') {
                
            }else{
                UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"输入正确手机号哦" preferredStyle:UIAlertControllerStyleAlert];
                [ alter addAction:[UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alter removeFromParentViewController];
                }]];
                [self presentViewController:alter animated:YES completion:nil];
            }
        }
    }
    
    if (self.phoneNum.text.length == 0) {
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"手机号不能为空哦" preferredStyle:UIAlertControllerStyleAlert];
        [ alter addAction:[UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alter removeFromParentViewController];
        }]];
        [self presentViewController:alter animated:YES completion:nil];
    }else if (self.phoneNum.text.length != 11) {
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"输入正确手机号哦" preferredStyle:UIAlertControllerStyleAlert];
        [ alter addAction:[UIAlertAction actionWithTitle:@"再试一次" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alter removeFromParentViewController];
        }]];
        [self presentViewController:alter animated:YES completion:nil];
    }else{
        [self fetchDataFromServer];
    }
}

- (void)zhuceClick{
    if (self.PhoneId.text.length == 0) {
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"验证码不能为空哦" preferredStyle:UIAlertControllerStyleAlert];
        [ alter addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alter removeFromParentViewController];
        }]];
        [self presentViewController:alter animated:YES completion:nil];
    }else if(self.UserName.text.length == 0){
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"昵称不能为空哦" preferredStyle:UIAlertControllerStyleAlert];
        [ alter addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alter removeFromParentViewController];
        }]];
        [self presentViewController:alter animated:YES completion:nil];
    }else if(self.password.text.length == 0){
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"密码不能为空哦" preferredStyle:UIAlertControllerStyleAlert];
        [ alter addAction:[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alter removeFromParentViewController];
        }]];
        [self presentViewController:alter animated:YES completion:nil];
    }else{
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
        [MMProgressHUD showWithTitle:@"注册"];
        
        //username=15893727813&validcode=383059&password1=123456&nickname=@%E9%AB%98%E5%B1%B1&password2=123456&key=c0d28ec0954084b4426223366293d190
        WJLRequest *httpRequest = [[WJLRequest alloc] init];
        NSString * Paramer = [NSString stringWithFormat:@"username=%@&validcode=%@&password1=%@&nickname=%@&password2=%@&key=c0d28ec0954084b4426223366293d190",self.phoneNum.text,self.PhoneId.text,self.password.text,self.UserName.text,self.password.text];
        //
        //NSString * Paramer = [NSString stringWithFormat:@"username=%@&validcode=%@&password1=%@&nickname=%@&password2=%@",self.phoneNum.text,self.PhoneId.text,self.password.text,self.UserName.text,self.password.text];
        NSLog(@"------ %@",Paramer);
        NSString * postStr = @"http://bapi.xinli001.com/users/register2.json/";
        [httpRequest postDataWithurl:postStr params:Paramer success:^(NSData *downloadData){
            if (downloadData) {
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
                NSInteger code = [dic[@"code"] integerValue];
                if (code == -1) {
                    [MMProgressHUD dismissWithError:@"注册失败"];
                }else{
                    [MMProgressHUD dismissWithSuccess:@"注册成功"];
                }
                NSLog(@"----- %@",dic);
                
            }
            
            
        } failedBlock:^(NSError *error){
            [MMProgressHUD dismissWithError:@"注册失败"];
        }];
    }

}

#pragma mark -
#pragma mark 网络请求
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"短信验证码"];
    
    NSString *url = [self getNetworkConnectionString];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [self parsingDataFrom:responsData];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"发送失败"];
    }];
    
}

// 获取网络请求连接
- (NSString *)getNetworkConnectionString {
    return [NSString stringWithFormat:MessageURL,self.phoneNum.text];
}

// 解析数据
- (void)parsingDataFrom:(id)responsData {
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responsData options:NSJSONReadingMutableContainers error:nil];
    NSString * codeString = dic[@"data"];
    if ([codeString isEqualToString:@"发送成功"]) {
        [MMProgressHUD dismissWithSuccess:@"发送成功" ];
    }else if([codeString isEqualToString:@"验证码发送太频繁了"]){
        [MMProgressHUD dismissWithError:@"验证码发送太频繁了" ];
    }else if([codeString isEqualToString:@"该手机号码已注册"]){
        [MMProgressHUD dismissWithError:@"该手机号码已注册" ];
    }else if([codeString isEqualToString:@"验证码发送次数已达到今天的上限"]){
        [MMProgressHUD dismissWithError:@"验证码发送次数已达到今天的上限" ];
    }else if([codeString isEqualToString:@"手机号码格式不正确"]){
        [MMProgressHUD dismissWithError:@"手机号码格式不正确" ];
    }
    else{
        [MMProgressHUD dismissWithError:@"发送失败"];
    }
    
    
}

@end


































