//
//  XXCoreBlueManager.h
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/12.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define kPoweredOnKey @"XXAuthorizationKitDemo_PoweredOnKey"

typedef void(^XXCoreBlueManagerUpdateParamsBlock)(CBManagerState coreBlueStatus);

@interface XXCoreBlueManager : NSObject

+ (instancetype )startUpdatingCoreBlueWithUpdateBlock:(XXCoreBlueManagerUpdateParamsBlock )block;

@end
