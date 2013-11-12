//
//  PTGCustomDeleteButton.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGCustomDeleteButton.h"
#import "PTGPlaceCell.h"
@implementation PTGCustomDeleteButton
@synthesize delegate;
@synthesize cellIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(PTGCustomDeleteButton *)initializeVies {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return  [views objectAtIndex:0];
}

-(void)setupGestures {
    buttonLabel.text = NSLocalizedString(buttonLabel.text, @"");
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:buttonLabel];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(toggleView)];
    [self addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = YES;
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action: @selector(deleteCell)];
    [buttonLabel addGestureRecognizer:tapGesture];
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        offset = 15;
    }
    else {
        offset = 25;
    }
}

-(void)toggleView {
    [UIView animateWithDuration:0.3 animations:^{
        if(isShown) {
            self.frame =CGRectMake(-self.frame.size.width + offset,
                                   self.frame.origin.y,
                                   self.frame.size.width,
                                   self.frame.size.height);
        }
        else {
            self.frame =CGRectMake(0,
                                   self.frame.origin.y,
                                   self.frame.size.width,
                                   self.frame.size.height);
        }
    }];
    isShown = !isShown;
}

-(void)deleteCell {
    if([self.delegate respondsToSelector:@selector(shouldDeleteCellAtIndex:)]) {
        [self.delegate shouldDeleteCellAtIndex:self.cellIndex];
    }
}
@end
