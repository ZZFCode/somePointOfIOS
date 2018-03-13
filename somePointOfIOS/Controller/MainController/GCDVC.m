//
//  GCDVC.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/2/9.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//  GCD的用法

#import "GCDVC.h"

@interface GCDVC ()

@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self group];
}

//并行队列同步执行任务
/*
 在并行队列中执行同步任务结果:
 所有的任务都是按照顺序执行;
 只有一个线程就是主线程,没有开启新的线程;
 所有的任务都是在begin和end之间执行的,说明任务添加到队列中会被马上执行
 
 2018-02-09 13:32:45.621132+0800 圆角图片[3834:1386226] begin *************
 2018-02-09 13:32:45.621196+0800 圆角图片[3834:1386226] 1 block <NSThread: 0x17407bf00>{number = 1, name = main}
 2018-02-09 13:32:45.621238+0800 圆角图片[3834:1386226] 1 block <NSThread: 0x17407bf00>{number = 1, name = main}
 2018-02-09 13:32:45.621270+0800 圆角图片[3834:1386226] 2 block <NSThread: 0x17407bf00>{number = 1, name = main}
 2018-02-09 13:32:45.621301+0800 圆角图片[3834:1386226] 2 block <NSThread: 0x17407bf00>{number = 1, name = main}
 2018-02-09 13:32:45.621331+0800 圆角图片[3834:1386226] 3 block <NSThread: 0x17407bf00>{number = 1, name = main}
 2018-02-09 13:32:45.621361+0800 圆角图片[3834:1386226] 3 block <NSThread: 0x17407bf00>{number = 1, name = main}
 2018-02-09 13:32:45.621373+0800 圆角图片[3834:1386226] end ***************
 */
-(void)syncConcurrent{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"begin *************");

    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}
//并行队列异步执行任务
/*
 在并行队列异步执行任务结果:
 开启了多个新线程;
 任务交替执行,没有先后顺序;
 所有的任务都是在begin和end之后执行的,说明任务不是马上执行，而是将所有任务添加到队列之后才开始异步执行。
 
 打印:
 2018-02-09 13:28:43.260062+0800 圆角图片[3830:1385091] begin*************
 2018-02-09 13:28:43.260143+0800 圆角图片[3830:1385091] end***************
 2018-02-09 13:28:43.278500+0800 圆角图片[3830:1385304] 1 block <NSThread: 0x170267b40>{number = 6, name = (null)}
 2018-02-09 13:28:43.279348+0800 圆角图片[3830:1385304] 1 block <NSThread: 0x170267b40>{number = 6, name = (null)}
 2018-02-09 13:28:43.279545+0800 圆角图片[3830:1385304] 2 block <NSThread: 0x170267b40>{number = 6, name = (null)}
 2018-02-09 13:28:43.279586+0800 圆角图片[3830:1385316] 3 block <NSThread: 0x170269f00>{number = 7, name = (null)}
 2018-02-09 13:28:43.279676+0800 圆角图片[3830:1385304] 2 block <NSThread: 0x170267b40>{number = 6, name = (null)}
 2018-02-09 13:28:43.279760+0800 圆角图片[3830:1385316] 3 block <NSThread: 0x170269f00>{number = 7, name = (null)}
 */
-(void)asyncConcurrent{
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"begin *************");
    
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}
//串行队列同步执行任务
/*
 在串行队列同步执行任务结果:
 没有开启新线程,全部在主线程执行;
 任务按顺序执行,一个执行完才执行下一个;
 所有的任务都是在begin和end之间执行的,说明任务添加到队列中会被马上执行。
 
 打印:
 2018-02-09 13:34:21.842690+0800 圆角图片[3838:1386919] begin *************
 2018-02-09 13:34:21.842959+0800 圆角图片[3838:1386919] 1 block <NSThread: 0x1740738c0>{number = 1, name = main}
 2018-02-09 13:34:21.843136+0800 圆角图片[3838:1386919] 1 block <NSThread: 0x1740738c0>{number = 1, name = main}
 2018-02-09 13:34:21.843270+0800 圆角图片[3838:1386919] 2 block <NSThread: 0x1740738c0>{number = 1, name = main}
 2018-02-09 13:34:21.843667+0800 圆角图片[3838:1386919] 2 block <NSThread: 0x1740738c0>{number = 1, name = main}
 2018-02-09 13:34:21.844021+0800 圆角图片[3838:1386919] 3 block <NSThread: 0x1740738c0>{number = 1, name = main}
 2018-02-09 13:34:21.844201+0800 圆角图片[3838:1386919] 3 block <NSThread: 0x1740738c0>{number = 1, name = main}
 2018-02-09 13:34:21.844276+0800 圆角图片[3838:1386919] end ***************
 */
