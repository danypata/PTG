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

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.cellBgImage.highlighted = highlighted;
    if(highlighted) {
        self.categoryNameLabel.shadowColor = [UIColor colorWithRed:19.f/255.f green:88.f/255.f blue:159.f/255.f alpha:1];
    }
    else {
        self.categoryNameLabel.shadowColor = [UIColor colorWithRed:11.f/255.f green:12.f/255.f blue:13.f/255.f alpha:1];
    }
}

-(void)isFirstCell {
    [self setupFont];
    self.cellBgImage.image = [UIImage imageNamed:@"table_top_cell_bg"];
    self.cellBgImage.layer.masksToBounds = YES;
    self.cellBgImage.clipsToBounds  = YES;
    self.cellBgImage.highlightedImage = [[UIImage imageNamed:@"table_top_cell_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(30, 26, 30, 26)];
}

-(void)isMiddleCell {
    [self setupFont];
    self.cellBgImage.image = [UIImage imageNamed:@"table_middle_cell_bg"];
    self.cellBgImage.highlightedImage = [[UIImage imageNamed:@"table_midle_cell_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 26, 10, 26)];
}

-(void)setupFont {
    [ICFontUtils applyFont:QLASSIK_TB forView:self.categoryNameLabel];
}

-(void)isLastCell {
    [self setupFont];
    self.cellBgImage.image = [UIImage imageNamed:@"table_bottom_cell"];
    self.cellBgImage.highlightedImage = [[UIImage imageNamed:@"table_bottom_cell_selected"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 26, 10, 26)];;
}

+(PTGCategoryCell *)setupViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PTGCategoryCell" owner:nil options:nil];
    return [views objectAtIndex:0];
}

@end
