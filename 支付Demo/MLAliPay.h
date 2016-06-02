//
//  MLAliPay.h
//  支付Demo
//
//  Created by Mark_Lee on 16/5/22.
//  Copyright © 2016年 MarkLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLAliPay : NSObject
/**
 *  发起支付宝支付
 *
 *  @param dic 服务器返回的字典数据
 */
+ (void)aliPayWithDic:(NSDictionary *)dic;
@end
