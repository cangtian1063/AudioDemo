//
//  UIButton+TMChain.m
//  链式编程
//
//  Created by TianMeng on 2018/11/30.
//  Copyright © 2018年 TianMeng. All rights reserved.
//

#import "UIButton+TMChain.h"

@implementation UIButton (TMChain)
- (UIButton*(^)(NSString*))TM_TitleNormal {
    UIButton*(^block)(NSString*) = ^(NSString* title){
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(NSString*))TM_TitleHighlighted {
    UIButton*(^block)(NSString*) = ^(NSString* title){
        [self setTitle:title forState:UIControlStateHighlighted];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(NSString*))TM_TitleDisabled {
    UIButton*(^block)(NSString*) = ^(NSString* title){
        [self setTitle:title forState:UIControlStateDisabled];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(NSString*))TM_TitleSelected {
    UIButton*(^block)(NSString*) = ^(NSString* title){
        [self setTitle:title forState:UIControlStateSelected];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIImage*))TM_ImageNormal {
    UIButton*(^block)(UIImage*) = ^(UIImage* image){
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIImage*))TM_bgImageNormal {
    UIButton*(^block)(UIImage*) = ^(UIImage* image){
        [self setBackgroundImage:image forState:UIControlStateNormal];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIImage*))TM_bgImageHighlighted{
    UIButton*(^block)(UIImage*) = ^(UIImage* image){
        [self setBackgroundImage:image forState:UIControlStateHighlighted];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIImage*))TM_bgImageSelected{
    UIButton*(^block)(UIImage*) = ^(UIImage* image){
        [self setBackgroundImage:image forState:UIControlStateSelected];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIImage*))TM_bgImageDisabled{
    UIButton*(^block)(UIImage*) = ^(UIImage* image){
        [self setBackgroundImage:image forState:UIControlStateDisabled];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIColor*))TM_bgColor{
    UIButton*(^block)(UIColor*) = ^(UIColor* color){
        [self setBackgroundColor:color];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIFont*))TM_font{
    UIButton*(^block)(UIFont*) = ^(UIFont* font){
        [self.titleLabel setFont:font];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIView*))TM_addSupView{
    UIButton*(^block)(UIView*) = ^(UIView* supView){
        [supView addSubview:self];
        return self;
        
    };
    return [block copy];
}

- (UIButton*(^)(UIColor*))TM_TitleColorNormal {
    UIButton*(^block)(UIColor*) = ^(UIColor* color){
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIColor*))TM_TitleColorHighlighted {
    UIButton*(^block)(UIColor*) = ^(UIColor* color){
        [self setTitleColor:color forState:UIControlStateHighlighted];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIColor*))TM_TitleColorDisabled {
    UIButton*(^block)(UIColor*) = ^(UIColor* color){
        [self setTitleColor:color forState:UIControlStateDisabled];
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIColor*))TM_TitleColorSelected {
    UIButton*(^block)(UIColor*) = ^(UIColor* color){
        [self setTitleColor:color forState:UIControlStateSelected];
        return self;
    };
    return [block copy];
}

//设置圆角
- (UIButton*(^)(CGFloat))TM_cornerRadius {
    UIButton*(^block)(CGFloat) = ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(CGFloat))TM_borderWidth {
    UIButton*(^block)(CGFloat) = ^(CGFloat borderWidth){
        self.layer.borderWidth = borderWidth;
        return self;
    };
    return [block copy];
}

- (UIButton*(^)(UIColor*))TM_borderColor {
    UIButton*(^block)(UIColor*) = ^(UIColor* borderColor){
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
    return [block copy];
}

//让uibutton上下展示图片和文字
- (void)verticalImageAndTitle:(CGFloat)spacing
{
    self.titleLabel.numberOfLines = 0;
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    //CGSize textSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font];
    
    CGSize textSize = [self.titleLabel.text sizeWithAttributes: @{NSFontAttributeName: self.titleLabel.font}];
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}
@end
