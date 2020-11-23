//
//  ViewController.m
//  weathercast
//
//  Created by 刘鹏 on 2019/6/26.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import "ViewController.h"
#import "WeatherDataStore.h"
#import "InternetModel.h"
#import "InternetForecastModel.h"
#import "CityViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UILabel *weatherLabel;
@property (nonatomic, strong) UILabel *cityLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *temperatureLabel;
@property (nonatomic, strong) UILabel *pressureLabel;
@property (nonatomic, strong) UILabel *humidityLabel;
@property (nonatomic, strong) UILabel *tomorrowWeatherLabel;
@property (nonatomic, strong) UILabel *tomorrowTemperatureRangeLabel;
@property (nonatomic, strong) UILabel *todayWeatherLabel;
@property (nonatomic, strong) UILabel *todayTemperatureRangeLabel;

@end


@implementation ViewController

#pragma mark - Setters && Getters

- (NSDictionary *)nowWeatherDataShow {
   // if (_weatherDataShow == nil) {
        NSString *floderPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSLog(@"%@",floderPath);
        NSString *storePath = [floderPath stringByAppendingString:@"/nowWeather.plist"];
        _nowWeatherDataShow = [NSDictionary dictionaryWithContentsOfFile:storePath];
   // }
    return _nowWeatherDataShow;
}

- (NSDictionary *)forecastWeatherDataShow {
    NSString *floderPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",floderPath);
    NSString *storePath = [floderPath stringByAppendingString:@"/forecastWeather.plist"];
    _forecastWeatherDataShow = [NSDictionary dictionaryWithContentsOfFile:storePath];
    return _forecastWeatherDataShow;
}

#pragma mark - Overridden (Life Cycle)

- (void)loadView {
    [super loadView];
    UIImage *image = [UIImage imageNamed:@"background.jpg"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    UIImageView *weatherView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    weatherView.image = image;
    [self.view addSubview:weatherView];
    
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 30)];
    self.cityLabel.backgroundColor = [UIColor clearColor];
    self.cityLabel.textColor = [UIColor whiteColor];
    self.cityLabel.text = @"深圳";
    self.currentCity = @"深圳";
    self.cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.cityLabel];

    self.weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 150, 300, 40)];
    self.weatherLabel.backgroundColor = [UIColor clearColor];
    self.weatherLabel.text = @"天气描述";
    self.weatherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.weatherLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.weatherLabel];

    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, 50, 40)];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView.backgroundColor = [UIColor clearColor];
    self.iconView.image = [UIImage imageNamed:@"sun.png"];
    [self.view addSubview:self.iconView];
    
    self.temperatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 220, 240, 100)];
    self.temperatureLabel.backgroundColor = [UIColor clearColor];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.text = @"0°";
    self.temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:80];
    [self.view addSubview:self.temperatureLabel];
    
    self.pressureLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 320, 100, 40)];
    self.pressureLabel.backgroundColor = [UIColor clearColor];
    self.pressureLabel.textColor = [UIColor whiteColor];
    self.pressureLabel.text = @" 0 Pa";
    self.pressureLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    [self.view addSubview:self.pressureLabel];

    self.humidityLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 320, 100, 40)];
    self.humidityLabel.backgroundColor = [UIColor clearColor];
    self.humidityLabel.textColor =[UIColor whiteColor];
    self.humidityLabel.text =@" 0 %";
    self.humidityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
    [self.view addSubview:self.humidityLabel];
    
    self.todayWeatherLabel =[[UILabel alloc]initWithFrame:CGRectMake(30, 740, 207, 100)];
    self.todayWeatherLabel.backgroundColor = [UIColor clearColor];
    self.todayWeatherLabel.textColor =[UIColor blueColor];
    self.todayWeatherLabel.text =@"今日天气";
    self.todayWeatherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.view addSubview:self.todayWeatherLabel];

    self.tomorrowWeatherLabel =[[UILabel alloc]initWithFrame:CGRectMake(237, 740, 207, 100)];
    self.tomorrowWeatherLabel.backgroundColor = [UIColor clearColor];
    self.tomorrowWeatherLabel.textColor =[UIColor blueColor];
    self.tomorrowWeatherLabel.text =@"明日天气";
    self.tomorrowWeatherLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.view addSubview:self.tomorrowWeatherLabel];
    
    UILabel *todayTitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 700, 50, 100)];
    todayTitle.backgroundColor = [UIColor clearColor];
    todayTitle.textColor = [UIColor blueColor];
    todayTitle.text = @"今日";
    todayTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.view addSubview:todayTitle];
    
    UILabel *tomorrowTitle = [[UILabel alloc]initWithFrame:CGRectMake(237, 700, 50, 100)];
    tomorrowTitle.backgroundColor = [UIColor clearColor];
    tomorrowTitle.textColor = [UIColor blueColor];
    tomorrowTitle.text = @"明日";
    tomorrowTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.view addSubview:tomorrowTitle];
    
    self.todayTemperatureRangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 700, 80, 100)];
    self.todayTemperatureRangeLabel.backgroundColor = [UIColor clearColor];
    self.todayTemperatureRangeLabel.textColor = [UIColor blueColor];
    self.todayTemperatureRangeLabel.text = @"0";
    self.todayTemperatureRangeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.view addSubview:self.todayTemperatureRangeLabel];
    
    self.tomorrowTemperatureRangeLabel = [[UILabel alloc]initWithFrame:CGRectMake(317, 700, 80, 100)];
    self.tomorrowTemperatureRangeLabel.backgroundColor = [UIColor clearColor];
    self.tomorrowTemperatureRangeLabel.textColor = [UIColor blueColor];
    self.tomorrowTemperatureRangeLabel.text = @"0";
    self.tomorrowTemperatureRangeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    [self.view addSubview:self.tomorrowTemperatureRangeLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel* show = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    show.text = @"天气预报";
    show.textColor = [UIColor blueColor];
    show.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = show;
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(onClick:)];
    [addBtn setTag:1];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(onClick:)];
    [searchBtn setTag:2];
    
    self.navigationItem.leftBarButtonItem = addBtn;
    self.navigationItem.rightBarButtonItem = searchBtn;
    
    InternetModel *nowWeatherLink = [[InternetModel alloc]init];
    [nowWeatherLink httpLink:self.currentCity];
    InternetForecastModel *forecastWeatherLink = [[InternetForecastModel alloc]init];
    [forecastWeatherLink httpLinkToForecast:self.currentCity];
    [self updateUI];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(updateUI) userInfo:nil repeats:NO];
}

