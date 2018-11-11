//
//  AuthorizationModel.m
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/9.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import "XXAuthorizationModel.h"

NSString *const XXAuthorizationCellIdentifier = @"XXAuthorizationCellIdentifier";

@implementation XXAuthorizationModel

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
