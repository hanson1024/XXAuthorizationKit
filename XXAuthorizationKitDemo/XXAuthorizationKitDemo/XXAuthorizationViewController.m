//
//  AuthorizationViewController.m
//  XXAuthorizationKitDemo
//
//  Created by luo on 2018/11/9.
//  Copyright © 2018年 hanson. All rights reserved.
//

#import "XXAuthorizationViewController.h"
#import "XXAuthorizationOperationViewController.h"

#import "NSObject+ObjectMap.h"

@interface XXAuthorizationViewController ()<UITableViewDelegate,UITableViewDataSource>

/** <#注释#> */
@property (nonatomic, strong) UITableView *tableView;

/** <#注释#> */
@property (nonatomic, strong) NSMutableArray <XXAuthorizationModel *>*dataSource;

@end

@implementation XXAuthorizationViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"XXAuthorization";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pri_handleParams];
    [self pri_setupTableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public methods
#pragma - mark
#pragma mark - private methods 添加 pri_ 前缀

-(void)pri_handleParams {
    
    NSArray *dateSource = @[@{@"VC":@"XXAuthorizationOperationViewController",
                              @"type":[NSNumber numberWithUnsignedInteger:AuthorizationModelTypeLocation],
                              @"title":@"XXCLLocationManager"},
                            @{@"VC":@"XXAuthorizationOperationViewController",
                              @"type":[NSNumber numberWithUnsignedInteger:AuthorizationModelTypeCoreBlue],
                              @"title":@"XXCoreBlueManager"}];
    
    _dataSource = [NSMutableArray arrayWithCapacity:dateSource.count];
    
    for (NSDictionary *dict in dateSource) {
        
        XXAuthorizationModel *model = [XXAuthorizationModel objectOfClass:@"XXAuthorizationModel" fromJSON:dict];
        [_dataSource addObject:model];
        
    }
}


-(void)pri_setupTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableView registerClass:NSClassFromString(@"XXAuthorizationCell") forCellReuseIdentifier:XXAuthorizationCellIdentifier];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
#pragma - mark
#pragma mark - delegate
#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XXAuthorizationCell *cell = [tableView dequeueReusableCellWithIdentifier:XXAuthorizationCellIdentifier forIndexPath:indexPath];
    cell.model = [_dataSource objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XXAuthorizationModel *model = [_dataSource objectAtIndex:indexPath.row];
    
    if ([@"XXAuthorizationOperationViewController" isEqualToString:model.VC]) {
        
        XXAuthorizationOperationViewController *VC = [NSClassFromString([_dataSource objectAtIndex:indexPath.row].VC) new];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

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
