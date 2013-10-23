//
//  PTGPlaceCell.m
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGPlaceCell.h"
#import "UIImageView+AFNetworking.h"
#import "PTGURLUtils.h"
#import <QuartzCore/QuartzCore.h>

@implementation PTGPlaceCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
+(PTGPlaceCell *)setupViews {
    NSArray *views =[[NSBundle mainBundle] loadNibNamed:@"PTGPlaceCell" owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    [self applyHighlight:highlighted];
}

-(void)prepareForReuse {
    if(placeImageView) {
        [placeImageView cancelImageRequestOperation];
        placeImageView.image = nil;
    }
}

-(void)setupWithPlace:(PTGPlace*)place {
    if(VALID_NOTEMPTY(place.mainImage, NSString) && VALID(placeImageView, UIImageView)) {
        [placeImageView setImageWithURLString:[PTGURLUtils mainPlaceImageUrlForId:place.mainImage]
                            urlRebuildOptions:kFromOther
                                  withSuccess:nil failure:nil];
        placeImageView.layer.cornerRadius = 5;
        placeImageView.layer.masksToBounds = YES;
        
    }
    placeNameLabel.text = place.name;
    streetStaticLabel.text = NSLocalizedString(streetStaticLabel.text, @"");
    streetLabel.text = place.street;
    distanceStaticLabel.text = NSLocalizedString(distanceStaticLabel.text, @"");;
    distanceLabel.text = place.distance;
    [self applyFonts];
    
}
-(void)applyFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeNameLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceLabel];
    CGSize size = [streetStaticLabel.text sizeWithFont:streetStaticLabel.font];
    [self repositionLabel:streetLabel forSize:size anchorLabel:streetStaticLabel];
    size = [distanceStaticLabel.text sizeWithFont:distanceStaticLabel.font];
    [self repositionLabel:distanceLabel forSize:size anchorLabel:distanceStaticLabel];
}

-(void)applyHighlight:(BOOL)highlight {
    placeNameLabel.highlighted = highlight;
    streetStaticLabel.highlighted = highlight;
    streetLabel.highlighted = highlight;
    distanceStaticLabel.highlighted = highlight;
    distanceLabel.highlighted = highlight;
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



@end
