

//
//  ZZFKvoClass.m
//  somePointOfIOS
//
//  Created by AVIC_IOS_ZZF on 2018/3/6.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "ZZFKvoClass.h"

@interface ZZFKvoClass ()

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *Persontitle;

@end

@implementation ZZFKvoClass

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"xiaoming";
    self.title = @"boss";
    
    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.name = @"laowang";
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"%@对象的%@属性改变了：%@", object, keyPath, change);
    NSLog(@"%@",self);
}
-(NSString *)description{
    return [NSString stringWithFormat:@"重写了description方法"];
}
@end
