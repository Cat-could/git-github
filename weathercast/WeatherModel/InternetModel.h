//
//  InternetModel.h
//  weathercast
//
//  Created by 刘鹏 on 2019/6/27.
//  Copyright © 2019 刘鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InternetModel : NSObject
//@property (nonatomic,strong) NSString *currentCity;//当前城市
//@property (nonatomic,assign) NSInteger cityIndex;//城市索引

#pragma mark - public method

- (void)httpLink:(NSString *)currentCity;

@end

NS_ASSUME_NONNULL_END
