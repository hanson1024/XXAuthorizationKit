//
//  AuthorizationModel.h
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/9.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AuthorizationModelType) {
    AuthorizationModelTypeLocation = 0,                         // no button type
    AuthorizationModelTypeCoreBlue
};

@interface XXAuthorizationModel : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *VC;
/** <#注释#> */
@property (nonatomic, copy) NSString *type;
/** <#注释#> */
@property (nonatomic, copy) NSString *title;

@end

#pragma mark - ------------------- XXAuthorizationCell ----------------------

@interface XXAuthorizationCell : UITableViewCell
/** <#注释#> */
@property (nonatomic, strong) XXAuthorizationModel *model;

@end

@implementation XXAuthorizationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
    }
    return self;
}

-(void)setModel:(XXAuthorizationModel *)model {
    
    _model = model;
    self.textLabel.text = model.title;
}

@end
