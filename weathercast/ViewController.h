//
//  ViewController.h
//  weathercast
//
//  Created by 刘鹏 on 2019/6/26.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class WeatherDataStore;

@interface ViewController : UIViewController

@property (nonatomic,copy) NSString *currentCity;
@property (nonatomic,strong) NSDictionary *nowWeatherDataShow;
@property (nonatomic,strong) NSDictionary *forecastWeatherDataShow;
@property (nonatomic,copy) NSString *temperature;
@property (nonatomic,copy) NSString *currentWeather;
@property (nonatomic,copy) NSString *humidity;
@property (nonatomic,copy) NSString *pressure;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *tomorrowWeather;
@property (nonatomic,copy) NSString *tomorrowHighTemp;
@property (nonatomic,copy) NSString *tomorrowLowTemp;
@property (nonatomic,copy) NSString *todayHighTemp;
@property (nonatomic,copy) NSString *todayLowTemp;


@end