-(void)syncSerial{
    dispatch_queue_t SerialQueue = dispatch_queue_create("Serial", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"begin *************");
    
    dispatch_sync(SerialQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(SerialQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(SerialQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}

//串行队列异步执行任务
/*
 在串行队列异步执行任务结果:
 开启了一条新线程;
 任务按顺序执行,一个执行完才执行下一个,还是串行执行;
 所有的任务都是在begin和end之后执行的,说明是所有的任务都添加到队列之后才开始执行。
 
 打印:
 2018-02-09 13:37:58.990121+0800 圆角图片[3842:1387615] begin *************
 2018-02-09 13:37:58.990229+0800 圆角图片[3842:1387615] end ***************
 2018-02-09 13:37:58.990654+0800 圆角图片[3842:1387630] 1 block <NSThread: 0x17026b880>{number = 3, name = (null)}
 2018-02-09 13:37:58.991155+0800 圆角图片[3842:1387630] 1 block <NSThread: 0x17026b880>{number = 3, name = (null)}
 2018-02-09 13:37:58.991303+0800 圆角图片[3842:1387630] 2 block <NSThread: 0x17026b880>{number = 3, name = (null)}
 2018-02-09 13:37:58.991431+0800 圆角图片[3842:1387630] 2 block <NSThread: 0x17026b880>{number = 3, name = (null)}
 2018-02-09 13:37:58.991562+0800 圆角图片[3842:1387630] 3 block <NSThread: 0x17026b880>{number = 3, name = (null)}
 2018-02-09 13:37:58.991687+0800 圆角图片[3842:1387630] 3 block <NSThread: 0x17026b880>{number = 3, name = (null)}
 */
-(void)asyncSerial{
    dispatch_queue_t SerialQueue = dispatch_queue_create("Serial", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"begin *************");
    
    dispatch_async(SerialQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(SerialQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(SerialQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}

//在主队列中同步执行任务
/*
 在主队列中同步执行任务结果:
 只输出了一行begin ***************,然后程序就崩溃了;
 是因为在主队列中同步执行任务会造成死锁:
 在主队列中执行任务就是在主线程中执行任务,在主线程中执行同步任务时,所有任务被添加到队列时就会立即执行,但是同步任务还需要等到队列中其他任务执行完才可以开始下一个任务.
 在syncMain中,执行到第一个同步任务的时候,任务会立马执行,但是此时主线程正在执行syncMain这个方法,而且这个方法还没有执行完,那么就不能执行第一个同步任务,
 此时的情况就是syncMain等待方法中的第一个同步任务执行完才能往后进行,而第一个同步任务需要等到主线程中的syncMain方法执行完才能开始执行,
 所以就造成了,syncMain和第一个同步任务互相等待的情况,然后就会卡在这里过不去,这就是死锁.
 
 打印:
 2018-02-09 13:44:47.454903+0800 圆角图片[3844:1388616] begin *************
 (lldb)
 */
-(void)syncMain{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    NSLog(@"begin *************");
    
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}

//在主队列中异步执行任务
/*
 在主队列中异步执行任务结果:
 所有的任务都在主线程中执行,因为在主队列中,只能在主线程中执行;
 所有的任务在begin和end之后执行,说明任务是在全部加载到队列之后才开始执行的;
 所有的任务按照顺序执行,执行完一个再执行另一个
 
 打印:
 2018-02-09 13:58:15.020165+0800 圆角图片[3850:1391748] begin *************
 2018-02-09 13:58:15.020263+0800 圆角图片[3850:1391748] end ***************
 2018-02-09 13:58:15.046718+0800 圆角图片[3850:1391748] 1 block <NSThread: 0x1700708c0>{number = 1, name = main}
 2018-02-09 13:58:15.046989+0800 圆角图片[3850:1391748] 1 block <NSThread: 0x1700708c0>{number = 1, name = main}
 2018-02-09 13:58:15.047206+0800 圆角图片[3850:1391748] 2 block <NSThread: 0x1700708c0>{number = 1, name = main}
 2018-02-09 13:58:15.047338+0800 圆角图片[3850:1391748] 2 block <NSThread: 0x1700708c0>{number = 1, name = main}
 2018-02-09 13:58:15.047636+0800 圆角图片[3850:1391748] 3 block <NSThread: 0x1700708c0>{number = 1, name = main}
 2018-02-09 13:58:15.047768+0800 圆角图片[3850:1391748] 3 block <NSThread: 0x1700708c0>{number = 1, name = main}
 */
-(void)asyncMain{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    NSLog(@"begin *************");
    
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<2; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}

//GCD中的栅栏执行方法
/*
 可以看在在执行栅栏任务的时候,不能同时执行其他的异步任务;
 栅栏任务意思就像是在这个队列中有很多异步操作,他们可以同时进入队列,一起同时执行,但是有一个栅栏任务,当这个栅栏任务要执行的时候,他会等待队列中前边的操作执行完成,
 然后再队列的入口处放上一道栅栏让后面的任务不能再进入队列中执行任务,这时执行栅栏中的任务,在他执行的时候,是没有其他任务同时在执行的,然后等栅栏任务执行完毕会后,
 他在放开入口出的栅栏,让后边的异步操作可以开始进入队列开始执行.
 
 总结下来就是:栅栏任务执行的时候,不能有其他的任务通知执行.
 打印:
 2018-02-09 14:12:36.249555+0800 圆角图片[3856:1394576] begin *************
 2018-02-09 14:12:36.249762+0800 圆角图片[3856:1394576] end ***************
 2018-02-09 14:12:36.251755+0800 圆角图片[3856:1394596] 2 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.252046+0800 圆角图片[3856:1394598] 1 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.252183+0800 圆角图片[3856:1394598] 1 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.252505+0800 圆角图片[3856:1394598] 1 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.252643+0800 圆角图片[3856:1394598] 1 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.252767+0800 圆角图片[3856:1394598] 1 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.252957+0800 圆角图片[3856:1394596] 2 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253082+0800 圆角图片[3856:1394596] 2 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253223+0800 圆角图片[3856:1394596] 2 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253384+0800 圆角图片[3856:1394596] 2 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253542+0800 圆角图片[3856:1394596] barrier <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253665+0800 圆角图片[3856:1394596] barrier <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253788+0800 圆角图片[3856:1394596] barrier <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.253909+0800 圆角图片[3856:1394596] barrier <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.254031+0800 圆角图片[3856:1394596] barrier <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.254205+0800 圆角图片[3856:1394596] 3 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.254329+0800 圆角图片[3856:1394596] 3 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.254451+0800 圆角图片[3856:1394596] 3 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.259119+0800 圆角图片[3856:1394596] 3 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.259260+0800 圆角图片[3856:1394596] 3 block <NSThread: 0x174073600>{number = 4, name = (null)}
 2018-02-09 14:12:36.254576+0800 圆角图片[3856:1394598] 4 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.259466+0800 圆角图片[3856:1394598] 4 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.259591+0800 圆角图片[3856:1394598] 4 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.259713+0800 圆角图片[3856:1394598] 4 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 2018-02-09 14:12:36.259836+0800 圆角图片[3856:1394598] 4 block <NSThread: 0x17007d540>{number = 3, name = (null)}
 */
-(void)barrier{
    dispatch_queue_t queue = dispatch_queue_create("barrier", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"begin *************");
    
    dispatch_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"1 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"2 block %@",[NSThread currentThread]);
        }
    });
    dispatch_barrier_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"barrier %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"3 block %@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"4 block %@",[NSThread currentThread]);
        }
    });
    NSLog(@"end ***************");
}

//延迟执行方法,block内的任务会在规定的2秒之后开始执行,
- (void)dispatchAfrer{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"这是2秒之后执行的方法");
    });
}

//dispatch group
/*
 group的作用是,把多个操作放入到同一个group中,然后等待group中的任务全部执行完成之后,再执行特定的任务
 dispatch_group_enter 的意思是向group内添加一个任务;
 dispatch_group_leave 的意思是group中的一个任务执行完毕了;
 当group中的任务全部执行完毕之后,会通知dispatch_group_notify方法,执行之后的block内的任务;
 
 */
- (void)group{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"1 耗时操作");
            dispatch_group_leave(group);
        });
    });
    dispatch_group_enter(group);

    dispatch_group_async(group, queue, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2 耗时操作");
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部耗时操作执行完毕");
    });
}
@end
