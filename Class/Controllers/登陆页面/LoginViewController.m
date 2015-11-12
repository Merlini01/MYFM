//
//  LoginViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/11/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "LoginViewController.h"
#import "MessageViewController.h"
#import "LogInModel.h"
#import "myViewController.h"

#define mainSize    [UIScreen mainScreen].bounds.size
#define offsetLeftHand      60
#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, vLogin.frame.origin.y - 22, 40, 40)
#define rectRightHand       CGRectMake(imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 62, vLogin.frame.origin.y - 22, 40, 40)

@interface LoginViewController ()<UITextFieldDelegate>{
    JxbLoginShowType showType;
}
@property (nonatomic)UITextField * userName;
@property (nonatomic)UITextField * passWord;
@property (nonatomic)NSArray * dataSource;
@property (nonatomic)BOOL isSuccessLoad;
@property (nonatomic)UIImageView * imgLeftHand;
@property (nonatomic)UIImageView*  imgRightHand;
@property (nonatomic)UIImageView* imgLeftHandGone;
@property (nonatomic)UIImageView* imgRightHandGone;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSuccessLoad = NO;
    [self NaviBarRightButton];
    [self createTextFile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)NaviBarRightButton{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登陆";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orange1"] style:UIBarButtonItemStylePlain target:self action:@selector(ReturnClick)];
    self.navigationItem.leftBarButtonItem = left;
    UIView * image = [[UIView alloc]initWithFrame:CGRectMake(10, 64, WWidth - 20, 1)];
    image.backgroundColor = [UIColor grayColor];
    [self.view addSubview:image];
}

- (void)createTextFile{

    UIImageView* imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(WWidth / 2 - 211 / 2, 100, 211, 109)];
    imgLogin.image = [UIImage imageNamed:@"owl-login"];
    imgLogin.layer.masksToBounds = YES;
    [self.view addSubview:imgLogin];
    
    UIView* vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 200, mainSize.width - 30, 160)];
    vLogin.layer.borderWidth = 0.5;
    vLogin.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    vLogin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vLogin];
    
    //左手
    self.imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
    self.imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
    [imgLogin addSubview:self.imgLeftHand];
    //右手
    self.imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
    self.imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
    [imgLogin addSubview:self.imgRightHand];
    
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(70, 220, WWidth - 70 - 70, 30)];
    self.userName.placeholder = @"填写手机号";
    self.userName.delegate = self;
    self.userName.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:self.userName];
    
    UIImageView * imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 220, 25, 30)];
    imageView1.image = [UIImage imageNamed:@"email"];
    [self.view addSubview:imageView1];
    
    
    UIView * image = [[UIView alloc]initWithFrame:CGRectMake(20, 251, WWidth - 40, 1)];
    image.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:image];
    
    self.passWord = [[UITextField alloc]initWithFrame:CGRectMake(70, 270, WWidth - 70 - 70, 30)];
    self.passWord.placeholder = @"输入密码";
    self.passWord.delegate = self;
    self.passWord.borderStyle = UITextBorderStyleNone;
    self.passWord.secureTextEntry = YES;
    [self.view addSubview:self.passWord];
    
    UIImageView * imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 270, 25, 30)];
    imageView2.image = [UIImage imageNamed:@"password"];
    [self.view addSubview:imageView2];
    
    
    UIView * image1 = [[UIView alloc]initWithFrame:CGRectMake(20, 301, WWidth - 40, 1)];
    image1.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:image1];
    
    UIButton * regButton = [MyFactory createButton:CGRectMake(20, 310, 100, 20) title:@"手机快速注册" titleColor:[UIColor orangeColor] tag:900];
    regButton.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    [regButton addTarget:self action:@selector(phone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regButton];
    
    UIButton * logButton = [MyFactory createButton:CGRectMake(WWidth - 20 - 50 ,310, 50, 20) title:@"登陆" titleColor:[UIColor orangeColor] tag:905];
    logButton.titleLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    [logButton addTarget:self action:@selector(phone:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logButton];
    
}
- (void)phone:(UIButton *)btn{
    if (btn.tag == 900) {
        MessageViewController * message = [[MessageViewController alloc]init];
        [self.navigationController pushViewController:message animated:YES];
    }else{
        if (self.userName.text.length == 0 || self.passWord.text.length == 0) {
            UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"" message:@"账号或者密码不能为空哦" preferredStyle:UIAlertControllerStyleAlert];
            [ alter addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alter removeFromParentViewController];
            }]];
            [self presentViewController:alter animated:YES completion:nil];
        }else{
            [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
            [MMProgressHUD showWithTitle:@"登陆"];
            WJLRequest *httpRequest = [[WJLRequest alloc] init];
            NSString * Paramer = [NSString stringWithFormat:@"username=%@&password=%@",self.userName.text,self.passWord.text];
            NSString * postStr = @"http://bapi.xinli001.com/users/get_token.json/";
            [httpRequest postDataWithurl:postStr params:Paramer success:^(NSData *downloadData){
                if (downloadData) {
                    [self makeData:downloadData];
                    
                }
                
                
            } failedBlock:^(NSError *error){
                NSLog(@"网络异常");
            }];
        }
    }
    
}
- (void)makeData:(NSData *)downData{
    self.dataSource = [LogInModel detailModelList:downData];
    if (self.dataSource.count == 0) {
        [MMProgressHUD dismissWithError:@"密码或账号错误"];
        self.userName.text = @"";
        self.passWord.text = @"";
        self.isSuccessLoad = NO;
    }else{
        
        self.userName.text = @"";
        self.passWord.text = @"";
        LogInModel * model = self.dataSource[0];
        self.isSuccessLoad = YES;
        if (self.Myblock) {
            self.Myblock(self.isSuccessLoad,model.token);
        }
        [MMProgressHUD dismissWithSuccess:@"登陆成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)ReturnClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.userName]) {
        if (showType != JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_USER;
            return;
        }
        showType = JxbLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            _imgLeftHand.frame = CGRectMake(_imgLeftHand.frame.origin.x - offsetLeftHand, _imgLeftHand.frame.origin.y + 30, _imgLeftHand.frame.size.width, _imgLeftHand.frame.size.height);
            
            _imgRightHand.frame = CGRectMake(_imgRightHand.frame.origin.x + 48, _imgRightHand.frame.origin.y + 30, _imgRightHand.frame.size.width, _imgRightHand.frame.size.height);
            
        } completion:^(BOOL b) {
        }];
        
        
        
    }
    else if ([textField isEqual:self.passWord]) {
        if (showType == JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_PASS;
            return;
        }
        showType = JxbLoginShowType_PASS;
        [UIView animateWithDuration:0.5 animations:^{
            self.imgLeftHand.frame = CGRectMake(self.imgLeftHand.frame.origin.x + offsetLeftHand, self.imgLeftHand.frame.origin.y - 30, self.imgLeftHand.frame.size.width, self.imgLeftHand.frame.size.height);
            self.imgRightHand.frame = CGRectMake(self.imgRightHand.frame.origin.x - 48, self.imgRightHand.frame.origin.y - 30, self.imgRightHand.frame.size.width, self.imgRightHand.frame.size.height);
            
        } completion:^(BOOL b) {
        }];
    }
}


@end















