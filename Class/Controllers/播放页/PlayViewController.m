//
//  PlayViewController.m
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "PlayViewController.h"
#import "PlayModel.h"
#import "UIImageView+WebCache.h"
#import "RootViewController.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;

@interface PlayViewController ()
@property (nonatomic,strong)DOUAudioStreamer * streamer;

@property (nonatomic,assign) BOOL TransPlay;
@property (nonatomic,assign) NSInteger flag;
@property (nonatomic,strong)NSTimer * _timer;
@property (nonatomic,assign) NSInteger timeLength;
@property (nonatomic,assign) NSInteger AllwaysLength;
@end

@implementation PlayViewController

+(instancetype)sharedInstance{
    static PlayViewController * s_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_manager = [[PlayViewController alloc]init];
    });
    return s_manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 0;
}

- (BOOL)hidesBottomBarWhenPushed{
    return YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.flag = 0;
    if (self.isPlay == NO) {
        [self fetchDataFromServer];
        [self MyViewInit];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark -界面初始化
- (void)MyViewInit{
    [self.stopButton setTintColor:[UIColor whiteColor]];
    [self.stopButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [self.stopButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.stopButton setTintColor:[UIColor whiteColor]];
    self.Cover.userInteractionEnabled = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resClick)];
    [self.Cover addGestureRecognizer:recognizer];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"orange1"] style:UIBarButtonItemStylePlain target:self action:@selector(ReturnClick)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)ReturnClick{
    self.stopButton.selected = YES;
    PlayModel * model = (PlayModel *)self.dataSource[0];
    if (self.Myblock) {
        self.Myblock(self.isPlay,model.id);
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"radioStatue" object:[NSString stringWithFormat:@"%d",self.isPlay]];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)resClick{

}

#pragma mark -
#pragma mark -网络获取数据
- (void)fetchDataFromServer {
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleDrop];
    [MMProgressHUD showWithTitle:@"数据加载中"];
    
    NSString *url = [self getNetworkConnectionString];
    [[NetDataEngine sharedInstance]requestMessageFrom:url success:^(id responsData) {
        [MMProgressHUD dismissWithSuccess:@"加载成功" ];
        [self parsingDataFrom:responsData];
        [self.view bringSubviewToFront:self.stopButton];
    } failed:^(NSError *error) {
        [MMProgressHUD dismissWithError:@"加载失败"];
    }];
}

#pragma mark -
#pragma mark -获取网络请求连接
- (NSString *)getNetworkConnectionString{
    
    if (self.flag == 0) {
        return [NSString stringWithFormat:XLTFN,self.PlayId];
    }
    if (self.flag == -1) {
        PlayModel * model = (PlayModel *)self.dataSource[0];
        if (model.id != nil) {
            NSInteger numId = [model.id integerValue];
            numId--;
             return [NSString stringWithFormat:XLTFN,[NSString stringWithFormat:@"%lu",numId]];
        }
    }
    if (self.flag == 1) {
        PlayModel * model = (PlayModel *)self.dataSource[0];
        if (model.id != nil) {
            NSInteger numId = [model.id integerValue];
            numId++;
            return [NSString stringWithFormat:XLTFN,[NSString stringWithFormat:@"%lu",numId]];
        }
    }
    return nil;
}

#pragma mark -
#pragma mark -解析数据
- (void)parsingDataFrom:(id)responsData {
    self.dataSource = [PlayModel detailModelList:responsData];
    PlayModel * model = self.dataSource[0];
    //[MMProgressHUD dismissWithSuccess:@"加载成功" ];
    [self.WJLImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
    self.WJLImageView.frame = CGRectMake(0, 0, WWidth, WWidth);
    
    [self.Cover sd_setImageWithURL:[NSURL URLWithString:model.TCover] placeholderImage:[UIImage imageNamed:@"noDownloadedImage"]];
    self.Cover.layer.cornerRadius = self.Cover.frame.size.width / 2;
    self.Cover.layer.masksToBounds = YES;
    
    self.leftLabel.text = model.title;
    self.leftLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.rightLabel.text = [NSString stringWithFormat:@"收听:%@",model.viewnum];
    self.rightLabel.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth]];
    self.name.text = [NSString stringWithFormat:@"主播:%@",model.speak];
    self.name.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] + 1];
    self.content.text = model.TContent;
    self.content.font = [UIFont systemFontOfSize:[WJLFix FontWithScreenWidth:WWidth] - 2];
    [self showTimerLength:model.duration];
    self.timeLength = model.duration;
    self.AllwaysLength = model.duration;
    if (self.isPlay == NO){
        [self reloadRadio];
        [self resetStreamer];
    }
}
#pragma mark -
#pragma mark -计算剩余时间
- (void)showTimerLength:(long int )length{
    if (length > 3600) {
        NSInteger shi = length / 3600;
        NSInteger fen = length % 3600 / 60;
        NSInteger miao = length % 3600 % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%lu : %lu : %02lu",shi,fen,miao];
    }else if (length > 60) {
        NSInteger fen = length / 60;
        NSInteger miao = length % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"%lu : %02lu",fen,miao];
    }else{
        NSInteger miao = length % 60;
        self.timeLabel.text = [NSString stringWithFormat:@"00 : %lu",miao];
    }
}
#pragma mark -
#pragma mark -创建定时器
- (void)createTimer{
    self._timer = [NSTimer scheduledTimerWithTimeInterval:1.06 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
- (void)updateTimer{
    self.timeLength --;
    [self showTimerLength:self.timeLength];
    if (self.timeLength < 0.0) {
        self.flag = -1;
        [self reloadRadio];
        [self fetchDataFromServer];
    }else{
    [self.progress setProgress:((self.AllwaysLength - self.timeLength) / (double)self.AllwaysLength) animated:YES];
    }
}

- (void)cancelStreamer{
    if (self.streamer != nil) {
        [self.streamer pause];
        self.streamer = nil;
    }
}
- (void)resetStreamer{

        [self cancelStreamer];
        [self createTimer];
        //[self fetchDataFromServer];
        self.isPlay = YES;
        self.TransPlay = YES;
        PlayModel * model = (PlayModel *)self.dataSource[0];
        self.streamer = [DOUAudioStreamer streamerWithAudioFile:model];
        [self.streamer play];
}
#pragma mark -
#pragma mark -重新加载电台的初始化
- (void)reloadRadio{
    self.isPlay = NO;
    [self._timer invalidate];
    self._timer = nil;
    [self.progress setProgress:0.0 animated:YES];
}
- (IBAction)PreClick:(UIButton *)sender {
    self.stopButton.selected = YES;

    self.flag = -1;
    
   [self reloadRadio];
    [self fetchDataFromServer];
}

- (IBAction)StopClick:(UIButton *)sender {

    if (self.isPlay == YES) {
        self.stopButton.selected = NO;
        [self._timer setFireDate:[NSDate distantFuture]];
        [self.streamer pause];
        self.isPlay = NO;
        self.TransPlay = NO;
    }else if(self.isPlay == NO){
        self.stopButton.selected = YES;
        [self._timer setFireDate:[NSDate distantPast]];
        [self.streamer play];
        self.isPlay = YES;
        self.TransPlay = YES;
    }
}

- (IBAction)NextClick:(UIButton *)sender {
    self.stopButton.selected = YES;

    self.flag = 1;
    [self reloadRadio];
    [self fetchDataFromServer];
}

@end
