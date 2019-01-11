//
//  NSString+TMKit.m
//  doctor
//
//  Created by TianMeng on 2018/12/4.
//  Copyright © 2018年 TianMeng. All rights reserved.
//

#import "NSString+TMKit.h"
#define TMKit_FormatString_YMDHMS    @"yyyy-MM-dd HH:mm:ss"
#define TMKit_FormatString_YMD       @"yyyy-MM-dd"
#define TMKit_FormatString_HM        @"HH:mm"

@implementation NSString (TMKit)
+ (CGSize)TM_AutoSizeOfHeghtWithFont:(UIFont *)font width:(CGFloat)width {
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [[self new] boundingRectWithSize:size
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

+ (CGSize)TM_AutoSizeOfWidthWithFont:(UIFont *)font height:(CGFloat)height {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font, NSParagraphStyleAttributeName : style };
    
    CGRect rect = [[self new]  boundingRectWithSize:size
                                     options:opts
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

#pragma mark - 获得系统当前日期和时间

/**
 *  获取系统当前日期和时间【YYYY-MM-dd HH:mm:ss】
 *
 *  @return 系统当前日期和时间
 */
+ (NSString *)TM_time_getSystermCurrentDateYMDHMS
{
    NSString *resultString = [NSString  TM_time_getSystermCurrentDateWithFormatString:TMKit_FormatString_YMDHMS];
    return resultString;
}

/**
 获取系统当前日期和时间 【自定义 formatString】
 
 @param formatString formatString
 @return 系统当前日期和时间
 */
+ (NSString *)TM_time_getSystermCurrentDateWithFormatString:(NSString *)formatString
{
    //获得系统日期
    NSDate *senddate = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:formatString];
    NSString *resultString = [dateformatter stringFromDate:senddate];
    
    return resultString;
}

#pragma mark - 时间戳转换时间
#pragma mark 时间戳转换时间【YYYY-MM-dd HH:mm:ss】
/**
 *  时间戳转换时间【YYYY-MM-dd HH:mm:ss】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd HH:mm:ss】
 */
+ (NSString *)TM_time_getDateWithTimeStampYMDHMS:(NSString *)timeStamp
{
    return [NSString TM_time_getDateWithTimeStamp:timeStamp formatString:TMKit_FormatString_YMDHMS];
}

#pragma mark 时间戳转换【YYYY-MM-dd】
/**
 *  时间戳转换时间【YYYY-MM-dd】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【YYYY-MM-dd】
 */
+ (NSString *)TM_time_getDateWithTimeStampYMD:(NSString *)timeStamp
{
    return [NSString TM_time_getDateWithTimeStamp:timeStamp formatString:TMKit_FormatString_YMD];
}

#pragma mark 时间戳转换【HH:mm】
/**
 *  时间戳转换时间【HH:mm】
 *
 *  @param timeStamp 时间戳
 *
 *  @return 时间戳转换【HH:mm】
 */
+ (NSString *)TM_time_getDateWithTimeStampHM:(NSString *)timeStamp
{
    return [NSString TM_time_getDateWithTimeStamp:timeStamp formatString:TMKit_FormatString_HM];
}

/**
 时间戳转换时间【自定义 formatString】
 
 @param timeStamp 时间戳
 @param formatString formatString
 @return 时间
 */
+ (NSString *)TM_time_getDateWithTimeStamp:(NSString *)timeStamp
                              formatString:(NSString *)formatString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatString];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    // 时间戳转换
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp intValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

#pragma mark - 当前时间转换成时间戳
/**
 *  当前时间【YYYY-MM-dd HH:mm:ss】转换成时间戳【10位数，如：1492672164】
 *
 *  @return 时间戳【10位数，如：1492672164】
 */
+ (NSString *)TM_time_getCurrentDateTransformTimeStampYMDHMS
{
    NSDate *datenow = [NSDate date];
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}


/*!
 * 去除空格
 *
 * @return 去除空格后的字符串
 */
- (NSString *)TM_trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/*!
 * 去除字符串与空行
 *
 * @return 去除字符串与空行的字符串
 */
- (NSString *)TM_trimWhitespaceAndNewlines
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
@end
