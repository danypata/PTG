//
//  PTGMapAnnotation.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/17/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "PTGPlace.h"

@interface PTGMapAnnotation : NSObject <MKAnnotation>{
    
}
@property (nonatomic, strong) UIImage *pinImage;
@property (nonatomic, strong) PTGPlace *place;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

-(void)setupViews;


@end
