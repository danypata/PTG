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
@interface ICFontUtils : NSObject {
    
}

+(void)applyFont:(NSString *)fontName forView:(UIView *)view;

@end
