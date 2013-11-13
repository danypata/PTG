
//
//  PTExtraCellType8GCell.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 12/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTExtraCellType8GCell.h"
#import "PTGPlace.h"

@implementation PTExtraCellType8GCell

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

-(void)setupWithPlace:(PTGPlace *)place {
    [self applyFonts];
    phoneStaticLabel.text = NSLocalizedString(phoneStaticLabel.text, @"");
    callStaticLabel.text = NSLocalizedString(callStaticLabel.text, @"");
    placeName.text = place.name;
    NSArray *phones = [NSKeyedUnarchiver unarchiveObjectWithData:place.phones];
    phoneLabel.text = [phones firstObject];
}
+(PTExtraCellType8GCell *)initializeViews {
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [views firstObject];
}

-(void)applyFonts {
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:placeName];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:phoneStaticLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:phoneLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:callStaticLabel];
    [phoneStaticLabel sizeToFit];
    
    [self repositionLabel:phoneLabel forSize:phoneStaticLabel.frame.size anchorLabel:phoneStaticLabel];
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

- (IBAction)performCall:(id)sender {
    if(VALID_NOTEMPTY(phoneLabel.text, NSString)) {
        NSString *text =[phoneLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",text]];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"This device doesn't support phone calls!", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"Ok", @"") otherButtonTitles:nil];
            [alert show];
        }
    }
}
@end
