//
//  ExtensionVC.m
//  somePointOfIOS
//
//  Created by 左忠飞 on 2018/3/30.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "ExtensionVC.h"
#import "Person.h"
#import "Person+Player.h"
#import "Person+Teacher.h"

@interface ExtensionVC ()

@end

@implementation ExtensionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Person *xiaoming = [[Person alloc]init];
    [xiaoming run];
    [xiaoming playBall];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end



