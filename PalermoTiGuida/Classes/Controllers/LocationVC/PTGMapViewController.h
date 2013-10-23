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
#import "PTGCustomMapView.h"
#import "TTFadeSwitch.h"
@interface PTGMapViewController : PTGBaseViewController <MKMapViewDelegate, PTGLeftMenuViewDelegate> {
    IBOutlet MKMapView *mapView;
    BOOL needUserUpdate;
    PTGLeftMenuView *leftMenuview;
    IBOutlet UILabel *topHeaderLabel;
    IBOutlet UIView *topBarContainer;
    PTGCustomMapView *customMapView;
    NSMutableArray *backupAnnotations;
    TTFadeSwitch *fadeLabelSwitchLabel;
}

@property(nonatomic, strong) NSArray *places;



@end
