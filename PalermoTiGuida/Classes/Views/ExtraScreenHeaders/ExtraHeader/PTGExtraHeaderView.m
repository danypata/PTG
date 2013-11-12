//
//  PTGExtraHeaderView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 09/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraHeaderView.h"

@implementation PTGExtraHeaderView
@synthesize isOpen;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)localizeButtonTapped:(id)sender {
}

+(PTGExtraHeaderView *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views firstObject];
}

-(void)setupWithPlace:(PTGPlace *)place {
    [self applyFonts];
    self.isOpen = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDedected)];
    [self addGestureRecognizer:tap];
    placeName.text = place.name;
    addressLabel.text = place.street;
    distanceLabel.text = place.distance;
    distanceStaticLabel.text = NSLocalizedString(distanceStaticLabel.text, @"");
    addressStaticLabel.text = NSLocalizedString(addressStaticLabel.text, @"");
    localizeLabel.text = NSLocalizedString(localizeLabel.text, @"");
    moreInfoLabel.text = NSLocalizedString(moreInfoLabel.text, @"");
    [moreInfoLabel sizeToFit];
}

-(void)setTapBlock:(void(^)(BOOL isOpen))block {
    tapHandlerBlock = block;
    
}

-(void)applyFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeName];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:addressStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:addressLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceLabel];
    [addressStaticLabel sizeToFit];

    [self repositionLabel:addressLabel forSize:addressStaticLabel.frame.size anchorLabel:addressStaticLabel];
    [distanceStaticLabel sizeToFit];
    [self repositionLabel:distanceLabel forSize:distanceStaticLabel.frame.size anchorLabel:distanceStaticLabel];
}

-(void)repositionLabel:(UILabel *)label forSize:(CGSize )size anchorLabel:(UILabel *)anchorLabel {
    CGRect rect = anchorLabel.frame;
    rect.size.width = size.width;
    anchorLabel.frame = rect;
    label.frame = CGRectMake(rect.origin.x + rect.size.width + 5,
                             label.frame.origin.y,
                             label.frame.size.width,
                             label.frame.size.height);
}

-(void)setBackgroundImageForIndex:(NSInteger)index {
    if(index == 0) {
        bgImage.image = [UIImage imageNamed:@"table_top_cell_bg"];
    }
    else if(index == 1) {
        bgImage.image = [UIImage imageNamed:@"table_middle_cell_bg"];
    }
    else {
        bgImage.image = [UIImage imageNamed:@"table_bottom_cell"];
    }
}

-(void)tapDedected {
    self.isOpen = !self.isOpen;
    if(self.isOpen) {
        moreInfoLabel.text = NSLocalizedString(@"Meno informazioni", @"");
        plusImageView.highlighted = YES;
    }
    else {
        moreInfoLabel.text = NSLocalizedString(@"Più informazioni", @"");
        plusImageView.highlighted = NO;
    }
    [moreInfoLabel sizeToFit];
    if(tapHandlerBlock) {
        tapHandlerBlock(self.isOpen);
    }
}


@end
