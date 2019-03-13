//
//  WebViewController.m
//  TFComponentsDemo
//
//  Created by Time on 2019/3/13.
//  Copyright © 2019 ztf. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reload:@"https://www.jd.com/?cu=true&utm_source=baidu-pinzhuan&utm_medium=cpc&utm_campaign=t_288551095_baidupinzhuan&utm_term=0f3d30c8dba7459bb52f2eb5eba8ac7d_0_28191aef0c5e4b7a9d4e9c4952c3e576" title:@""];
}




@end
