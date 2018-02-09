//
//  NSString+EOCADditions.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/2/5.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "NSString+EOCADditions.h"

@implementation NSString (EOCADditions)

//当调用NSString的LowercaseString方法时,回调用这个方法
- (NSString *)eoc_myLowercaseString{
    NSString *lowerString = [self eoc_myLowercaseString];
    NSLog(@"%@ =》 %@",self,lowerString);
    return lowerString;
}
@end

