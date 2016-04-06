//
//  JKChineseCharactersSort.m
//  享了么
//
//  Created by 马少洋 on 15/12/14.
//  Copyright © 2015年 马少洋 All rights reserved.
//

#import "JKChineseCharactersSort.h"


static JKChineseCharactersSort * manager = nil;
@implementation JKChineseCharactersSort

+(JKChineseCharactersSort *)manager{
    @synchronized(self) {
        if (!manager) {
            manager = [[self alloc]init];
        }
        return manager;
    }
}

-(NSDictionary *)sortingAnArrayResultsReceivtArray:(NSArray *)receive{
    
    NSArray * temp = [self dataIsErrorAndNoError:receive];
    
//    已经转化model形式，并且已经转换过拼音
    NSArray * modelArray = [self traversalChinaArray:temp];
    ///将数据分组
    NSMutableDictionary * dataSource = [self byCharactersInTheCollatingData:modelArray];
    
    return (NSDictionary *)dataSource;
}
///参数合法性判断
- (NSArray *)dataIsErrorAndNoError:(NSArray *)receive{
    NSMutableArray * temp = [[NSMutableArray alloc]initWithArray:receive];
    for (NSDictionary * obj in receive) {
            NSLog(@"%@",[[obj objectForKey:@"city"]class]);
        if ([[obj objectForKey:@"city"] isKindOfClass:[NSNull class]]) {
            [temp removeObject: obj];
        }
    }
    return (NSArray *)temp;
}

///通过字符整理数据 分区
- (NSMutableDictionary *)byCharactersInTheCollatingData:(NSArray *)array{
    
    BOOL flag = YES;
    NSMutableDictionary * dataSource = [[NSMutableDictionary alloc]init];
    for (JKTopLocationModel * model in array) {
        flag = YES;
        NSArray * temp = [dataSource allKeys];
        
        for (NSString * obj in temp) {
            if ([obj isEqualToString:model.firstChar]) {
                NSMutableArray * modelArray = [dataSource objectForKey:obj];
                [modelArray addObject:model];
                flag = NO;
                break;
            }
        }
        if (flag) {
            NSMutableArray * modelArray = [[NSMutableArray alloc]init];
            [modelArray addObject:model];
            [dataSource setObject:modelArray forKey:model.firstChar];
        }
    }
    return dataSource;
}

///遍历汉字数组
- (NSArray *)traversalChinaArray:(NSArray *)receive{
    
    NSMutableArray * temp = [[NSMutableArray alloc]init];
    
    for (NSDictionary * obj in receive) {
        NSString * str = [obj objectForKey:@"city"];
        if (str.length != 0) {
            JKTopLocationModel * model = [[JKTopLocationModel alloc]init];
            model.city = [obj objectForKey:@"city"];
            model.Cid = [obj objectForKey:@"_id"];
            //        获取到汉字的拼音
            model.alphabetic = [self willBeConvertedIntoPhoneticCharacters:model.city];
            //        通过拼音获取首字母进行分类
            model.firstChar = [self BeingTheFirstLetterByAlphabet:model.alphabetic];
            //        NSLog(@"%@",model.alphabetic);
            //        添加到字典
            [temp addObject:model];

        }
    }
    
    return [self sortingByAlphabet:(NSArray *)temp];
}
///通过拼音获取首字母
- (NSString *)BeingTheFirstLetterByAlphabet:(NSString *)str{
    if (str) {
        char firstChar = [str characterAtIndex:0];
        NSString * firstStr = [NSString stringWithFormat:@"%c",firstChar];
        firstStr = [firstStr uppercaseString];
        return firstStr;
    }
    return nil;
}

///将汉字转化成拼音
- (NSString *)willBeConvertedIntoPhoneticCharacters:(NSString *)chinaString{
    
    CFStringRef chinaStr = (__bridge CFStringRef)chinaString;
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, chinaStr);
//    转化成拼音
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
///去掉声调
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
//打印下字符串
//    NSLog(@"%@", string);
//    去掉空格
    NSString * res =  (__bridge NSString *)string;
    NSArray * temp = [res componentsSeparatedByString:@" "];
    res = [temp componentsJoinedByString:@""];
    return res;
}


- (NSArray *)sortingByAlphabet:(NSArray *)receive{
//    取得所有的拼音
    NSMutableArray * alArray = [[NSMutableArray alloc]init];
    for (JKTopLocationModel * model in receive) {
        [alArray addObject:model.alphabetic];
    }
    NSMutableArray * tempReceive = [[NSMutableArray alloc]initWithArray:receive];
//    NSLog(@"%ld ---- %ld",tempReceive.count,alArray.count);
        for (int j = 0; j < alArray.count - 1; j++){
            for (int i = 0; i <= alArray.count - 2; i++){
                if ([self compareTheSizeOfTheString:[alArray objectAtIndex:i] AndStr:[alArray objectAtIndex:i + 1]]) {
                    NSString * tempStr = [alArray objectAtIndex:i + 1];
                    alArray[i + 1] = [alArray objectAtIndex:i];
                    alArray[i] = tempStr;
                    
                    JKTopLocationModel * modelTemp = [tempReceive objectAtIndex:i + 1];
                    tempReceive[i + 1] = [tempReceive objectAtIndex:i];
                    tempReceive[i] = modelTemp;
                    
                }
            }
        }
    
    return (NSArray *)tempReceive;
}

- (BOOL)compareTheSizeOfTheString:(NSString *)str1 AndStr:(NSString *)str2{
    int strLength = 0;
    if (str1.length < str2.length) {
        strLength = (int)str1.length;
    }else{
        strLength = (int)str2.length;
    }
    for (int i = 0; i < strLength; i ++) {
        char CStr1 = [str1 characterAtIndex:i];
        char CStr2 = [str2 characterAtIndex:i];
        if (CStr1 > CStr2) {
            return YES;
        }else if(CStr1 < CStr2){
            return NO;
        }
    }
    if (strLength == str1.length) {
        return YES;
    }
    return NO;
}
@end
