//
//  URlRequest.m
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/3.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import "URlRequest.h"
static NSString *main_url = @"https://hushenlicai";

static NSString *loading_url = @"";

@implementation URlRequest

    
+ (NSString *)loadingUrl
{
    return [main_url stringByAppendingString:loading_url];
}
    
@end
