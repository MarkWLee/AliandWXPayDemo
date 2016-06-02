//
//  MLWechatPay.m
//  支付Demo
//
//  Created by Mark_Lee on 16/5/22.
//  Copyright © 2016年 MarkLee. All rights reserved.
//

#import "MLWechatPay.h"


@implementation MLWechatPay

+ (instancetype)shareWechatPay
{
    static dispatch_once_t onceToken;
    static MLWechatPay *instance;
    dispatch_once(&onceToken, ^{
        instance = [[MLWechatPay alloc] init];
    });
    return instance;
}

#pragma mark 调起微信支付
- (void)WXPayWithDic:(NSDictionary *)dict
{
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );

            }else{
                NSLog(@"%@",[dict objectForKey:@"retmsg"]);
            }
        }else{
            NSLog(@"%@",@"服务器返回错误，未获取到json对象");
        }
    }else{
        NSLog(@"%@",@"服务器返回错误") ;
}

}

#pragma WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    NSString *strMsg;
    switch (resp.errCode) {
        case WXSuccess:
            strMsg = @"支付结果：成功！";
            NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
            break;
            
        default:
            strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
            NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
            break;
    }
}
@end

