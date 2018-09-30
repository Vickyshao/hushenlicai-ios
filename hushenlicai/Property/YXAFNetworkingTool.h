//
//  YXAFNetworkingTool.h
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/3.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXAFNetworkingTool : NSObject
    
+ (instancetype)shareAFNetworkingTool;
    
- (NSURLSessionDataTask *)GETURLString:(NSString *)URLString params:(id)params andSuccessBlock:(void(^)(id success))successBlock andErrorBlock:(void(^)(NSError *error))errorBlock withControler:(UIViewController *)controller;
@end
