//
//  ViewController.m
//  idageTimerButton
//
//  Created by 冯亮 on 16/5/20.
//  Copyright © 2016年 idage. All rights reserved.
//

#import "ViewController.h"
#import "DGTimerButton.h"

@interface ViewController ()

@end

@implementation ViewController
{
    DGTimerButton *bu;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     个人简书地址：http://www.jianshu.com/users/83b2eba88a0d/latest_articles
     
     欢迎查看
     
     
     */
    
    
    bu = [DGTimerButton buttonWithType:UIButtonTypeCustom];
    [bu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bu setTitle:@"计时器" forState:UIControlStateNormal];
    [bu setBackgroundColor:[UIColor redColor]];
    [bu addTarget:self action:@selector(beginTimer) forControlEvents:UIControlEventTouchUpInside];
    [bu setFrame:CGRectMake(100, 100, 80, 40)];
    bu.formatStr=@"还剩%zd秒了";
    [bu setDGTimerButtonWithDuration:50
                         runingColor:[UIColor grayColor]                                               runingTextColor:[UIColor whiteColor]
                       runingImgName:nil
                           formatStr:@"还剩%zd秒了"
                            buStatus:^(BUStatus status) {
                                
                                if (status==BUStatusRuning) {
                                    //计时中
                                }else if (status==BUStatusCancel){
                                    //结束了（手动结束了，没有超时）
                                }else if (status==BUStatusFinish){
                                    //计时结束了 超时了
                                }
                                
                            }];
    [self.view addSubview:bu];
    //bu.buttonType= UIButtonTypeCustom;
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)beginTimer{
    [bu beginTimers];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)stop:(id)sender {
    [bu stopTimers];
}

@end
