//
//  MenuInfo.h
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/18.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuInfo : NSObject
@property NSString *title;
@property NSURL *url;
@property UIImage *image;

+(id)initWithTitle: (NSString *)title url:(NSURL *)aURL image:(UIImage *)aImage;
@end

NS_ASSUME_NONNULL_END
