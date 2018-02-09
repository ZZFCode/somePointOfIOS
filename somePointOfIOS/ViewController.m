//
//  ViewController.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/1/11.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "ViewController.h"
#import "MethodSwizzViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)load{
    NSLog(@"加载了");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"圆角图片";
    UIImageView *iamgev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    iamgev.center = self.view.center;
    
    iamgev.image = [self drawImageWithSize:CGSizeMake(600, 600) imageName:@"color"];
    
    [self.view addSubview:iamgev];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(UIImage *)drawImageWithSize:(CGSize)size imageName:(NSString *)imageName{
    //申请一块特定大小的画布
    UIGraphicsBeginImageContext(size);
    //画出一个与画布等大的圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    //将这个圆之外的部分设置为无效区域
    [path addClip];
    
    UIImage *oldImage = [UIImage imageNamed:imageName];
    [oldImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
