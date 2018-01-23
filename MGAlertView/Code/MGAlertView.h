//
//  MGAlertView.h
//  BHAFApp
//
//  Created by 马祥忠 on 2017/8/14.
//  Copyright © 2017年 小马哥. All rights reserved.
//

/*
 这是一个自定义弹框
 练习上传
 
 */


#import <UIKit/UIKit.h>


@class MGAlertView;

typedef enum : NSUInteger {
    MGAlertViewButtonTypeOnlyConfirm = 0,
    MGAlertViewButtonTypeCancleAndConfirm = 1,
} MGAlertViewButtonType;

typedef void(^CancleButtonBlock)(MGAlertView *alertView);
typedef void(^ConfirmButtonBlock)(MGAlertView *alertView);

@interface MGAlertView : UIView

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/** 内容 */
@property (nonatomic, strong) UILabel *contentLabel;

/** MGAlertViewButtonType */
@property(nonatomic,assign) MGAlertViewButtonType mgAlertType;

/** 取消按钮回调 */
@property (nonatomic, copy) CancleButtonBlock cancleBlock;

/** 确定按钮回调 */
@property (nonatomic, copy) ConfirmButtonBlock confirmBlock;

/** 左边按钮标题 */
@property (nonatomic, strong) NSString *leftBtnTitle;

/** 右边按钮标题 */
@property (nonatomic, strong) NSString *rightBtnTitle;

/**
 *  一个按钮的alert
 *
 *  @param title   标题
 *  @param content 内容
 *  @param confirm 确定按钮点击事件
 *
 *  @return 返回alertView 可自定义页面
 */
+ (MGAlertView *)mgAlertViewWithTitle:(NSString *)title WithContent:(NSString *)content withConfirmBlock:(ConfirmButtonBlock)confirm;
/**
 *  两个按钮的alert
 *
 *  @param title   标题
 *  @param content 内容
 *  @param confirm 确定按钮的回调(左按钮)
 *  @param cancle  取消按钮的回调(右按钮)
 *
 *  @return 返回alertView 可自定义页面
 */
+ (MGAlertView *)mgAlertViewWithTitle:(NSString *)title WithContent:(NSString *)content withConfirmBlock:(ConfirmButtonBlock)confirm withCancleBlock:(CancleButtonBlock)cancle;
/**
 *  离开页面移除alert
 */
+ (void)removeView;

@end
