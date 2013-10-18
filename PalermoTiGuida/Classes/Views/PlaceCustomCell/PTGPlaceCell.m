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

-(void)prepareForReuse {
    [placeImageView cancelImageRequestOperation];
    placeImageView.image = nil;
}

-(void)setupWithPlace:(PTGPlace*)place {
    if(VALID_NOTEMPTY(place.mainImage, NSString)) {
        [placeImageView setImageWithURLString:[PTGURLUtils mainImageUrlForId:place.mainImage]
                            urlRebuildOptions:kFromOther
                                  withSuccess:nil failure:nil];
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
