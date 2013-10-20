//
//  PTGDiaryHeaderView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGDiaryHeaderView.h"

@implementation PTGDiaryHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(PTGDiaryHeaderView *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}
-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_TB forView:self.bigLabel];
    [ICFontUtils applyFont:QLASSIK_TB forView:self.smallLabel];
    [self.bigLabel sizeToFit];
    [self.smallLabel sizeToFit];
    self.smallLabel.frame = CGRectMake(self.bigLabel.frame.size.width
                                       +self.bigLabel.frame.origin.x
                                       +10,
                                       self.smallLabel.frame.origin.y,
                                       self.smallLabel.frame.size.width,
                                       self.smallLabel.frame.size.height);
    
}

@end
