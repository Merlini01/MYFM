//
//  PlayViewController.h
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlayStatue)(BOOL PlayStatue,NSString * uid);

@interface PlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *WJLImageView;
- (IBAction)PreClick:(UIButton *)sender;
- (IBAction)StopClick:(UIButton *)sender;
- (IBAction)NextClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *Cover;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,copy)PlayStatue Myblock;
@property (nonatomic) NSArray *dataSource;
@property (nonatomic,assign) BOOL isPlay;
@property (nonatomic,assign) BOOL alreadyPlay;
@property (nonatomic,assign) NSString * PlayId;

+ (instancetype)sharedInstance;
@end
