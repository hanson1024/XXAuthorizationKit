//
//  XXCLLocationManager.m
//  XXCLLocationManagerDemo
//
//  Created by luo on 2018/11/8.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import "XXCLLocationManager.h"
#import <objc/runtime.h>

@interface XXCLLocation : CLLocationManager

@property (nonatomic, copy) XXCLLocationManagerUpdateParamsBlock updateBlock;

@end

@implementation XXCLLocation

@end

@interface XXCLLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) XXCLLocation *manager;

@end

@implementation XXCLLocationManager

#pragma mark - life cycle

-(instancetype)init {
    
    if (self = [super init]) {
        
        if ([CLLocationManager locationServicesEnabled]) {
            
            NSLog(@"--------start--------");
            
            self.manager = [[XXCLLocation alloc] init];
            self.manager.delegate = self;
            self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
            self.manager.distanceFilter = 10.0f;
            [self.manager requestAlwaysAuthorization];
            [self.manager startUpdatingLocation];
        }
    }
    
    return self;
}

+ (instancetype )startUpdatingLocationWithUpdateBlock:(XXCLLocationManagerUpdateParamsBlock )block {
    
    XXCLLocationManager *locationManager = [[XXCLLocationManager alloc] init];
    locationManager.manager.updateBlock = block;
    return locationManager;
}


#pragma mark - public methods

#pragma mark - Core Location status

+ (BOOL)isLocationUpdatesAvailable
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if ([CLLocationManager instancesRespondToSelector:@selector(requestWhenInUseAuthorization)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable" alwaysDescription
#pragma clang diagnostic ignored "-Wunused-variable" whenInUseDescription
#pragma clang diagnostic pop
        NSString *alwaysDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"];
        NSString *whenInUseDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"];
        NSAssert([alwaysDescription length] || [whenInUseDescription length], @"NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription key not present in the info.plist. Please add it in order to recieve location updates");
    }
    
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusNotDetermined:
            return YES;
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        default:
            return NO;
            break;
    }
#else
    switch (status) {
        case kCLAuthorizationStatusAuthorized:
        case kCLAuthorizationStatusNotDetermined:
            return YES;
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        default:
            return NO;
            break;
    }
#endif
}


#pragma - mark
#pragma mark - private methods 添加 pri_ 前缀

- (NSDictionary *)pri_handleObjForParams:(NSObject *)obj {
    
    NSMutableDictionary *objectDict = [@{} mutableCopy];
    for (NSString *key in [[self propertyDictionary:obj] allKeys]) {
        [objectDict setValue:[obj valueForKey:key] forKey:key];
    }
    return objectDict;
}

-(NSDictionary *)propertyDictionary:(NSObject *)obj {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:key forKey:key];
    }
    
    free(properties);
    return dict;
}

-(NSString *)nameOfClass {
    return [NSString stringWithUTF8String:class_getName([self class])];
}

#pragma - mark
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        NSLog(@"kCLErrorDenied");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"kCLErrorLocationUnknown");
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];

#if DEBUG
            //获取城市
            NSString *city = placemark.locality;
            NSString *name = placemark.name;
            NSString *thoroughfare = placemark.thoroughfare;
            NSString *subThoroughfare = placemark.subThoroughfare;
            NSString *subLocality = placemark.subLocality;
            NSString *administrativeArea = placemark.administrativeArea;
            NSString *subAdministrativeArea = placemark.subAdministrativeArea;
            NSString *postalCode = placemark.postalCode;
            NSString *ISOcountryCode = placemark.ISOcountryCode;
            NSString *country = placemark.country;
            NSString *inlandWater = placemark.inlandWater;
            NSString *ocean = placemark.ocean;
            NSArray *areasOfInterest = placemark.areasOfInterest;
            
            NSLog(@"city = %@",city);
            NSLog(@"name = %@",name);
            NSLog(@"thoroughfare = %@",thoroughfare);
            NSLog(@"subThoroughfare = %@",subThoroughfare);
            NSLog(@"subLocality = %@",subLocality);
            NSLog(@"administrativeArea = %@",administrativeArea);
            NSLog(@"subAdministrativeArea = %@",subAdministrativeArea);
            NSLog(@"postalCode = %@",postalCode);
            NSLog(@"ISOcountryCode = %@",ISOcountryCode);
            NSLog(@"country = %@",country);
            NSLog(@"inlandWater = %@",inlandWater);
            NSLog(@"ocean = %@",ocean);
            NSLog(@"areasOfInterest = %@",areasOfInterest);
            NSLog(@"areasOfInterest = %@",areasOfInterest);
            
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
#endif
            
            NSDictionary *params = [self pri_handleObjForParams:placemark];
            
            if (((XXCLLocation *)manager).updateBlock) {
                ((XXCLLocation *)manager).updateBlock(params);
            }
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //stop
    [manager stopUpdatingLocation];
    NSLog(@"--------end--------");
}

#pragma mark - tableViewDelegate
#pragma mark - event response
#pragma - mark
#pragma mark - lazy loading

@end



