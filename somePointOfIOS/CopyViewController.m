//
//  CopyViewController.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/1/17.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "CopyViewController.h"

@interface CopyViewController ()

//演示错误写法,这里不应该写copy
@property (nonatomic , copy ) NSMutableArray *mutableArray;
@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"copy关键字错误使用";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     如果可变数组属性用copy修饰,那么给可变数组属性赋值的时候就会得到一个赋值出的不可变的数组类型的对象,这样在之后的之后的使用中,如果对这个属性进行增删改查操作,程序就会崩溃.
     */
    NSMutableArray *Marray = [NSMutableArray arrayWithObjects:@1,@2, nil];
    self.mutableArray = Marray;
    [self.mutableArray removeObjectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
