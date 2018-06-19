//
//  UIColor+MyColor.m
//  ttdoctor
//
//  Created by zichenfang on 16/3/15.
//  Copyright © 2016年 zichenfang. All rights reserved.
//

#import "UIColor+MyColor.h"

@implementation UIColor (MyColor)


//#FFFFFF格式的颜色转换为UIColor
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


+ (UIColor *)styleRedColor
{
    return [UIColor colorWithHexString:@"#F36676"];
}


+ (UIColor *)styleBlackColor{
    return [UIColor colorWithHexString:@"#323845"];
}
+ (UIColor *)styleLightBlueColor{
    return [UIColor colorWithHexString:@"#00C7FE"];
}
+ (UIColor *)styleLightGreenColor{
    return [UIColor colorWithHexString:@"#00B991"];
}
+ (UIColor *)styleOrangeGreenColor{
    return [UIColor colorWithHexString:@"#FF9300"];
}
@end
