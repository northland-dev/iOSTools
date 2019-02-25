//
//  FSCommenDefine.h
//  Ready
//
//  Created by jiapeng on 2018/7/17.
//  Copyright © 2018年 Fission. All rights reserved.
//

#ifndef FSCommenDefine_h
#define FSCommenDefine_h

//1线上 2测试
#define Evt 2

#if Evt == 1
#define IMCLIENT_APP_KEY @"cpj2xarlc7yhn"     //线上
#define APIAdressConFig   @"https://resource-api.readygo.live/"      //配置地址    线上

#elif Evt == 2
#define IMCLIENT_APP_KEY @"6tnym1br64wf7"       //测试
#define APIAdressConFig    @"http://10.10.32.149:6011/"               //配置地址    测试

#elif Evt == 4
#else
#endif


#define CurrentV      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_VERSION   CurrentV
#define AppName  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
//基于8的屏幕比率
#define ScreenW [[UIScreen mainScreen] bounds].size.width
#define ScreenH [[UIScreen mainScreen] bounds].size.height
#define ScreenF  CGRectMake(0,0,MIN([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width),MAX([[UIScreen mainScreen] bounds].size.height,[[UIScreen mainScreen] bounds].size.width))

#define isX ((BOOL)(ScreenH == 812))
#define isP ((BOOL)(ScreenH == 736))
#define is4S ((BOOL)(ScreenH == 480))
#define is5s ((BOOL)(ScreenH == 640))

#define ScreenH_X ((CGFloat)812.0)
#define ScreenH_P ((CGFloat)736.0)
#define ScreenH_4S ((CGFloat)480.0)

#define StatusH ((CGFloat)(isX ? 44.0 : (isP ? 27 : 20)))
#define NavH ((CGFloat)44.0)

#define EffectAreaH ((CGFloat)(isX ? 812.0 : (is4S ? 480.0 : 667.0)))
#define EffectAreaExceptStatusH ((CGFloat)(EffectAreaH - StatusH))
#define EffectAreaExceptNavH ((CGFloat)(EffectAreaExceptStatusH - NavH))

#define StanderScreenH ((CGFloat)667.0)
#define StanderScreenExceptStatusH ((CGFloat)(667.0 - 20.0))
#define StanderScreenExceptNavH ((CGFloat)(StanderScreenExceptStatusH - NavH))


#define WidthScale(w) ((w/375.0)*ScreenW)//基于8的屏幕比率
#define HeightScale(h) ((CGFloat)(h / StanderScreenH * EffectAreaH))
#define HeightScaleExceptStutaus(h) ((CGFloat)(h / StanderScreenExceptStatusH * EffectAreaExceptStatusH))
#define HeightScaleExceptSNav(h) ((CGFloat)(h / StanderScreenExceptNavH * EffectAreaExceptNavH))

#define locStrBy(key) ((NSString *)[FSSharedLanguages CustomLocalizedStringWithKey:key])
#define IntoString(a) ((NSString *)[NSNumber numberWithInteger:a].stringValue)

#define Google_APP_ID @"115029545324-9j9ve284labb7vsn30uciinm9r0d43hf.apps.googleusercontent.com"
#define Bugly_APP_ID @"607522efe3"
#define Bugly_APP_KEY @"e0713017-eeb6-4a2e-91d3-3375c8fb8c2b"

#define TenorApiKey @"GJMIGFL7ULNT"

#define APPSTORE_ID      @"1434795631"
#define APPSTORE_DOWNLOAD  @"https://itunes.apple.com/us/app/ready-go/id"   //@"itms-apps://itunes.apple.com/tw/app/id"
//配置文件存储
#define FSConfigInfoFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FSConfigInfo.data"]
//举报名单
#define FSReportFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FSReportFile.data"]
//拉黑列表文件存储
#define FSBlackListFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"FSBlackListFile.data"]

//添加好友消息数存储key
#define AddFriendsMessageKey      @"AddFriendsMessageKey"
//当前好友消息数存储key
#define FriendsMessageKey         @"FriendsMessageKey"
//24小时临时会话key
#define TemporarySession         @"TemporarySession"


#define TOKEN_KEY        @"IMToken"
#define APIConFig          @"global/nav"                              //配置接口


#define ImageResourceUrl   [[FSGlobalLauncher launcher].allKeyDict stringForKey:@"system_resource_url"]
#define HeadeResourceUrl   [[FSGlobalLauncher launcher].allKeyDict stringForKey:@"resource_head_pic"]

#define SmallPlaceHolderImage ((UIImage *)[UIImage imageNamed:@"G_head_placeholder"])
#define LargePlaceHolderImage ((UIImage *)[UIImage imageNamed:@"ProfilebackPlace"])
#define GamePlaceHolderImage ((UIImage *)[UIImage imageNamed:@"G_placeholder_game"])


#define DocumentPath ((NSString *)NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES).firstObject)
#define WEBPath ((NSString *)[DocumentPath stringByAppendingString:@"/web"])
#define ZIPPath ((NSString *)[DocumentPath stringByAppendingString:@"/zip"])

#define MAS_COMPLETION( b)   [UIView animateWithDuration:0.00001 animations:^{} completion:^(BOOL finished) {b;}]

#define notificationAdd(a) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReciveNotification:) name:a object:nil]

#define kTwitterConsumerKey @"fcVWOlr6cEfj77RnHTpC8WHRx"
#define kTwitterConsumerSecret @"DoLHAiXRaaKZb7xhVQWeqeCWRttQN9gNttENF78v9XkQp68O9W"
#define kTwitterRedirectUri @"https://www.readygo/live"
//
//#define kTwitterConsumerKey @"9GH40ETUH8lUXhXmrTjkBkoWk" /*9GH40ETUH8lUXhXmrTjkBkoWk*/
//#define kTwitterConsumerSecret @"WWD7zLkzuiVQVyqQQwi2DaUZoBF4stZlx4NdnWsQ3KPYZNfG1L"

#define kAppRedirectURL @"http://www.7nujoom.com"
#define kInstagramAppKey @"20fc0c87c37b41518a6b9db862f6b88c"
#define kInstagramAppSecret @"90015b01853d41ccb9b19c78a7af5514"

#endif /* FSCommenDefine_h */
