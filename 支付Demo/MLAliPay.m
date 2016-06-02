//
//  MLAliPay.m
//  支付Demo
//
//  Created by Mark_Lee on 16/5/22.
//  Copyright © 2016年 MarkLee. All rights reserved.
//

#import "MLAliPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "MLPayOrder.h"
@implementation MLAliPay
+ (void)aliPayWithDic:(NSDictionary *)dic
{
    MLPayOrder *order = [[MLPayOrder alloc] initWithDic:dic];
    NSString *aliPayOreder = [order description];
    NSString *appScheme = @"alisdkdemo";
    id<DataSigner> signer = CreateRSADataSigner(MLPayAliPrivateKeyValue);
    NSString *signedString = [signer signString:aliPayOreder];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       aliPayOreder, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }

}
@end
