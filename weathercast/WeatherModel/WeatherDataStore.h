//
//  WeatherDataStore.h
//  weathercast
//
//  Created by 刘鹏 on 2019/6/27.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherDataStore : NSObject

#pragma mark - public method

- (void)savedata:(id)data;
- (void)saveForecast:(id)forecastData;
    
@end

NS_ASSUME_NONNULL_END
