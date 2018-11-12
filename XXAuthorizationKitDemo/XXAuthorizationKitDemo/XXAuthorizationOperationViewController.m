//
//  XXAuthorizationOperationViewController.m
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/11.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import "XXAuthorizationOperationViewController.h"

#import "XXCLLocationManager/XXCLLocationManager.h"

@interface XXAuthorizationOperationViewController ()

/** <#注释#> */
@property (nonatomic, strong) XXCLLocationManager *locationManager;

@end

@implementation XXAuthorizationOperationViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (self.model.type == AuthorizationModelTypeLocation) {
        if ([XXCLLocationManager isLocationUpdatesAvailable]) {
            _locationManager = [XXCLLocationManager startUpdatingLocationWithUpdateBlock:^(NSDictionary *locationParams) {
                NSLog(@"locationParams = %@",locationParams);
            }];
        }
    }else if (self.model.type == AuthorizationModelTypeCoreBlue) {
        
    }
}

#pragma mark - public methods
#pragma - mark
#pragma mark - private methods 添加 pri_ 前缀
#pragma - mark
#pragma mark - delegate
#pragma mark - tableViewDelegate
#pragma mark - event response
#pragma - mark
#pragma mark - lazy loading

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
