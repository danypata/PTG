//
//  PTGMapAnnotation.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/17/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGMapAnnotation.h"

@implementation PTGMapAnnotation
@synthesize pinImage;
@synthesize title;
@synthesize subtitle;
@synthesize coordinate = _coordinate;
@synthesize place;


-(id)init {
    self = [super init];
    if(self) {

    }
    return self;
}

-(void)setupViews {
    double lat = [self.place.lat doubleValue];
    double longit =[self.place.longit doubleValue];
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = lat;
    annotationCoord.longitude = longit;
    _coordinate = annotationCoord;
}
@end
