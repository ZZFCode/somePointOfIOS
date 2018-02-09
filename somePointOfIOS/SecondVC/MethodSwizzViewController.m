//
//  MethodSwizzViewController.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/2/5.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "MethodSwizzViewController.h"
#import "NSString+EOCADditions.h"
#import <objc/runtime.h>

@interface MethodSwizzViewController ()

@end

@implementation MethodSwizzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runtime];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *string = @"HELLO WORLD";
    NSString *lowercaseString = [string lowercaseString];
    NSLog(@"%@",lowercaseString);
}

//使用runtime交换NSString自带的方法lowercaseString和自定义的分类的eoc_myLowercaseString方法的实现
-(void)runtime{
    Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method newMethod = class_getInstanceMethod([NSString class], @selector(eoc_myLowercaseString));
    method_exchangeImplementations(originalMethod, newMethod);
}
@end
