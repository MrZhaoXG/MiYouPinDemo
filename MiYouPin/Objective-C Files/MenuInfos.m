//
//  MenuInfos.m
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/18.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

#import "MenuInfos.h"
#import "MenuInfo.h"

@implementation MenuInfos



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.infos = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 10; i ++) {
            [self.infos addObject:[MenuInfo initWithTitle:@"" url:[[NSURL alloc] init] image:[UIImage imageNamed:[NSString stringWithFormat:@"未标题-%d", i]]] ] ;
        }
        MenuInfo * info0 = self.infos[0];
        info0.title = @"每日上新";
        MenuInfo * info1 = self.infos[1];
        info1.title = @"小米众筹";
        MenuInfo * info2 = self.infos[2];
        info2.title = @"限时抢购";
        MenuInfo * info3 = self.infos[3];
        info3.title = @"热销排行";
        MenuInfo * info4 = self.infos[4];
        info4.title = @"小米自营";
        MenuInfo * info5 = self.infos[5];
        info5.title = @"新人包邮";
        MenuInfo * info6 = self.infos[6];
        info6.title = @"新人五折";
        MenuInfo * info7 = self.infos[7];
        info7.title = @"一元拼团";
        MenuInfo * info8 = self.infos[8];
        info8.title = @"雷军同款";
        MenuInfo * info9 = self.infos[9];
        info9.title = @"新人必买";

    }
    return self;
}
@end
