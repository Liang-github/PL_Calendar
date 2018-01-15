//
//  PLColor.h
//  PL_Calendar
//
//  Created by PengLiang on 2018/1/12.
//  Copyright © 2018年 PengLiang. All rights reserved.
//

#ifndef PLColor_h
#define PLColor_h

#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#pragma mark - 获取图片路径
#define IMAGEPATH(name)         [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]
#define CONTENTFILEIMAGE(name)  [UIImage imageWithContentsOfFile:IMAGEPATH(name)]

#endif /* PLColor_h */
