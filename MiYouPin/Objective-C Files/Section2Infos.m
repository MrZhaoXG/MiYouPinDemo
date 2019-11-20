//
//  Section2Infos.m
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/19.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

#import "Section2Infos.h"
#import "MenuInfo.h"

@implementation Section2Infos
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.infos = [[NSMutableArray alloc] init];
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        NSURL *url = [NSURL URLWithString:@""];
        for (int i = 11; i <= 12; i++) {
            [arr addObject:[MenuInfo initWithTitle:@"123" url:url image:[UIImage imageNamed:[NSString stringWithFormat:@"未标题-%d", i]]]];
        }
        [self.infos addObject:arr];
        for (int i = 13; i <= 14; i++) {
            NSMutableArray *arr2 = [[NSMutableArray alloc] init];
            [arr2 addObject:[MenuInfo initWithTitle:@"" url:url image:[UIImage imageNamed:[NSString stringWithFormat:@"未标题-%d", i]]]];
            [self.infos addObject:arr2];
        }
    }
    return self;
}
@end
