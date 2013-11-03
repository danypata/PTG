//
//  PTGCoreTextView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 26/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGCoreTextView : UIView {
    
}
@property(nonatomic, strong) NSString *text;
@property(nonatomic) NSInteger lines;
@property(nonatomic, strong) UIFont *textFont;
@property(nonatomic, strong) UIColor *fontColor;
@property(nonatomic) CGFloat lineSpacing;

-(CGFloat)heightForText;
-(NSInteger)linesForFrame:(CGRect )frame;

@end
