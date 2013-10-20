//
//  PTGExtraCell.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGExtraCell.h"

@implementation PTGExtraCell

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

- (IBAction)localizeButtonTapped:(id)sender {
    if([self.delegate respondsToSelector:@selector(shouldShowOnMapPlaceAtIndex:)]) {
        [self.delegate shouldShowOnMapPlaceAtIndex:self.index];
    }
}

+(PTGExtraCell *)setupViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views objectAtIndex:0];
}

@end
