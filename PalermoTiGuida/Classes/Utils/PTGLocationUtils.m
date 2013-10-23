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


-(void)getLocationWithCompletionBlock:(void(^)(CLLocation *location))block {
    oldCoordinates.longitude =0;
    oldCoordinates.latitude = 0;
    completionBlock = block;
    [manager startUpdatingLocation];


}

-(void)locationManager:(CLLocationManager *)mManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    CLLocationCoordinate2D coord = newLocation.coordinate;
    if(coord.latitude != oldCoordinates.latitude && coord.longitude != oldCoordinates.longitude) {
        oldCoordinates = coord;
        completionBlock(newLocation);
    }
}

-(void)locationManager:(CLLocationManager *)mManager didUpdateLocations:(NSArray *)locations {
    CLLocationCoordinate2D coord = ((CLLocation *)[locations objectAtIndex:0]).coordinate;
    if(coord.latitude != oldCoordinates.latitude && coord.longitude != oldCoordinates.longitude) {
        oldCoordinates = coord;
        completionBlock([locations lastObject]);
    }
    [manager stopUpdatingLocation];
}

+(NSString *)distanceStringFromString:(NSString *)string {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number =[formatter numberFromString:string];
    CGFloat distance = [number floatValue];
    return [NSString stringWithFormat:@"%.2fKm",distance];
}


@end
