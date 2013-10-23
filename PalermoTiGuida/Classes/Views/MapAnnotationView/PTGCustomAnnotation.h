//
//  PTGCustomAnnotation.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/23/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "PTGPlace.h"

@interface PTGCustomAnnotation : MKAnnotationView {
    
}

@property(nonatomic, strong) PTGPlace *place;

@end
