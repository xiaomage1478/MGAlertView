//
//  MGAlertView.m
//  BHAFApp
//
//  Created by 马祥忠 on 2017/8/14.
//  Copyright © 2017年 小马哥. All rights reserved.
//

#import "MGAlertView.h"
#import <Masonry.h>


#define RGB_HEX(hexColor) [UIColor colorWithRed:(((hexColor >> 16) & 0xFF))/255.0f         \
green:(((hexColor >> 8) & 0xFF))/255.0f          \
blue:((hexColor & 0xFF))/255.0f                 \
alpha:1]

@interface MGAlertView ()

/** 取消按钮 */
@property (nonatomic, strong) UIButton *cancleButton;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *confirmButton;

/** backView */
@property (nonatomic, strong) UIView *backView;

@end
@implementation MGAlertView
#pragma mark ------------------lazy load---------------------
-(UIButton *)cancleButton{
    if (nil == _cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancleButton.backgroundColor = [UIColor whiteColor];
        _cancleButton.layer.borderColor = RGB_HEX(0xD4D4D4).CGColor;
        _cancleButton.layer.borderWidth = 0.5;
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = 2;
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton setBackgroundImage:[UIImage imageNamed:@"buttonDown"] forState:UIControlStateHighlighted];
        [_cancleButton setTitleColor:RGB_HEX(0x666666) forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancleClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}
- (UIButton *)confirmButton{
    if (nil == _confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = 2;
        _confirmButton.backgroundColor = [UIColor blueColor];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"buttonDown"] forState:UIControlStateHighlighted];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
-(UILabel *)titleLabel{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)contentLabel{
    if (nil == _contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}
- (UIView *)backView{
    if (nil == _backView) {
        _backView = [[UIView alloc]init];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
- (instancetype)initWithTitle:(NSString *)title WithContent:(NSString *)content{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:64.0/255 green:63.0/255 blue:69.0/255 alpha:0.5];
        [self makeView];
        self.titleLabel.text = title;
        self.contentLabel.text = content;
    }
    return self;
}

- (void)makeView{
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.contentLabel];
    [self.backView addSubview:self.cancleButton];
    [self.backView addSubview:self.confirmButton];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(300);
        make.center.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(20);
        make.right.offset(-20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.backView.mas_centerX);
        make.height.greaterThanOrEqualTo(@70);
        make.width.lessThanOrEqualTo(@(300-40));
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.height.equalTo(@40);
        make.left.equalTo(self.backView).offset(15);
        make.right.equalTo(self.confirmButton.mas_left).offset(-15);
        make.width.equalTo(self.confirmButton);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancleButton);
        make.height.equalTo(@40);
        make.left.equalTo(self.cancleButton.mas_right).offset(15);
        make.right.equalTo(self.backView).offset(-15);
        make.width.equalTo(self.cancleButton);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.confirmButton).offset(20);
    }];
    
}

- (void)setMgAlertType:(MGAlertViewButtonType)mgAlertType{
    _mgAlertType = mgAlertType;
    switch (_mgAlertType) {
        case MGAlertViewButtonTypeOnlyConfirm:
            [self updateUIOnlyConfrim];
            break;
        case MGAlertViewButtonTypeCancleAndConfirm:
            [self updateUIConfirmAndCancle];
            break;
        default:
            break;
    }
}

- (void)updateUIOnlyConfrim{
    [self.cancleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.height.equalTo(@40);
        make.left.equalTo(self.backView).offset(15);
        make.right.equalTo(self.backView).offset(-15);
    }];
}
- (void)updateUIConfirmAndCancle{
    [self.cancleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        make.height.equalTo(@40);
        make.left.equalTo(self.backView).offset(15);
        make.right.equalTo(self.confirmButton.mas_left).offset(-15);
        make.width.equalTo(self.confirmButton);
    }];
    
    [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancleButton);
        make.height.equalTo(@40);
        make.left.equalTo(self.cancleButton.mas_right).offset(15);
        make.right.equalTo(self.backView).offset(-15);
        make.width.equalTo(self.cancleButton);
    }];
}
-(void)setLeftBtnTitle:(NSString *)leftBtnTitle{
    _leftBtnTitle = leftBtnTitle;
    [_cancleButton setTitle:_leftBtnTitle forState:UIControlStateNormal];
}
-(void)setRightBtnTitle:(NSString *)rightBtnTitle{
    _rightBtnTitle = rightBtnTitle;
    [_confirmButton setTitle:_rightBtnTitle forState:UIControlStateNormal];
}
- (void)cancleClicked{
    self.cancleBlock(self);
}
- (void)confirmClicked{
    self.confirmBlock(self);
}
+ (MGAlertView *)mgAlertViewWithTitle:(NSString *)title WithContent:(NSString *)content withConfirmBlock:(ConfirmButtonBlock)confirm{
    MGAlertView *alertView = [[MGAlertView alloc]initWithTitle:title WithContent:content];
    alertView.mgAlertType = MGAlertViewButtonTypeOnlyConfirm;
    alertView.confirmBlock = confirm;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    
    return alertView;
}
+ (MGAlertView *)mgAlertViewWithTitle:(NSString *)title WithContent:(NSString *)content withConfirmBlock:(ConfirmButtonBlock)confirm withCancleBlock:(CancleButtonBlock)cancle{
    MGAlertView *alertView = [[MGAlertView alloc]initWithTitle:title WithContent:content];
    alertView.mgAlertType = MGAlertViewButtonTypeCancleAndConfirm;
    alertView.confirmBlock = confirm;
    alertView.cancleBlock = cancle;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    return alertView;
}

+ (void)removeView{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[MGAlertView class]]) {
            [view removeFromSuperview];
        }
    }
}
@end
