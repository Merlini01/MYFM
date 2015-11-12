//
//  PlayModel.h
//  MyFm
//
//  Created by Qianfeng on 15/10/27.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface PlayModel : BaseModel<DOUAudioFile>

/*
"id": "99388452",
"title": "夏洛特烦恼：换个角度看人生",
"cover": "http://image.xinli001.com/20151019/121029q0hhwt9i1etc0lue.jpg",
"url": "http://yiapi.xinli001.com/fm/media-url.mp3?flag=1&id=99388452&t=383",
"speak": "君君",
"favnum": "272",
"viewnum": "29277",
"is_teacher": false,
"absolute_url": "http://yiapi.xinli001.com/fm/fm-share-page/99388452",
"url_list": [],
"commentnum": "27",
"range": 5310215,
"duration": 663,
"diantai": {
    "id": "1005",
    "title": "君君",
    "cover": "http://image.xinli001.com//20150908/101024/289739.png",
    "fmnum": "13",
    "user_id": "271342362",
    "viewnum": "1484489",
    "content": "永远年轻，永远热泪盈眶。\r\n新浪微博：挽不住的发香",
    "favnum": "850",
    "user": {
        "id": "271342362",
        "nickname": "listen君君",
        "avatar": "http://image.xinli001.com//20150908/101024/289739.png!80"*/
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * speak;
@property (nonatomic, copy) NSString * viewnum;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) long int duration;

@property (nonatomic, copy) NSString * TCover;
@property (nonatomic, copy) NSString * TContent;




+ (NSArray *)detailModelList:(NSData *)data;
@end
