//
//  UShareSDKModel.m
//  MiaoWo
//
//  Created by 喻晓彬 on 17/3/1.
//  Copyright © 2017年 WPY. All rights reserved.
//

#import "UShareSDKModel.h"
#import <UMengUShare/WeiboSDK.h>
#import <UMengUShare/WechatAuthSDK.h>
#import <UMengUShare/UMSocialQQHandler.h>
#import <UShareUI/UShareUI.h>

#import <UMSocialCore/UMSocialCore.h>
@implementation UShareSDKModel

+ (void)initUShareSDK
{
    //1
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58b8486d07fe651d78001444"];
    //     [ShareSDK setInterfaceOrientationMask:SSInterfaceOrientationMaskAll];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2ea872df23be7fa4" appSecret:@"1c56e1e3ab1072b3ccfc4f10f94f1144" redirectURL:@"http://mobile.umeng.com/social"];
    //                             weiboSDKCls:[WeiboSDK class]];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105967827"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];    //                                   wbApiCls:[WeiboApi class]];
    
        /* 设置新浪的appKey和appSecret */
    
   [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2252698026"  appSecret:@"7edd2bae6db09ac2377fa4bd14ef72b4" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
      
    
}


+ (void)customShareMenuItemWhitoutEditView:(NSDictionary *)params
{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)]];
       [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxColumnCountForPortraitAndBottom = 5;
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewTitleString = @"分享" ;
    [UMSocialShareUIConfig shareInstance].shareTitleViewConfig.shareTitleViewBackgroundColor = [UIColor whiteColor];
   
     [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageBGColor= [UIColor whiteColor];
    
    [UMSocialShareUIConfig shareInstance].shareContainerConfig.shareContainerBackgroundColor= [UIColor whiteColor];
    [UMSocialShareUIConfig shareInstance].shareContainerConfig.isShareContainerHaveGradient = 0;
//    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPadingTop = 20;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMarginBottom = 1;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMarginTop = 1;
    
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMarginLeft = 0;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMarginRight = 0;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxItemHeight= 90;
     [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageMaxRowCountForLandscapeAndMid = 2;
    
    [UMSocialShareUIConfig shareInstance].shareCancelControlConfig.shareCancelControlText = @"取消" ;
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  params[@"imageUrl"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:params[@"title"] descr:params[@"detailTitle"] thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = params[@"url"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
  }];
}

@end
