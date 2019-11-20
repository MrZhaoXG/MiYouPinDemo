//
//  TabBarViewController.m
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/18.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

#import "TabBarViewController.h"
#import <UIKit/UIKit.h>

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabbar = self.tabBar;
    tabbar.backgroundColor = [UIColor whiteColor];
    NSLog(@"what's going on...");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
