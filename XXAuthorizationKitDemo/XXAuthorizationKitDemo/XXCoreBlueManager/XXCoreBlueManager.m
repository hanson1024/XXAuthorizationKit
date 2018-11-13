//
//  XXCoreBlueManager.m
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/12.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import "XXCoreBlueManager.h"

@interface XXCoreBlue : CBCentralManager

@property (nonatomic, copy) XXCoreBlueManagerUpdateParamsBlock updateBlock;

@end

@implementation XXCoreBlue

@end

@interface XXCoreBlueManager ()<CBCentralManagerDelegate>
//UI
/** <#注释#> */
@property (nonatomic, strong) XXCoreBlue *coreBlue;

@end

@implementation XXCoreBlueManager

-(instancetype)init {
    
    if (self = [super init]) {
        
        NSLog(@"--------start--------");
        self.coreBlue = [[XXCoreBlue alloc] initWithDelegate:self queue:nil];
    }
    
    return self;
}

+ (instancetype )startUpdatingCoreBlueWithUpdateBlock:(XXCoreBlueManagerUpdateParamsBlock )block {
    
    XXCoreBlueManager *manager = [[XXCoreBlueManager alloc] init];
    manager.coreBlue.updateBlock = block;
    return manager;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    
    XXCoreBlue *coreBlue = (XXCoreBlue *)central;
    
    switch (central.state) {
            
        case CBManagerStateUnknown:
        {
            NSLog(@"%s, %d", __FUNCTION__, __LINE__);
        }
            break;
        case CBManagerStateResetting:
        {
            NSLog(@"%s, %d", __FUNCTION__, __LINE__);
        }
            break;
        case CBManagerStateUnsupported:
        {
            NSLog(@"%s, %d", __FUNCTION__, __LINE__);
        }
            break;
        case CBManagerStateUnauthorized:
        {
            NSLog(@"%s, %d", __FUNCTION__, __LINE__);
        }
            break;
        case CBManagerStatePoweredOn:
            //只有此状态下才可以进行扫描设备
        {
            NSLog(@"%s, %d", __FUNCTION__, __LINE__);
        }
            break;
        case CBManagerStatePoweredOff:
        {
            NSLog(@"%s, %d", __FUNCTION__, __LINE__);
        }
            break;
        default:
            break;
            
        }
    
    if (coreBlue.updateBlock) {
        coreBlue.updateBlock(central.state);
    }
}

@end
