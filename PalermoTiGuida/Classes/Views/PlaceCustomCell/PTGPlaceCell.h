//
//  PTGPlaceCell.h
//  PalermoTiGuida
//
//  Created by Dan on 10/13/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGCategoryCell.h"
#import "PTGPlace.h"
#import "UIImageView+AFNetworking.h"

@interface PTGPlaceCell : PTGCategoryCell {
    
    __weak IBOutlet UIImageView *placeImageView;
    __weak IBOutlet UILabel *placeNameLabel;
    __weak IBOutlet UILabel *streetStaticLabel;
    __weak IBOutlet UILabel *streetLabel;
    __weak IBOutlet UILabel *distanceStaticLabel;
    __weak IBOutlet UILabel *distanceLabel;
}

+(PTGPlaceCell *)setupViews;
-(void)setupWithPlace:(PTGPlace*)place;
-(void)applyFonts;

@end
