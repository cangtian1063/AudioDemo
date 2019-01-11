//
//  NSString+TMKit.h
//  doctor
//
//  Created by TianMeng on 2018/12/4.
//  Copyright © 2018年 TianMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (TMKit)
/*!
 *  自适应label的高度
 *
 *  @param font  字体大小
 *  @param width 宽度
 *
 *  @return label的高度
 */
+ (CGSize)TM_AutoSizeOfHeghtWithFont:(UIFont *)font width:(CGFloat)width;

/*!
 *  自适应label的宽度
 *
 *  @param font  字体大小
 *  @param height 高度
 *
 *  @return label的宽度
 */
+ (CGSize)TM_AutoSizeOfWidthWithFont:(UIFont *)font height:(CGFloat)height;



#pragma mark - 获取系统当前日期和时间
/**
 *  获取系统当前日期和时间【YYYY-MM-dd HH:mm:ss】
 *
 *  @return 系统当前日期和时间
 */
+ (NSString *)TM_time_getSystermCurrentDateYMDHMS;

/**
 获取系统当前日期和时间 【自定义 formatString】
 
 @param formatString formatString
 @return 系统当前日期和时间
 */
+ (NSString *)TM_time_getSystermCurrentDateWithFormatString:(NSString *)formatString;

#pragma mark - 时间戳转换时间
#pragma mark 时间戳转换时间【YYYY-MM-dd HH:mm:ss】
/**
 *  时间戳转换时间【YYYY-MM-dd HH:mm:ss】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd HH:mm:ss】
 */
+ (NSString *)TM_time_getDateWithTimeStampYMDHMS:(NSString *)timeStamp;

#pragma mark 时间戳转换【YYYY-MM-dd】
/**
 *  时间戳转换时间【YYYY-MM-dd】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd】
 */
+ (NSString *)TM_time_getDateWithTimeStampYMD:(NSString *)timeStamp;

#pragma mark 时间戳转换【HH:mm】
/**
 *  时间戳转换时间【HH:mm】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【HH:mm】
 */
+ (NSString *)TM_time_getDateWithTimeStampHM:(NSString *)timeStamp;

/**
 时间戳转换时间【自定义 formatString】
 
 @param timeStamp 时间戳
 @param formatString formatString
 @return 时间
 */
+ (NSString *)TM_time_getDateWithTimeStamp:(NSString *)timeStamp
                              formatString:(NSString *)formatString;

#pragma mark - 当前时间转换成时间戳
/**
 *  当前时间【YYYY-MM-dd HH:mm:ss】转换成时间戳【10位数，如：1492672164】
 *
 *  @return 时间戳【10位数，如：1492672164】
 */
+ (NSString *)TM_time_getCurrentDateTransformTimeStampYMDHMS;

#pragma mark -- 去除字符串中的空格  和  空行
/*!
 * 去除空格
 *
 * @return 去除空格后的字符串
 */
- (NSString *)TM_trimWhitespace;

/*!
 * 去除字符串与空行
 *
 * @return 去除字符串与空行的字符串
 */
- (NSString *)TM_trimWhitespaceAndNewlines;
@end