- (void)onClick:(id)sender {
    UIBarButtonItem* button = (UIBarButtonItem*)sender;
    if (button.tag == 1) {
        NSLog(@"----新增----------");
    }
    else if (button.tag == 2) {
        NSLog(@"----跳转----------");
        CityViewController* cityView = [[CityViewController alloc] init];
        [self.navigationController pushViewController:cityView animated:YES];
    }
}

#pragma mark - Private Method (Action)

- (void)processNowData:(id)nowData {
    NSMutableArray *jasonData = [nowData objectForKey:@"HeWeather6"];
    if ([jasonData.firstObject[@"status"] isEqualToString:@"ok"]) {
        self.currentWeather = jasonData.firstObject[@"now"][@"cond_txt"];
        self.temperature = jasonData.firstObject[@"now"][@"tmp"];
        self.humidity = jasonData.firstObject[@"now"][@"hum"];
        self.pressure = jasonData.firstObject[@"now"][@"pres"];
        //self.time = jasonData.firstObject[@"update"][@"loc"];
    }
}

#pragma mark - Private Metho

- (void)processForecastData:(id)forestData {
    NSMutableArray *jasonData = [forestData objectForKey:@"HeWeather6"];
    if ([jasonData.firstObject[@"status"] isEqualToString:@"ok"]) {
        self.todayHighTemp = jasonData.firstObject[@"daily_forecast"][0][@"tmp_max"];
        self.todayLowTemp = jasonData.firstObject[@"daily_forecast"][0][@"tmp_min"];
        self.tomorrowWeather = jasonData.firstObject[@"daily_forecast"][1][@"cond_txt_d"];
        self.tomorrowHighTemp = jasonData.firstObject[@"daily_forecast"][1][@"tmp_max"];
        self.tomorrowLowTemp = jasonData.firstObject[@"daily_forecast"][1][@"tmp_min"];
    }
}

- (void)updateUI {
    [self processNowData:self.nowWeatherDataShow];
    [self processForecastData:self.forecastWeatherDataShow];
    
    self.temperatureLabel.text = [self.temperature stringByAppendingString:@" ° "];
    [self.view addSubview:self.temperatureLabel];
    
    self.weatherLabel.text = self.currentWeather;
    [self.view addSubview:self.weatherLabel];
    
    if ([self.currentWeather isEqualToString:@"晴"]) {
        self.iconView.image = [UIImage imageNamed:@"sun.png"];
    } else if ([self.currentWeather isEqualToString:@"多云"]) {
        self.iconView.image = [UIImage imageNamed:@"cloudy.png"];
    } else if ([self.currentWeather isEqualToString:@"雪"]) {
        self.iconView.image = [UIImage imageNamed:@"snow.png"];
    } else {
         self.iconView.image = [UIImage imageNamed:@"overcast.png"];
    }
    
    [self.view addSubview:self.iconView];
    
    self.humidityLabel.text = [self.humidity stringByAppendingString:@" % "];
    [self.view addSubview:self.humidityLabel];
    
    self.pressureLabel.text = [self.pressure stringByAppendingString:@" Pa "];
    [self.view addSubview:self.pressureLabel];
    
    self.cityLabel.text = [self.currentCity stringByAppendingString:@" "];
    [self.view addSubview:self.cityLabel];
    
    self.tomorrowWeatherLabel.text =self.tomorrowWeather;
    [self.view addSubview:self.tomorrowWeatherLabel];
    
    self.todayWeatherLabel.text = self.currentWeather;
    [self.view addSubview:self.todayWeatherLabel];
    
    self.todayTemperatureRangeLabel.text = [self.todayLowTemp stringByAppendingString:[@"° / " stringByAppendingString:[self.todayHighTemp stringByAppendingString:@"°"]]];
    [self.view addSubview:self.todayTemperatureRangeLabel];
    
    self.tomorrowTemperatureRangeLabel.text = [self.tomorrowLowTemp stringByAppendingString:[@"° / " stringByAppendingString:[self.tomorrowHighTemp stringByAppendingString:@"°"]]];
    [self.view addSubview:self.tomorrowTemperatureRangeLabel];
}


@end
