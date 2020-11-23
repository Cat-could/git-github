//
//  InternetModel.m
//  weathercast
//
//  Created by 刘鹏 on 2019/6/27.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import "InternetModel.h"
#import "WeatherDataStore.h"

@implementation InternetModel

/** 使用get方法连接天气数据服务器，获取当前天气的相关数据并保存 */
- (void)httpLink:(NSString *)currentCity{
    NSString *stringUrl = [NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather/now?location=%@&key=cbd779e2141b45938d845a2a8cb2345c",currentCity];
    stringUrl = [stringUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url= [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"连接错误 %@",connectionError);
            return ;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200 || httpResponse.statusCode ==304) {
            //解析数据json形式的字符串
            id dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            WeatherDataStore *storeData = [[WeatherDataStore alloc]init];
            [storeData savedata:dic];//保存获取的当前天气数据
           // [storeData getData];
        }else{
            NSLog(@"服务器内部错误");
        }
    }];
}

    @end
