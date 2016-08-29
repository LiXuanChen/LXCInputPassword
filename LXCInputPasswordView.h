//
//  LXCInputPasswordView.h
//  MW2.0
//
//  Created by 工人师傅 on 16/8/24.
//  Copyright © 2016年 com.grsf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LXCInputPasswordView;
@protocol LXCInputPasswordViewDelegate <NSObject>

-(void)inputPasswordViewDelegate:(LXCInputPasswordView *)inputPasswordView inputEndWithPassword:(NSString *)inputEndWithPassword;

@end


@interface LXCInputPasswordView : UIView

@property (nonatomic,weak)  id<LXCInputPasswordViewDelegate> delegate ;

+(instancetype)inputPasswordView;

+(instancetype)inputPasswordViewWithY:(CGFloat)viewY;

@end
