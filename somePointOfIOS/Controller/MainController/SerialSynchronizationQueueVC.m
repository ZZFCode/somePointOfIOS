//
//  SerialSynchronizationQueueVC.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/2/8.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//
/**
 使用GCD实现同步锁,解决资源抢占问题
 
 */

#import "SerialSynchronizationQueueVC.h"

@interface SerialSynchronizationQueueVC ()
{
    dispatch_queue_t _syncQueue;
    NSMutableArray   *_marray;
}
@end

@implementation SerialSynchronizationQueueVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _syncQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    self.marray = [NSMutableArray arrayWithArray:@[@1,@2]];
    
    
    dispatch_barrier_async(_syncQueue, ^{
        NSLog(@"数组属性是:%@",self.marray);
    });
    
}

//marray的get方法

-(NSMutableArray *)marray{
    __block NSMutableArray *tmpArray;
    dispatch_sync(_syncQueue, ^{
        tmpArray = _marray;
    });
    return tmpArray;
}

/*
 dispatch_barrier_async 栅栏
 在队列中,栅栏必须单独执行,不能与其他块并行,这只对并发队列有意义,因为串行队列中的块总是按照逐个顺序来的.
 并发队列如果发现又一个栅栏块要执行,就会等待当前所有并发块都执行完毕,才会单独执行这个栅栏块,这样写入操作就是单独执行的了,就不会发生多个线程同时写入数据的问题.
 */
-(void)setMarray:(NSMutableArray *)marray{
    dispatch_barrier_async(_syncQueue, ^{
        _marray = marray;
    });
}
@end
