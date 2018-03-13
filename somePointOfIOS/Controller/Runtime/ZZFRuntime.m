//
//  ZZFRuntime.m
//  somePointOfIOS
//
//  Created by AVIC_IOS_ZZF on 2018/3/13.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//  

#import <objc/runtime.h>
#import "ZZFRuntime.h"
#import "ZZFRuntimeA.h"
#import "MethodSwizzViewController.h"

@interface ZZFRuntime ()
@property (nonatomic , copy ) NSArray *array;
@end

@implementation ZZFRuntime

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.array = @[@{@"title":@"方法交换",
                     @"class":@"MethodSwizzViewController"
                     },
                   @{@"title":@"runtime获取和修改系统私有属性",
                     @"class":@"ZZFRuntimeA"
                     },
                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"runtimeCell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.text = self.array[indexPath.row][@"title"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出列表信息字典中的类名
    NSString *classnameStr = self.array[indexPath.row][@"class"];
    const char *className = [classnameStr cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        //创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册创建的类
        objc_registerClassPair(newClass);
    }
    //创建对象
    id instance = [[newClass alloc]init];
    //获取导航控制器
    UINavigationController *naVC = (UINavigationController *)self.navigationController;
    //跳转到对应的控制器
    [naVC pushViewController:instance animated:YES];
}

@end
