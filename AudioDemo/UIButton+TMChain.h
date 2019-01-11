//
//  UIButton+TMChain.h
//  链式编程
//
//  Created by TianMeng on 2018/11/30.
//  Copyright © 2018年 TianMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TMChain)
//UIButton常用属性 使用链式编程点出来
- (UIButton*(^)(NSString*))TM_TitleNormal;
- (UIButton*(^)(NSString*))TM_TitleHighlighted;
- (UIButton*(^)(NSString*))TM_TitleDisabled;
- (UIButton*(^)(NSString*))TM_TitleSelected;
- (UIButton*(^)(UIImage*))TM_ImageNormal;
- (UIButton*(^)(UIImage*))TM_bgImageNormal;
- (UIButton*(^)(UIImage*))TM_bgImageHighlighted;
- (UIButton*(^)(UIImage*))TM_bgImageSelected;
- (UIButton*(^)(UIImage*))TM_bgImageDisabled;
- (UIButton*(^)(UIColor*))TM_bgColor;
- (UIButton*(^)(UIFont*))TM_font;
- (UIButton*(^)(UIView*))TM_addSupView;
- (UIButton*(^)(UIColor*))TM_TitleColorNormal;
- (UIButton*(^)(UIColor*))TM_TitleColorHighlighted;
- (UIButton*(^)(UIColor*))TM_TitleColorDisabled;
- (UIButton*(^)(UIColor*))TM_TitleColorSelected;
- (UIButton*(^)(CGFloat))TM_cornerRadius;
- (UIButton*(^)(CGFloat))TM_borderWidth;
- (UIButton*(^)(UIColor*))TM_borderColor;
//让uibutton上下展示图片和文字
- (void)verticalImageAndTitle:(CGFloat)spacing;
@end
