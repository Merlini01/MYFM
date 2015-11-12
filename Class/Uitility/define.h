//
//  define.h
//  MyFm
//
//  Created by Qianfeng on 15/10/26.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#ifndef define_h
#define define_h

#define WWidth [UIScreen mainScreen].bounds.size.width
#define WHeight [UIScreen mainScreen].bounds.size.height

#import "MyFactory.h"
#import "AFNetworking.h"
#import "MMProgressHUD.h"
#import "NetDataEngine.h"
#import "UIImageView+WebCache.h"
#import "JSONModel.h"
#import "DOUAudioStreamer.h"
#import "WJLFix.h"
#import "JHRefresh.h"
#import "WJLHelper.h"
#import "WJLRequest.h"
#import "UMSocial.h"

//首页分类
#define FIRSTTUIJIANURL @"http://yiapibox.xinli001.com/fm/home-list.json?key=c0d28ec0954084b4426223366293d190"

//夏洛特烦恼
#define XLTFN @"http://yiapi.xinli001.com/fm/broadcast-detail-old.json?key=c0d28ec0954084b4426223366293d190&id=%@"

//分类的详情列表
//http://yiapi.xinli001.com/fm/category-jiemu-list.json?key=c0d28ec0954084b4426223366293d190&offset=0&category_id=1&limit=20
#define CATETABLE @"http://yiapi.xinli001.com/fm/category-jiemu-list.json?key=c0d28ec0954084b4426223366293d190&offset=0&category_id=%lu&limit=%lu"

//更多心理FM
//http://yiapibox.xinli001.com/fm/newlesson-list.json?key=c0d28ec0954084b4426223366293d190&limit=20&offset=0
#define MOREXINLI @"http://yiapibox.xinli001.com/fm/newlesson-list.json?key=c0d28ec0954084b4426223366293d190&limit=20&offset=%lu"

//更多FM
//http://yiapibox.xinli001.com/fm/diantai-jiemu-list.json?diantai_id=1009&key=c0d28ec0954084b4426223366293d190&offset=0&limit=20
#define MOREFM @"http://yiapibox.xinli001.com/fm/diantai-jiemu-list.json?diantai_id=1009&key=c0d28ec0954084b4426223366293d190&offset=%lu&limit=20"
//发现滚动视图
//http://bapi.xinli001.com/fm2/hot_tag_list.json/?flag=4&key=c0d28ec0954084b4426223366293d190&rows=3&offset=0
#define FINDSCROLL @"http://bapi.xinli001.com/fm2/hot_tag_list.json/?flag=4&key=c0d28ec0954084b4426223366293d190&rows=3&offset=0"
//发现滚动视图详情
#define FINDDETAIL @"http://bapi.xinli001.com/fm2/broadcast_list.json/?rows=15&offset=%d&key=c0d28ec0954084b4426223366293d190&tag=%@"

//搜索
//http://bapi.xinli001.com/fm2/broadcast_list.json/?rows=15&offset=0&q=1&key=c0d28ec0954084b4426223366293d190
#define searchUrl @"http://bapi.xinli001.com/fm2/broadcast_list.json/?rows=15&offset=%d&q=%@&key=c0d28ec0954084b4426223366293d190"

//精华
//http://yiapi.xinli001.com/fm/forum-thread-list.json?flag=0&size=10&key=c0d28ec0954084b4426223366293d190&offset=50&type=1
#define BEST @"http://yiapi.xinli001.com/fm/forum-thread-list.json?flag=0&size=10&key=c0d28ec0954084b4426223366293d190&offset=%lu&type=1"


//评论详情
//http://yiapi.xinli001.com/fm/forum-comment-list.json?post_id=6017&key=c0d28ec0954084b4426223366293d190&offset=0&limit=10
#define COMMENTSDETIL @"http://yiapi.xinli001.com/fm/forum-comment-list.json?post_id=%@&key=c0d28ec0954084b4426223366293d190&offset=0&limit=%lu"
//用户信息
//http://bapi.xinli001.com/fm2/myuserinfo.json/?key=c0d28ec0954084b4426223366293d190&token=b0ca6678d14a741a56f396c01d00a006
#define MYInfo @"http://bapi.xinli001.com/fm2/myuserinfo.json/?key=c0d28ec0954084b4426223366293d190&token=%@"

//签到
//http://bapi.xinli001.com/fm2/qiandao.json/?key=c0d28ec0954084b4426223366293d190&token=b0ca6678d14a741a56f396c01d00a006
// token b0ca6678d14a741a56f396c01d00a006
#define QIANDAO @"http://bapi.xinli001.com/fm2/qiandao.json/?key=c0d28ec0954084b4426223366293d190&token=%@"

//短信验证
//http://bapi.xinli001.com/users/register_validcode.json/?phone=18037875679&key=c0d28ec0954084b4426223366293d190
#define MessageURL @"http://bapi.xinli001.com/users/register_validcode.json/?phone=%@&key=c0d28ec0954084b4426223366293d190"
#endif /* define_h */













