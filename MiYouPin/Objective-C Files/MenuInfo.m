//
//  MenuInfo.m
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/18.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo

-(id)initWithTitle:(NSString *)title url:(NSURL *)aURL image:(UIImage *)aImage {
    self = [super init];
    if (self) {
        self.title = title;
        self.url = aURL;
        self.image = aImage;
    }
    return self;

}

+ (id)initWithTitle:(NSString *)title url:(NSURL *)aURL image:(UIImage *)aImage {
    return [[self alloc] initWithTitle:title url:aURL image:aImage];
}

@end
