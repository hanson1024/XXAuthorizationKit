//
//  XXCLLocationManager.h
//  XXCLLocationManagerDemo
//
//  Created by luo on 2018/11/8.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^XXCLLocationManagerUpdateParamsBlock)(NSDictionary *locationParams);

@interface XXCLLocationManager : NSObject

@property (nonatomic, copy) XXCLLocationManagerUpdateParamsBlock updateBlock;

+ (BOOL )isLocationUpdatesAvailable;

+ (instancetype )startUpdatingLocationWithUpdateBlock:(XXCLLocationManagerUpdateParamsBlock )block;

@end
