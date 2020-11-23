//
//  WeatherDataStore.m
//  weathercast
//
//  Created by 刘鹏 on 2019/6/27.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import "WeatherDataStore.h"

@implementation WeatherDataStore

/**  保存当前天气相关参数 */
- (void)savedata:(id)nowData {
    NSString *floderPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *storePath = [floderPath stringByAppendingString:@"/nowWeather.plist"];
    BOOL successGetData = [nowData writeToFile:storePath atomically:YES];
    if (!successGetData) {
        NSLog(@"保存当前天气失败");
    }
}

/**  保存今日盒明日的预测天气相关参数 */
- (void)saveForecast:(id)forecastData{
    NSString *floderPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *storePath = [floderPath stringByAppendingString:@"/forecastWeather.plist"];
    BOOL successGetData = [forecastData writeToFile:storePath atomically:YES];
    if (!successGetData) {
        NSLog(@"保存预报天气失败");
    }
}
@end
