//
//  MLWechatPay.h
//  支付Demo
//
//  Created by Mark_Lee on 16/5/22.
//  Copyright © 2016年 MarkLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface MLWechatPay : NSObject<WXApiDelegate>
+ (instancetype)shareWechatPay;
- (void)WXPayWithDic:(NSDictionary *)dict;
@end
