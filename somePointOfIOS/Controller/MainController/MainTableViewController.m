//
//  MainTableViewController.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/1/17.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//  本类中使用了运行时动态创建类,只有在运行的时候,才决定要跳转的下级界面是哪一个,可以节省大量代码,也可以通过网络请求类的信息,动态创建类,灵活性很高.

#import "MainTableViewController.h"
#import "FilletViewController.h"
#import "CopyViewController.h"
#import "MethodSwizzViewController.h"
#import "NSString+EOCADditions.h"
#import "SerialSynchronizationQueueVC.h"
#import "GCDVC.h"
#import "ZZFKvoClass.h"
#import "ZZFRuntimeA.h"
#import "ZZFRuntime.h"
#import <objc/runtime.h>
#import "CategoryVC.h"
#import "ExtensionVC.h"

@interface MainTableViewController ()
{
    NSMutableArray *array;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZZF";
    array = [[NSMutableArray alloc]initWithArray:@[
                                                   @{@"title":@"圆角图片",
                                                     @"class":@"FilletViewController"
                                                     },
                                                   @{@"title":@"copy关键字",
                                                     @"class":@"CopyViewController"
                                                     },
                                                   @{@"title":@"GCD实现同步锁",
                                                     @"class":@"SerialSynchronizationQueueVC"
                                                     },
                                                   @{@"title":@"GCD多线程",
                                                     @"class":@"GCDVC"
                                                     },
                                                   @{@"title":@"KVO",
                                                     @"class":@"ZZFKvoClass"
                                                     },
                                                   @{@"title":@"runtime集合",
                                                     @"class":@"ZZFRuntime"
                                                     },
                                                   @{@"title":@"Category",
                                                     @"class":@"CategoryVC"
                                                     },
                                                   @{@"title":@"Extension",
                                                     @"class":@"ExtensionVC"
                                                     },
                                                   ]];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = ((NSDictionary *)array[indexPath.row])[@"title"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    //取出列表信息字典中的类名
    NSString *classnameStr = (array[indexPath.row])[@"class"];
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
//    UINavigationController *naVC = (UINavigationController *)self.navigationController;
    //跳转到对应的控制器
    [self.navigationController pushViewController:instance animated:YES];
}

@end
