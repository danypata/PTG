//
//  PTGDescriptionView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGDescriptionView.h"
#import "PTGCategory.h"
#import "PTGCoreTextView.h"

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
    if([place.categoryType integerValue] == 4) {
        buttonContainer.hidden = NO;
    }
    else {
        buttonContainer.hidden = YES;
    }
    textView = [[PTGCoreTextView alloc] initWithFrame:CGRectMake(bgImage.frame.origin.x + SPACING_TOP, SPACING_TOP,
                                                                 bgImage.frame.size.width - 2* SPACING_TOP,
                                                                 moreButton.frame.origin.y - 2* SPACING_TOP)];
    initialHeight = textView.frame.size.height;
    CGFloat pointSize = 0;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        pointSize = 26.f;
    }
    else {
        pointSize = 15.f;
    }
    textView.text = place.descriptionText;
    
    textView.textFont = [UIFont fontWithName:QLASSIK_BOLD_TB size:pointSize];
    
    NSInteger lines = [textView linesForFrame:CGRectMake(textView.frame.origin.x,
                                                         textView.frame.origin.y,
                                                         textView.frame.size.width, CGFLOAT_MAX)];
    actualHeight = [textView heightForText] * lines;
    if(lines < 10) {
        moreButton.hidden = YES;
        textView.frame = CGRectMake(textView.frame.origin.x,
                                    textView.frame.origin.y,
                                    textView.frame.size.width,
                                    actualHeight + SPACING_TOP);
    }
    else {
        moreButton.hidden = NO;
    }
    [self addSubview:textView];
    [self setupFonts];
    [self positionViews];
}

-(void)positionViews {
    
    if(!moreButton.hidden) {
        moreButton.frame = CGRectMake(moreButton.frame.origin.x,
                                      textView.frame.origin.y + textView.frame.size.height + SPACING_TOP,
                                      moreButton.frame.size.width,
                                      moreButton.frame.size.height);
    }
    else {
        moreButton.frame = CGRectMake(moreButton.frame.origin.x,
                                      textView.frame.origin.y + textView.frame.size.height + SPACING_TOP,
                                      moreButton.frame.size.width,
                                      0);

    }
    
    if(moreButton.hidden) {
        buttonContainer.frame = CGRectMake(buttonContainer.frame.origin.x,
                                           textView.frame.origin.y + textView.frame.size.height + SPACING_TOP,
                                           buttonContainer.frame.size.width,
                                           buttonContainer.frame.size.height);

    }
    else {
        buttonContainer.frame = CGRectMake(buttonContainer.frame.origin.x,
                                           moreButton.frame.origin.y + moreButton.frame.size.height + SPACING_TOP,
                                           buttonContainer.frame.size.width,
                                           buttonContainer.frame.size.height);

    }
    
    CGFloat height = buttonContainer.frame.size.height + buttonContainer.frame.origin.y;
    if(buttonContainer.hidden == YES) {
        height = moreButton.frame.size.height + moreButton.frame.origin.y;
    }
    if(moreButton.hidden) {
        height = textView.frame.origin.y + textView.frame.size.height;
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
    [moreButton setTitle:NSLocalizedString(moreButton.titleLabel.text, @"") forState:UIControlStateNormal];
    [portoButton setTitle:NSLocalizedString(portoButton.titleLabel.text, @"") forState:UIControlStateNormal];
    [imbarcaoButton setTitle:NSLocalizedString(imbarcaoButton.titleLabel.text, @"") forState:UIControlStateNormal];
}

- (IBAction)moreButtonPressed:(id)sender {
    textView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        if(textView.frame.size.height >= initialHeight+10) {
            textView.frame = CGRectMake(textView.frame.origin.x,
                                        textView.frame.origin.y,
                                        textView.frame.size.width,
                                        initialHeight);
         [moreButton setTitle:NSLocalizedString(@"leggi ancora", @"") forState:UIControlStateNormal];

        }
        else {
            textView.frame = CGRectMake(textView.frame.origin.x,
                                        textView.frame.origin.y,
                                        textView.frame.size.width,
                                        actualHeight);
             [moreButton setTitle:NSLocalizedString(@"riduci", @"") forState:UIControlStateNormal];
        }
        [textView setNeedsDisplay];
        textView.alpha = 1;
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
