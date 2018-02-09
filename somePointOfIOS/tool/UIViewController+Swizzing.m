//
//  UIViewController+Swizzing.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/2/5.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//
/*
 这个扩展使用方法交换,让UIViewController每次加载的时候都会加载自定义的viewDidLoad方法,来实现,每次进入页面统计一次次数的功能
 */
#import "UIViewController+Swizzing.h"
#import <objc/runtime.h>

@implementation UIViewController (Swizzing)

//在load方法中交换了UIViewController的viewDidLoad的方法使用了自定义的swizzlingViewDidLoad方法来实现
+(void)load{
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzlingViewDidLoad));
    if (!class_addMethod([self class], @selector(swizzlingViewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
- (void)swizzlingViewDidLoad {
    NSString *str = [NSString stringWithFormat:@"%@", self.class];
    // 我们在这里加一个判断，将系统的UIViewController的对象剔除掉
    if(![str containsString:@"UI"]){
        NSLog(@"统计打点 : %@", self.class);
    }
    [self swizzlingViewDidLoad];
}

@end
