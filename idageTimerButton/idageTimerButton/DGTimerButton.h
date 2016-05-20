//
//  DGTimerButton.h
//  idageTimerBU
//
//  Created by 冯亮 on 16/5/19.
//  Copyright © 2016年 idage. All rights reserved.
//

/*
 
 个人简书地址：http://www.jianshu.com/users/83b2eba88a0d/latest_articles
 
 欢迎查看
 
 
 */
#import <UIKit/UIKit.h>
//控件状态
typedef NS_ENUM(NSInteger ,BUStatus){
    BUStatusNone,//没开始
    BUStatusRuning,//进行中
    BUStatusCancel,//结束了（计时没有结束，没有超时）
    BUStatusFinish,//计时结束了 超时了
};
@interface DGTimerButton : UIButton
/**
 *  正在计时按钮的背景颜色
 */
@property(nonatomic,strong)UIColor *runingColor;
/**
 *  正在计时按钮的文字的颜色
 */
@property(nonatomic,strong)UIColor *runingTextColor;
/**
 *  正在计时时的图片
 */
@property(nonatomic,copy) NSString  *runingImgName;
/**
 *  格式化文字 例如（剩余时间%zd秒）
 */
@property(nonatomic,copy) NSString  *formatStr;

/**
 *  设置计时按钮的时长和状态的回调(和下面的方法只用一个就行)
 *
 *  @param durtaion   时间 单位秒
 *  @param buStatus   状态的回调
 */
-(void)setDGTimerButtonWithDuration:(NSInteger)durtaion buStatus:(void(^)(BUStatus status))bustatus;
/**
 *  初始化的方法 (和上面的方法只用一个就行)
 *
 *  @param durtaion        时间
 *  @param runingColor     正在计时按钮的背景颜色
 *  @param runingTextColor 正在计时按钮的文字的颜色
 *  @param runingImgName   正在计时时的背景图片名
 *  @param bustatus        状态的回调
 */
-(void)setDGTimerButtonWithDuration:(NSInteger)durtaion runingColor:(UIColor*)runingColor runingTextColor:(UIColor *)runingTextColor runingImgName:(NSString*)runingImgName formatStr:(NSString *)formatStr buStatus:(void(^)(BUStatus status))bustatus;
/**
 *  开始计时
 */
-(void)beginTimers;
/**
 *  结束计时
 */
-(void)stopTimers;
@end
