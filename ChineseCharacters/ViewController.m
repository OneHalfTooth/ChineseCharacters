//
//  ViewController.m
//  ChineseCharacters
//
//  Created by 马少洋 on 16/4/6.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "ViewController.h"
#import "JKChineseCharactersSort.h"
#import "JKTopLocationModel.h"

@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ////按照首字母分类并排序，但是分类未排序
    
    JKChineseCharactersSort * manager = [JKChineseCharactersSort manager];
    NSDictionary * dic = [manager sortingAnArrayResultsReceivtArray: @[@{
                                                                           @"_id": @"56c45924c2fb4e205df000000e",
                                                                           @"city": @"托里县"
                                                                           },
                                                                       @{
                                                                          @"_id": @"56c45924c2fb4e20q25000000f",
                                                                           @"city": @"邯郸市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4e232050000010",
                                                                           @"city": @"长春市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4ve2050000011",
                                                                           @"city": @"苏州市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fbz4e2050000012",
                                                                           @"city": @"南通市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2xcfb4e2050000013",
                                                                           @"city": @"杭州市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4e2050000014sdf",
                                                                           @"city": @"嘉兴市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4e20500000gfd15",
                                                                           @"city": @"合肥市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4e20500zcxv00016",
                                                                           @"city": @"芜湖市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4e20asdf50000017",
                                                                           @"city": @"蚌埠市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fb4eadf2050000018",
                                                                           @"city": @"淮南市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2fbads4e2050000019",
                                                                           @"city": @"安庆市"
                                                                           },
                                                                       @{
                                                                           @"_id": @"56c45924c2wefb4e205000001a",
                                                                           @"city": @"黄山市"
                                                                           }]];
    NSArray * array = [dic allKeys];
    for (NSString * str in array) {
        NSLog(@"---------------------------------------------------------");
        NSLog(@"key === %@",str);
        NSArray * temp = [dic objectForKey:str];
        for (JKTopLocationModel * model in temp) {
            NSLog(@"%@--%@---%@---%@",model.Cid,model.city,model.alphabetic,model.firstChar);
        }
        NSLog(@"---------------------------------------------------------");
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
