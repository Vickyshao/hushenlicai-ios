//
//  YXHelper.h
//  hushenlicai
//
//  Created by 喻晓彬 on 2017/8/3.
//  Copyright © 2017年 hushenlicai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXHelper : NSObject
    
/**
 时间格式化

 @param timestamp 时间戳
 @param format 转换格式  （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间字符串
 */
+(NSString *)yxTimestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
+(NSString *)yxTimestampSwitchTimeWithDate:(NSDate *)date andFormatter:(NSString *)format;

    
@end
