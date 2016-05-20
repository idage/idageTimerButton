//
//  DGTimerButton.m
//  idageTimerBU
//
//  Created by 冯亮 on 16/5/19.
//  Copyright © 2016年 idage. All rights reserved.
//

#import "DGTimerButton.h"
#import <objc/runtime.h>

@interface DGTimerButton()
/**
 *  控件的状态
 */
@property(nonatomic,assign)BUStatus statusType;
/**
 *  计时的时间
 */
@property(nonatomic,assign)NSInteger timeCount;
/**
 *  计时原始时间
 */
@property(nonatomic,assign)NSInteger oldTimeCount;
/**
 *  计时器
 */
@property(weak, nonatomic) NSTimer *timer;
/**
 *  按钮的初始背景色
 */
@property(nonatomic,strong)UIColor *normalBgColor;
/**
 *  按钮的初始背景图片
 */
@property(nonatomic,strong)UIImage *normalBgImg;
/**
 *  按钮默认情况下的文字颜色
 */
@property(nonatomic,strong)UIColor *normalTextColor;
@property(nonatomic,copy)NSString  *normalText;
@end
//用于关联block
static void *statusBlockKey = @"statusBlockKey";

@implementation DGTimerButton

//重写buttonWithType 方法 UIButtonTypeCustom按钮计时改变的时候不会闪动
+ (instancetype)buttonWithType:(UIButtonType)buttonType{
    
    return [super buttonWithType:UIButtonTypeCustom];
}
/**
 *  设置计时按钮的时长和状态的回调
 *
 *  @param durtaion   时间 单位秒
 *  @param bustatus   状态的回调
 */
-(void)setDGTimerButtonWithDuration:(NSInteger)durtaion buStatus:(void(^)(BUStatus status))bustatus{
    _timeCount      = durtaion;
    _oldTimeCount   = durtaion;
    _statusType     = BUStatusNone;
    
    objc_setAssociatedObject(self, statusBlockKey, bustatus, OBJC_ASSOCIATION_COPY);
    
    bustatus(BUStatusNone);
}
-(void)setDGTimerButtonWithDuration:(NSInteger)durtaion runingColor:(UIColor*)runingColor runingTextColor:(UIColor *)runingTextColor runingImgName:(NSString*)runingImgName formatStr:(NSString *)formatStr buStatus:(void(^)(BUStatus status))bustatus{
    
    /*
     
     个人简书地址：http://www.jianshu.com/users/83b2eba88a0d/latest_articles
     
     欢迎查看
     
     
     */
    
    
    _runingImgName      =runingImgName;
    _runingColor        =runingColor;
    _runingTextColor    =runingTextColor;
    _formatStr          =formatStr;
    [self setDGTimerButtonWithDuration:durtaion buStatus:^(BUStatus status) {
        bustatus(status);
    }];
}
/**
 *  开始计时
 */
-(void)beginTimers{
    
  if (!self.timer) {
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
  }
    //更新时间
    _timeCount = _oldTimeCount;
    //记录按钮的原始状态
    _normalBgColor       = self.backgroundColor;
    _normalBgImg         = self.currentBackgroundImage;
    _normalTextColor     = self.currentTitleColor;
    _normalText          = self.currentTitle;
    //设置按钮计时时的样式
    if (_runingColor) {
        [self setBackgroundColor:_runingColor];
    }
    if (_runingImgName.length>0) {
        [self setBackgroundImage:[UIImage imageNamed:_runingImgName] forState:UIControlStateNormal];
    }
    if (_runingTextColor) {
        [self setTitleColor:_runingTextColor forState:UIControlStateNormal];
    }
    //让按钮不可以点击
    self.userInteractionEnabled = NO;
    self.titleLabel.adjustsFontSizeToFitWidth=YES;
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self next];
    
    void (^statusBlock)(NSInteger) = objc_getAssociatedObject(self, statusBlockKey);
    statusBlock(BUStatusRuning);

}
/**
 *  结束计时
 */
-(void)stopTimers{
    [self.timer invalidate];
     self.timer = nil;
    void (^statusBlock)(NSInteger) = objc_getAssociatedObject(self, statusBlockKey);

    if (_timeCount ==0) {//超时了
        statusBlock(BUStatusFinish);
    }else{
        //结束了但没有超时
        statusBlock(BUStatusCancel);
    }
    //还原按钮样式
     [self setBackgroundImage:_normalBgImg forState:UIControlStateNormal];
     [self setBackgroundColor:_normalBgColor];
     [self setTitleColor:_normalTextColor forState:UIControlStateNormal];
     [self setTitle:_normalText forState:UIControlStateNormal];
      self.userInteractionEnabled = YES;
}
- (void)next
{
    if (_timeCount<1) {
        //结束了 超时了
        [self stopTimers];
    }else{
         //改文字
        if (_formatStr.length>0) {
           [self setTitle:[NSString stringWithFormat:_formatStr,_timeCount] forState:UIControlStateNormal];
        }else{
            [self setTitle:[NSString stringWithFormat:@"%zdS",_timeCount] forState:UIControlStateNormal];
        }
        _timeCount--;
    }
}


@end
