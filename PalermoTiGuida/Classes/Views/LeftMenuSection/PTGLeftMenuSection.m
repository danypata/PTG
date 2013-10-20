//
//  PTGLeftMenuSection.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGLeftMenuSection.h"

@implementation PTGLeftMenuSection
@synthesize isOpened = _isOpened;
@synthesize section;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(PTGLeftMenuSection *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)setIsOpened:(BOOL)isOpened {
    _isOpened = isOpened;
    arrowImage.highlighted = isOpened;

}
-(void)setTitle:(NSString *)title {
    sectionTitle.text = title;
    [ICFontUtils applyFont:QLASSIK_TB forView:sectionTitle];
    [self addTapGesture];
}
-(void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTapped)];
    [self addGestureRecognizer:tapGesture];
}

-(void)sectionTapped {
    self.isOpened = !self.isOpened;
    if(self.isOpened) {
        if([self.delegate respondsToSelector:@selector(openSectionAtIndex:)]){
            [self.delegate openSectionAtIndex:self.section];

        }
    }
    else  {
        if([self.delegate respondsToSelector:@selector(closeSectionAtIndex:)]){
            [self.delegate closeSectionAtIndex:self.section];
        }
    }
}



@end
