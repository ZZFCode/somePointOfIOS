//
//  MainTableViewController.m
//  圆角图片
//
//  Created by AVIC_IOS_ZZF on 2018/1/17.
//  Copyright © 2018年 AVIC_IOS_ZZF. All rights reserved.
//

#import "MainTableViewController.h"
#import "ViewController.h"
#import "CopyViewController.h"
#import "MethodSwizzViewController.h"
#import "NSString+EOCADditions.h"
#import "SerialSynchronizationQueueVC.h"
#import "GCDVC.h"
@interface MainTableViewController ()
{
    NSMutableArray *array;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZZF";
    array = [[NSMutableArray alloc]initWithArray:@[
                                                   @{@"index":@1,
                                                     @"title":@"圆角图片",
                                                     @"class":@"ViewController"
                                                     },
                                                   @{@"index":@2,
                                                     @"title":@"copy关键字",
                                                     @"class":@"CopyViewController"
                                                     },
                                                   @{@"index":@3,
                                                     @"title":@"方法交换",
                                                     @"class":@"MethodSwizzViewController"
                                                     },
                                                   @{@"index":@4,
                                                     @"title":@"GCD实现同步锁",
                                                     @"class":@"SerialSynchronizationQueueVC"
                                                     },
                                                   @{@"index":@5,
                                                     @"title":@"GCD多线程",
                                                     @"class":@"GCDVC"
                                                     },
                                                   ]];
  
    
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = ((NSDictionary *)array[indexPath.row])[@"title"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            ViewController *vc = [[ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            UIViewController *copyVc = [[CopyViewController alloc]init];
            [self.navigationController pushViewController:copyVc animated:YES];
        }
            break;
        case 2:
        {
            MethodSwizzViewController *MethodSwizzVc = [[MethodSwizzViewController alloc]init];
            [self.navigationController pushViewController:MethodSwizzVc animated:YES];
        }
            break;
        case 3:
        {
            SerialSynchronizationQueueVC *serialSyncVc = [[SerialSynchronizationQueueVC alloc]init];
            [self.navigationController pushViewController:serialSyncVc animated:YES];
        }
            break;
        case 4:
        {
            GCDVC *GCDVc = [[GCDVC alloc]init];
            [self.navigationController pushViewController:GCDVc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
