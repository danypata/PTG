//
//  PTGExtraCellType7Cell.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 12/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraCellType7Cell.h"

@implementation PTGExtraCellType7Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(PTGExtraCellType7Cell *)initializeViews {
    NSArray *views =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views firstObject];
}
-(void)setupLabels {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeName];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:stationNumberStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:stationNumberLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:closingStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:closingLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:urbanCostStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:urbanCostLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:aeroportStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:aeroportLabel];
    
    stationNumberStaticLabel.text = NSLocalizedString(stationNumberStaticLabel.text, @"");
    closingStaticLabel.text = NSLocalizedString(closingStaticLabel.text, @"");
    urbanCostStaticLabel.text = NSLocalizedString(urbanCostStaticLabel.text, @"");
    aeroportStaticLabel.text = NSLocalizedString(aeroportStaticLabel.text, @"");
    
    [stationNumberStaticLabel sizeToFit];
    [closingStaticLabel sizeToFit];
    [urbanCostStaticLabel sizeToFit];
    [aeroportStaticLabel sizeToFit];
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
}

-(void)setupWithPlace:(PTGPlace *)place {
    
    placeName.text = place.name;
    stationNumberLabel.text = place.stationNumber;
    closingLabel.text = place.stops;
    urbanCostLabel.text = place.urbanPrice;
    aeroportLabel.text = place.airportPrice;
    
    [stationNumberLabel sizeToFit];
    [closingLabel sizeToFit];
    [urbanCostLabel sizeToFit];
    [aeroportLabel sizeToFit];
    
    [self repositionLabel:stationNumberLabel forSize:stationNumberStaticLabel.frame.size anchorLabel:stationNumberStaticLabel];
    [self repositionLabel:closingLabel forSize:closingStaticLabel.frame.size anchorLabel:closingStaticLabel];
    [self repositionLabel:urbanCostLabel forSize:urbanCostStaticLabel.frame.size anchorLabel:urbanCostStaticLabel];
    [self repositionLabel:aeroportLabel forSize:aeroportStaticLabel.frame.size anchorLabel:aeroportStaticLabel];
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
