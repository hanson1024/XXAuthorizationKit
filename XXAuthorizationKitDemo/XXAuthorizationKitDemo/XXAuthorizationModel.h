//
//  AuthorizationModel.h
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/9.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const XXAuthorizationCellIdentifier;

typedef NS_ENUM(NSInteger, AuthorizationModelType) {
    AuthorizationModelTypeLocation = 0,                         // no button type
    AuthorizationModelTypeCoreBlue
};

@interface XXAuthorizationModel : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *VC;
/** <#注释#> */
@property (nonatomic, assign) AuthorizationModelType type;
/** <#注释#> */
@property (nonatomic, copy) NSString *title;

@end

#pragma mark - ------------------- XXAuthorizationCell ----------------------

@interface XXAuthorizationCell : UITableViewCell
/** <#注释#> */
@property (nonatomic, strong) XXAuthorizationModel *model;

@end

