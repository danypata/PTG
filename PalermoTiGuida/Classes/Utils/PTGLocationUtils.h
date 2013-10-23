//
//  PTGLocationUtils.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define KM 1000
@interface PTGLocationUtils : NSObject<CLLocationManagerDelegate> {
    CLLocationManager *manager;
    CLLocationCoordinate2D oldCoordinates;
    void (^completionBlock)(CLLocation *location);
}


+(PTGLocationUtils *)sharedInstance;
-(void)getLocationWithCompletionBlock:(void(^)(CLLocation *location))block;
+(NSString *)distanceStringFromString:(NSString *)string;
@end
