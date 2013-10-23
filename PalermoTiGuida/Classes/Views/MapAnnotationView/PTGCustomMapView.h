//
//  PTGCustomMapView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/23/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"
#import "PTGCategory.h"

@interface PTGCustomMapView : UIView {
    __weak IBOutlet UIImageView *placeImageView;
    __weak IBOutlet UILabel *placeNameLabel;
    __weak IBOutlet UILabel *streetStaticLabel;
    __weak IBOutlet UILabel *streetLabel;
    __weak IBOutlet UILabel *distanceStaticLabel;
    __weak IBOutlet UILabel *distanceLabel;
    
    IBOutlet UILabel *placeTypeStaticLabel;
    
    IBOutlet UILabel *placeTypeLabel;
    PTGPlace *currentPlace;
    void(^tapHandler)(PTGPlace *place);
}

+(PTGCustomMapView *)initializeView;
-(void)setupWithPlace:(PTGPlace*)place distanceFromUser:(double)distance;
-(void)setTapHandler:(void(^)(PTGPlace * place))handler;


@end
