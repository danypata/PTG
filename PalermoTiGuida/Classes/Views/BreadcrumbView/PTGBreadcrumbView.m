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
}
+(PTGBreadcrumbView *)setupViews {
    NSArray *views =[[NSBundle mainBundle] loadNibNamed:@"PTGBreadcrumbView" owner:nil options:nil];
    return [views objectAtIndex:0];
}

-(void)setItems:(NSArray *)items {
    NSInteger index = 0;
    if([items count] == 1) {
      [self createLabelForCurrentString:[items objectAtIndex:0] isLastItem:NO];
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
    }
    else {
        label.textColor = [UIColor whiteColor];
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
