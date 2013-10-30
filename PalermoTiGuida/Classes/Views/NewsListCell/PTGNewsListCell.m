//
//  PTGNewsListCell.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 27/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGNewsListCell.h"
#import "PTGPlace.h"

@implementation PTGNewsListCell

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


+(PTGNewsListCell *)setupViews {
    NSArray *vies = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [vies objectAtIndex:0];
}
-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:titleLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:streetLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:dayLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:monthLabel];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    
    streetStaticLabel.text = NSLocalizedString(streetStaticLabel.text, @"");
    distanceStaticLabel.text = NSLocalizedString(distanceStaticLabel.text, @"");
    
    
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

-(void)setupWithNews:(PTGNews *)news {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    titleLabel.text = news.title;
    streetLabel.text = news.place.street;
    distanceLabel.text = news.place.distance;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:news.date];
    NSDateFormatter *shortFormat = [[NSDateFormatter alloc] init];
    [shortFormat setDateFormat:@"dd/MMM"];
    NSString *shortSting = [shortFormat stringFromDate:date];
    dayLabel.text = [[shortSting componentsSeparatedByString:@"/"] firstObject];
    monthLabel.text = [[[shortSting componentsSeparatedByString:@"/"] lastObject] uppercaseString];
}

-(void)isFirstCell {
    cellBgImage.image = [UIImage imageNamed:@"table_top_cell_bg"];
    cellBgImage.highlightedImage = [UIImage imageNamed:@"table_top_cell_selected"];
}

-(void)isMiddleCell {
    cellBgImage.image = [UIImage imageNamed:@"table_middle_cell_bg"];
    cellBgImage.highlightedImage = [UIImage imageNamed:@"table_midle_cell_selected"];
}


-(void)isLastCell {
    cellBgImage.image = [UIImage imageNamed:@"table_bottom_cell"];
    cellBgImage.highlightedImage = [UIImage imageNamed:@"table_bottom_cell_selected"];
}

@end
