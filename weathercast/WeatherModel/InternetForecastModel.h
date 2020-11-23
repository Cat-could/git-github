//
//  InternetForecastModel.h
//  weathercast
//
//  Created by 刘鹏 on 2019/6/30.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InternetForecastModel : NSObject

#pragma mark - public method

- (void)httpLinkToForecast:(NSString *)currentCity;

@end

NS_ASSUME_NONNULL_END
