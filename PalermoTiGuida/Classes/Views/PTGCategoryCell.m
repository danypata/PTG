//
//  PTGCategoryCell.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGCategoryCell.h"

@implementation PTGCategoryCell

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

-(void)isFirstCell {
    [self setupFont];
    self.cellBgImage.image = [UIImage imageNamed:@"table_top_cell_bg"];
}

-(void)isMiddleCell {
    [self setupFont];
    self.cellBgImage.image = [UIImage imageNamed:@"table_middle_cell_bg"];
}

-(void)setupFont {
    [ICFontUtils applyFont:QLASSIK_TB forView:self.categoryNameLabel];
}

-(void)isLastCell {
    [self setupFont];
    self.cellBgImage.image = [UIImage imageNamed:@"table_bottom_cell"];
}

+(PTGCategoryCell *)setupViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PTGCategoryCell" owner:nil options:nil];
    return [views objectAtIndex:0];
}

@end
