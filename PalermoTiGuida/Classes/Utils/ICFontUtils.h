//
//  ICFontUtils.h
//  TheIconicIphone
//
//  Created by dan.patacean on 5/31/13.
//  Copyright (c) 2013 Rocket Internet GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define QLASSIK_BOLD_TB @"QlassikBold"
#define QLASSIK_TB @"QlassikMedium"

#define IS_IPHONE_5 ([UIScreen mainScreen].bounds.size.height == 568.0)

#ifdef IS_IPHONE_5
#define SCREEN_HEIGHT 568
#else
#define SCREEN_HEIGHT 480
#endif

@interface ICFontUtils : NSObject {
    
}

+(void)applyFont:(NSString *)fontName forView:(UIView *)view;

@end
