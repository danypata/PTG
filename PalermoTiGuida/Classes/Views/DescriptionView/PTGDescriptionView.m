//
//  PTGDescriptionView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGDescriptionView.h"
#import "PTGCategory.h"
@implementation PTGDescriptionView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(PTGDescriptionView *)setupViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PTGDescriptionView" owner:nil options:nil];
    return [views objectAtIndex:0];
}
-(void)setDescriptionForPlace:(PTGPlace *)place {
//    descriptionTextField.text = place.descriptionText;
    descriptionTextField.text = @"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem IpsumLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    initialHeight = descriptionTextField.frame.size.height;
    [self setupFonts];
    CGFloat height = descriptionTextField.contentSize.height;
    if(height < descriptionTextField.frame.size.height) {
        descriptionTextField.frame = CGRectMake(descriptionTextField.frame.origin.x,
                                                descriptionTextField.frame.origin.y,
                                                descriptionTextField.frame.size.width,
                                                height);
        moreButton.hidden = YES;
    }
    else {
        moreButton.hidden = NO;
    }
    if([place.category.type integerValue] == 4) {
        buttonContainer.hidden = NO;
    }
    else {
        buttonContainer.hidden = YES;
    }
    [self positionViews];
}

-(void)positionViews {
    moreButton.frame = CGRectMake(moreButton.frame.origin.x,
                                  descriptionTextField.frame.origin.y + descriptionTextField.frame.size.height + SPACING_TOP,
                                  moreButton.frame.size.width,
                                  moreButton.frame.size.height);
    
    buttonContainer.frame = CGRectMake(buttonContainer.frame.origin.x,
                                       moreButton.frame.origin.y + moreButton.frame.size.height + SPACING_TOP,
                                       buttonContainer.frame.size.width,
                                       buttonContainer.frame.size.height);

    CGFloat height = buttonContainer.frame.size.height + buttonContainer.frame.origin.y;
    if(buttonContainer.hidden == YES) {
        height = moreButton.frame.size.height + moreButton.frame.origin.y;
    }
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            height+ SPACING_TOP);
    bgImage.frame = CGRectMake(bgImage.frame.origin.x,
                               bgImage.frame.origin.y,
                               bgImage.frame.size.width,
                               self.frame.size.height);

    
}

-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:moreButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:portoButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:imbarcaoButton];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:descriptionTextField];
}

- (IBAction)moreButtonPressed:(id)sender {
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat height = descriptionTextField.contentSize.height;
        if(descriptionTextField.frame.size.height == height) {
            descriptionTextField.frame = CGRectMake(descriptionTextField.frame.origin.x,
                                                    descriptionTextField.frame.origin.y,
                                                    descriptionTextField.frame.size.width,
                                                    initialHeight);
        }
        else {
            descriptionTextField.frame = CGRectMake(descriptionTextField.frame.origin.x,
                                                    descriptionTextField.frame.origin.y,
                                                    descriptionTextField.frame.size.width,
                                                    height);
        }
        [self positionViews];
        if([self.delegate respondsToSelector:@selector(shouldResizeScorllView)]) {
            [self.delegate shouldResizeScorllView];
        }
    }];
}

- (IBAction)portoButtonPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(portoButtonPressed)]) {
        [self.delegate portoButtonPressed];
    }
}

- (IBAction)imbracaoButtonPressed:(id)sender {
    if([self.delegate respondsToSelector:@selector(imbracaoButtonPressed)]) {
        [self.delegate imbracaoButtonPressed];
    }
}
@end
