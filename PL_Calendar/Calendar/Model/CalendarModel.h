//
//  CalendarModel.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarModel : NSObject

@property (nonatomic, copy) NSString *sign1;

@property (nonatomic, copy) NSString *sign2;

@property (nonatomic, copy) NSString *sign3;

+ (instancetype)loadWithDict:(NSDictionary *)dict;
- (instancetype)initWithDataSource:(NSDictionary *)dict;

@end
