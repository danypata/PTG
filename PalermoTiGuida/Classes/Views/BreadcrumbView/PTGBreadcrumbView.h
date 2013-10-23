//
//  PTGBreadcrumbView.h
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    kFontSizeLarge = 27,
    kFontSizeSmall = 14
    
}BreadcrumbFontSize;

#define DEFAULT_COLOUR      [UIColor colorWithRed:33.f/255.f green:82.f/255.f blue:132.f/255.f alpha:1];

#define ARROW_MARGINS 5

@interface PTGBreadcrumbView : UIView {
    
    __weak IBOutlet UIImageView *backgroundImageVie;
    CGFloat currentOffset;
    BreadcrumbFontSize fontSize;
}

+(PTGBreadcrumbView *)setupViews;
-(void)setItems:(NSArray *)items;
-(void)setFontSize:(BreadcrumbFontSize)size;
-(void)setXOffset:(CGFloat )xOffset;
@end
