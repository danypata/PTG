//
//  PTGBreadcrumbView.m
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBreadcrumbView.h"

@implementation PTGBreadcrumbView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
-(void)setFontSize:(BreadcrumbFontSize)size {
    fontSize = size;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if(fontSize == kFontSizeLarge) {
            fontSize = 42.f;
        }
        else {
            fontSize = 28.f;
        }
    }
}
+(PTGBreadcrumbView *)setupViews {
    NSArray *views =[[NSBundle mainBundle] loadNibNamed:@"PTGBreadcrumbView" owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)setItems:(NSArray *)items {
    NSInteger index = 0;
    if([items count] == 1) {
        [self createLabelForCurrentString:[items objectAtIndex:0] isLastItem:YES];
    }
    else {
        for(NSString *string in items) {
            if(index == [items count] -1) {
                [self createLabelForCurrentString:string isLastItem:YES];
            }
            else {
                [self createLabelForCurrentString:string isLastItem:NO];
                [self addArrow];
            }
            ++index;
        }
    }
}

-(void)createLabelForCurrentString:(NSString *)string isLastItem:(BOOL)lastItem{
    UIFont *font = [UIFont fontWithName:QLASSIK_TB size:fontSize];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(currentOffset,
                                                               0,
                                                               self.frame.size.width,
                                                               self.frame.size.height)];
    label.text = string;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    [label sizeToFit];
    label.frame = CGRectMake(label.frame.origin.x,
                             (self.frame.size.height - label.frame.size.height) / 2,
                             label.frame.size.width,
                             label.frame.size.height);
    currentOffset +=label.frame.size.width;
    [self addSubview:label];
    if(!lastItem) {
        label.textColor = DEFAULT_COLOUR;
        label.shadowColor = [UIColor colorWithRed:210.f/255.f green:244.f/255.f blue:255.f/255.f alpha:0.75];
    }
    else {
        label.textColor = [UIColor whiteColor];
        label.shadowColor = [UIColor colorWithRed:2.f/255.f green:45.f/255.f blue:67.f/255.f alpha:0.75];
        label.shadowOffset = CGSizeMake(0, 1);
        
    }
}

-(void)addArrow {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"small_arrow"]];
    imageView.frame = CGRectMake(currentOffset +ARROW_MARGINS,
                                 (self.frame.size.height - imageView.frame.size.height)/2,
                                 imageView.frame.size.width,
                                 imageView.frame.size.height);
    [self addSubview:imageView];
    currentOffset =imageView.frame.origin.x + imageView.frame.size.width + ARROW_MARGINS;
}

-(void)setXOffset:(CGFloat)xOffset {
    currentOffset = xOffset;
}



@end
