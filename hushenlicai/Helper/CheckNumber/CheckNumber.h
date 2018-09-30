//
//  CheckNumber.h
//  MiaoWo
//
//  Created by WPY on 2017/2/23.
//  Copyright © 2017年 WPY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckNumber : NSObject
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;
#pragma 正则匹配用户密码6-16位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password;
+ (BOOL)checkVerificationCode:(NSString *)code;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;
#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url;

#pragma mark 判断银行卡号是否合法
+(BOOL)isBankCard:(NSString *)cardNumber;
@end
