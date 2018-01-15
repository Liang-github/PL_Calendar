//
//  CalendarModel.m
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import "CalendarModel.h"

@implementation CalendarModel

+ (instancetype)loadWithDict:(NSDictionary *)dict {
    return [[CalendarModel alloc] initWithDataSource:dict];
}
- (instancetype)initWithDataSource:(NSDictionary *)dict {
    if (self = [super init]) {
        self.sign1 = dict[@"sign1"];
        self.sign2 = dict[@"sign2"];
        self.sign3 = dict[@"sign3"];
    }
    return self;
}
@end
