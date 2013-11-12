//
//  PTGCustomMapView.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/23/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGCustomMapView.h"
#import "PTGURLUtils.h"
#import "UIImageView+AFNetworking.h"

@implementation PTGCustomMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(PTGCustomMapView *)initializeView {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}
-(void)setTapHandler:(void(^)(PTGPlace * place))handler {
    tapHandler = handler;
}

-(void)setupWithPlace:(PTGPlace*)place distanceFromUser:(double)distance{
    if(VALID_NOTEMPTY(place.mainImage, NSString) && VALID(placeImageView, UIImageView)) {
        [placeImageView setImageWithURLString:[PTGURLUtils mainPlaceImageUrlForId:place.mainImage]
                            urlRebuildOptions:kFromOther
                                  withSuccess:^(BOOL completed) {
                                      ZLog(@"Completed");
                                  } failure:nil];
        placeImageView.layer.cornerRadius = 5;
        placeImageView.layer.masksToBounds = YES;
        placeImageView.hidden = NO;
        imageBox.hidden = NO;
        [self positionLabels];
    }
    else {
        placeImageView.hidden = YES;
        imageBox.hidden = YES;
    }
    currentPlace = place;
    placeNameLabel.text = place.name;
    streetStaticLabel.text = NSLocalizedString(streetStaticLabel.text, @"");
    streetLabel.text = place.street;
    distanceStaticLabel.text = NSLocalizedString(distanceStaticLabel.text, @"");
    placeTypeStaticLabel.text = NSLocalizedString(placeTypeStaticLabel.text, @"");
    placeTypeLabel.text = place.category.name;
    distanceLabel.text = [NSString stringWithFormat:@"%.2fKm", distance/1000];
    [self applyFonts];
    [self positionLabels];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    [self addGestureRecognizer:tap];
}

-(void)tapDetected {
    if(tapHandler) {
        tapHandler(currentPlace);
    }
}

-(void)positionLabels {
    CGFloat extraSpace;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        extraSpace = 10;
    }
    else {
        extraSpace = 15;
    }
    CGFloat diff = placeImageView.frame.origin.x + placeImageView.frame.size.width;
    if(placeImageView.hidden) {
        diff = placeImageView.frame.origin.x - extraSpace + 2;
    }
    labelContainer.frame = CGRectMake(diff, labelContainer.frame.origin.y, labelContainer.frame.size.width, labelContainer.frame.size.height);
}
-(void)applyFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeNameLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeTypeStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeTypeLabel];
    
    [streetStaticLabel sizeToFit];
    CGSize size = streetStaticLabel.frame.size;
    [self repositionLabel:streetLabel forSize:size anchorLabel:streetStaticLabel];
    [distanceStaticLabel sizeToFit];
    size = distanceStaticLabel.frame.size;
    [self repositionLabel:distanceLabel forSize:size anchorLabel:distanceStaticLabel];
    [placeTypeStaticLabel sizeToFit];
    size = placeTypeStaticLabel.frame.size;
    [self repositionLabel:placeTypeLabel forSize:size anchorLabel:placeTypeStaticLabel];
}

-(void)applyHighlight:(BOOL)highlight {
    placeNameLabel.highlighted = highlight;
    streetStaticLabel.highlighted = highlight;
    streetLabel.highlighted = highlight;
    distanceStaticLabel.highlighted = highlight;
    distanceLabel.highlighted = highlight;
}

-(void)repositionLabel:(UILabel *)label forSize:(CGSize )size anchorLabel:(UILabel *)anchorLabel {
    [label sizeToFit];
    CGRect rect = anchorLabel.frame;
    rect.size.width = size.width;
    anchorLabel.frame = rect;
    label.frame = CGRectMake(rect.origin.x + rect.size.width + 5,
                             anchorLabel.frame.origin.y,
                             label.frame.size.width,
                             label.frame.size.height);
}



@end
