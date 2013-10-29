//
//  PTGLocationUtils.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGLocationUtils.h"

@implementation PTGLocationUtils

-(id)init {
    self = [super init];
    if(self) {
        manager = [[CLLocationManager alloc] init];
        manager.delegate = self;
        manager.distanceFilter = kCLDistanceFilterNone;
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;

    }
    return self;
}

+(PTGLocationUtils *)sharedInstance {
    static PTGLocationUtils *instance = nil;
    if(!instance) {
        instance = [[PTGLocationUtils alloc] init];
    
    }
    return instance;
}

-(void)startUpdating {
    [manager startMonitoringSignificantLocationChanges];
}

-(void)getLocationWithCompletionBlock:(void(^)(CLLocation *location))block {
    block(location);

}

-(void)locationManager:(CLLocationManager *)mManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    location = newLocation;
}

-(void)locationManager:(CLLocationManager *)mManager didUpdateLocations:(NSArray *)locations {
       location = [locations lastObject];
}

+(NSString *)distanceStringFromString:(NSString *)string {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:string];
    CGFloat distance = [number floatValue];
    return [NSString stringWithFormat:@"%.2fKm",distance];
}


@end
