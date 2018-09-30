//
//  MainWebViewController.m
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/2.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//
/*
 采用Javascriptbridge 进行桥接
 */
#import "MainWebViewController.h"
#import <WebKit/WebKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WKWebViewJavascriptBridge.h"
@interface MainWebViewController () <WKUIDelegate,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;
@property  WKWebViewJavascriptBridge *webViewBridge;



@end

@implementation MainWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
   
    // Do any additional setup after loading the view.
}
- (void)initWKWebView{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) configuration:configuration];

    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"index.html" ofType:nil];
    NSString *localHtml = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:urlStr];
    [self.webView loadHTMLString:localHtml baseURL:fileUrl];
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
    
    self.webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.webViewBridge setWebViewDelegate:self];
    [self registerNativeFunction];
    [self.webViewBridge callHandler:@"testJSFunction" data:@"一个字符串" responseCallback:^(id responseData) {
        NSLog(@" rsp:  %@",responseData);
    }];
}

/**
 注册js要调用的  Native 功能
 */
- (void)registerNativeFunction
{
    [self registLocationFunction];
    [self registScanFunction];
    [self registGoBackFunction];
    [self registShakeFunction];
    [self registShareFunction];
    [self registPayFunction];

}
- (void)registLocationFunction
{
    [_webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        
        NSString *location = @"广东省深圳市南山区学府路XXXX号";
        // 将结果返回给js
        responseCallback(location);
    }];
}

- (void)registScanFunction
{
    // 注册的handler 是供 JS调用Native 使用的。
    [_webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"http://www.baidu.com";
        responseCallback(scanResult);
    }];
}

- (void)registShareFunction
{
    [_webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        NSString *title = [tempDic objectForKey:@"title"];
        NSString *content = [tempDic objectForKey:@"content"];
        NSString *url = [tempDic objectForKey:@"url"];
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        responseCallback(result);
    }];
}

- (void)regitstBGColorFunction
{
    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"colorClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        CGFloat r = [[tempDic objectForKey:@"r"] floatValue];
        CGFloat g = [[tempDic objectForKey:@"g"] floatValue];
        CGFloat b = [[tempDic objectForKey:@"b"] floatValue];
        CGFloat a = [[tempDic objectForKey:@"a"] floatValue];
        
        weakSelf.webView.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    }];
}

- (void)registPayFunction
{
    [_webViewBridge registerHandler:@"payClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        NSString *orderNo = [tempDic objectForKey:@"order_no"];
        long long amount = [[tempDic objectForKey:@"amount"] longLongValue];
        NSString *subject = [tempDic objectForKey:@"subject"];
        NSString *channel = [tempDic objectForKey:@"channel"];
        // 支付操作...
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"支付成功:%@,%@,%@",orderNo,subject,channel];
        responseCallback(result);
    }];
}

- (void)registShakeFunction
{
    [_webViewBridge registerHandler:@"shakeClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    }];
}

- (void)registGoBackFunction
{
    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"goNextPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        MainWebViewController *vc = [[MainWebViewController alloc]init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
