//
//  PTGMapViewController.h
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import <MapKit/MapKit.h>
#import "PTGLeftMenuView.h"
@interface PTGMapViewController : PTGBaseViewController <MKMapViewDelegate> {
    IBOutlet MKMapView *mapView;
    BOOL needUserUpdate;
    PTGLeftMenuView *leftMenuview;
    IBOutlet UILabel *topHeaderLabel;
    IBOutlet UIView *topBarContainer;
}

@property(nonatomic, strong) NSArray *places;
@end
