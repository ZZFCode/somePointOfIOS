
//
//  ZZFRuntimeA.m
//  somePointOfIOS
//
//  Created by AVIC_IOS_ZZF on 2018/3/7.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
// 通过runtime修改系统私有属性

#import "ZZFRuntimeA.h"
#import <objc/runtime.h>

@interface ZZFRuntimeA ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl *pageControl;
@end

void dynamicMethodIMP(id self,SEL _cmd){
    NSLog(@" >> dynamicMethodIMP");
}

@implementation ZZFRuntimeA

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self load];
    [self setUpUI];
    [self hahaha];
}
//使用runtime获取UIPageControl的所有属性
-(void)load{
    unsigned int count = 0;
    Ivar *property = class_copyIvarList([UIPageControl class], &count);
    for (int i = 0; i<count; i++) {
        const char * propertyName = ivar_getName(property[i]);
        NSLog(@"UIPageControl的属性%@",[NSString stringWithUTF8String: propertyName]);
    }
}

-(void)setUpUI{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,ScreenWidth , ScreenHeight)];
    scrollView.contentSize = CGSizeMake(ScreenWidth*3, ScreenHeight-64);
    scrollView.scrollEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    for (NSInteger i = 1; i<4; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((i-1)*ScreenWidth, 0, ScreenWidth, ScreenHeight-64)];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imagename = [NSString stringWithFormat:@"%ld",(long)i];
        imageV.image = [UIImage imageNamed:imagename];
        [scrollView addSubview:imageV];
    }
    [self.view addSubview:scrollView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenHeight-32, ScreenWidth, 32)];
    
    //使用kvc替换uipagecontrol的内部属性
    [self.pageControl setValue:[UIImage imageNamed:@"scene_chb"] forKeyPath:@"_pageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"scene_chb_pre"] forKeyPath:@"_currentPageImage"];
    self.pageControl.numberOfPages = 3;
    [self.view addSubview:self.pageControl];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger pageNumber = (scrollView.contentOffset.x+ScreenWidth/2)/ScreenWidth;
    NSLog(@"%ld",(long)pageNumber);
    self.pageControl.currentPage = pageNumber;
}


+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@" >> Instance resolving %@",NSStringFromSelector(sel));
    if (sel == @selector(hahaha)) {
        
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
