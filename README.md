# idageTimerButton
引入一个类，然后只需要多一个方法，就可以让一个按钮有计时的功能，而且还可以通过一个block回调知道计时的状态

使用
[button setDGTimerButtonWithDuration:50
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
        }else{
           //没开始
        }
    }];

