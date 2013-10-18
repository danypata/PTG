//
//  ICFontUtils.m
//  TheIconicIphone
//
//  Created by dan.patacean on 5/31/13.
//  Copyright (c) 2013 Rocket Internet GmbH. All rights reserved.
//

#import "ICFontUtils.h"


@implementation ICFontUtils


+(void)applyFont:(NSString *)fontName forView:(UIView *)view {
    if(VALID_NOTEMPTY(fontName, NSString)) {
        if(VALID(view, UIView)) {
            if([view isKindOfClass:[UILabel class]]) {
                [ICFontUtils setFont:fontName forLabel:(UILabel *)view];
            }
            else if([view isKindOfClass:[UIButton class]]) {
                [ICFontUtils setFont:fontName forButton:(UIButton *)view];
            }
            else if([view isKindOfClass:[UITextField class]]) {
                [ICFontUtils setFont:fontName forTextField:(UITextField *)view];
            }
            else if ([view isKindOfClass:[UISearchBar class]]) {
                for (UIView *subView in view.subviews) {
                    if ([subView isKindOfClass:[UITextField class]]) {
                        [ICFontUtils setFont:fontName forTextField:(UITextField *) subView];
                    }
                }
            }
            else if ([view isKindOfClass:[UITextView class]]) {
                [ICFontUtils setFont:fontName forTextView:(UITextView *)view];
            }
        }
    }
}

+(void)setFont:(NSString *)fontName forLabel:(UILabel *)label {
    UIFont *font = [UIFont fontWithName:fontName size:label.font.pointSize];
    label.font = font;
}

+(void)setFont:(NSString *)fontName forButton:(UIButton *)button {
    UIFont *font = [UIFont fontWithName:fontName size:button.titleLabel.font.pointSize];
    button.titleLabel.font = font;
}

+(void)setFont:(NSString *)fontName forTextField:(UITextField *)textField {
    UIFont *font = [UIFont fontWithName:fontName size:textField.font.pointSize];
    textField.font = font;
}

+ (void)setFont:(NSString *)fontName forTextView:(UITextView *)textView {
    UIFont *font = [UIFont fontWithName:fontName size:textView.font.pointSize];
    textView.font = font;
}


@end
