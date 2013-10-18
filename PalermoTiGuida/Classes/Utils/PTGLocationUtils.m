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
        didSendUpdate = NO;

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
    completionBlock = block;
    [manager startUpdatingLocation];


}

-(void)locationManager:(CLLocationManager *)mManager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    if(!didSendUpdate) {
        didSendUpdate = YES;
        completionBlock(newLocation);
        manager.delegate = self;
        didSendUpdate = NO;
    }
}

-(void)locationManager:(CLLocationManager *)mManager didUpdateLocations:(NSArray *)locations {
    completionBlock([locations lastObject]);
    [manager stopUpdatingLocation];
}

+(NSString *)distanceStringFromString:(NSString *)string {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *number =[formatter numberFromString:string];
    CGFloat distance = [number floatValue];
    if(distance * KM >= KM) {
        return [NSString stringWithFormat:@"%.2fKm",distance*KM];
    }
    else {
        return [NSString stringWithFormat:@"%.2fm",distance*KM];
    }
}


@end
