//
//  LXCInputPasswordView.m
//  MW2.0
//
//  Created by 工人师傅 on 16/8/24.
//  Copyright © 2016年 com.grsf. All rights reserved.
//

#import "LXCInputPasswordView.h"

/**
 设计依据4.7做图。
 */
#define PixelHeight_iPhone4_7 ([UIScreen mainScreen].bounds.size.height/667)
/**
 设计依据4.7做图。
 */
#define PixelWidth_iPhone4_7 ([UIScreen mainScreen].bounds.size.width/375)
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define ViewTag 1000
#define ViewHeight 55
#define ViewWidth 330

@interface LXCInputPasswordView()
@property (nonatomic,weak)  UIImageView *secretImageView;
@end
@implementation LXCInputPasswordView

+(instancetype)inputPasswordView
{
    return [[self alloc]initWithFrame:CGRectMake(0, 95, SCREEN_WIDTH, ViewHeight*PixelHeight_iPhone4_7)];
}

+(instancetype)inputPasswordViewWithY:(CGFloat)viewY
{
    return [[self alloc]initWithFrame:CGRectMake(0, viewY, SCREEN_WIDTH, ViewHeight*PixelHeight_iPhone4_7)];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //密码输入
        UITextField *secretTextfield = [[UITextField alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - ViewWidth * PixelWidth_iPhone4_7) / 2, 0, ViewWidth * PixelWidth_iPhone4_7, ViewHeight * PixelHeight_iPhone4_7)];
        secretTextfield.keyboardType = UIKeyboardTypeNumberPad;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:secretTextfield];
        [self addSubview:secretTextfield];
        
        UIImageView *secretImageView = [[UIImageView alloc]initWithFrame:secretTextfield.frame];
        secretImageView.image = [UIImage imageNamed:@"SettingSecret_mimakuang"];
        self.secretImageView = secretImageView;
        
        [self addSubview:secretImageView];
        
        CGFloat secretPointImgHeight = 15;
        CGFloat secretPointImgWidth = secretPointImgHeight;
        CGFloat secretPointImgLeft = 20;
        for (int i = 0; i < 6; i++) {
            
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((secretPointImgLeft + i * ViewHeight) * PixelWidth_iPhone4_7 , (ViewHeight * PixelHeight_iPhone4_7 - secretPointImgHeight * PixelWidth_iPhone4_7) / 2, secretPointImgWidth * PixelWidth_iPhone4_7, secretPointImgHeight * PixelWidth_iPhone4_7)];
            img.image = [UIImage imageNamed:@"SettingSecret_mima"];
            img.hidden = YES;
            img.tag = ViewTag + i;
            
            [secretImageView addSubview:img];
            
        }
        
    }
    
    return self;
}

- (void)textFieldDidChange:(NSNotification *)obj
{
    UITextField * textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    
    for (int i = 0; i< self.secretImageView.subviews.count; i++) {
        UIImageView *img = (UIImageView *)self.secretImageView.subviews[i];
        if (img.tag <= textField.text.length + 999) {
            img.hidden = NO;
        }
        else
        {
            img.hidden = YES;
        }
    }
    
    
    if (toBeString.length >= 6) {
        textField.text = [toBeString substringToIndex:6];
        
    }
    if (textField.text.length == 6) {
        
        
        [textField resignFirstResponder];
    
        if ([self.delegate respondsToSelector:@selector(inputPasswordViewDelegate:inputEndWithPassword:)]) {
            
            [self.delegate inputPasswordViewDelegate:self inputEndWithPassword:textField.text];
            
        }
        
        
    }
    
}

@end
