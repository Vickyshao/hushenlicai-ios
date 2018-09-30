//
//  YXAFNetworkingTool.m
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/3.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import "YXAFNetworkingTool.h"

@implementation YXAFNetworkingTool

+ (instancetype)shareAFNetworkingTool{
    static YXAFNetworkingTool *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (NSURLSessionDataTask *)GETURLString:(NSString *)URLString params:(id)params andSuccessBlock:(void(^)(id success))successBlock andErrorBlock:(void(^)(NSError *error))errorBlock withControler:(UIViewController *)controller{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask =  [manager GET:URLString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    return dataTask;
}
    
@end
