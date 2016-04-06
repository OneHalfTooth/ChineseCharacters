//
//  JKChineseCharactersSort.h
//  享了么
//
//  Created by 马少洋 on 15/12/14.
//  Copyright © 2015年 马少洋 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#import "JKTopLocationModel.h"



@interface JKChineseCharactersSort : NSObject
///马少洋实现通讯录功能
@property (nonatomic,strong)NSArray * tempArray;//用来储存每组数据临时
@property (nonatomic,strong)NSDictionary * tempDic;//用来临时存储字典数据;


+(JKChineseCharactersSort *)manager;

- (NSDictionary *)sortingAnArrayResultsReceivtArray:(NSArray *)receive;

@end
