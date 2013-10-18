//
//  PTGMapViewController.m
//  PalermoTiGuida
//
//  Created by Dan on 10/12/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGMapViewController.h"
#import "PTGMapAnnotation.h"
#import "UIImageView+AFNetworking.h"
#import "PTGURLUtils.h"
#import "PTGCategory.h"
#import "PTGLocationUtils.h"

@interface PTGMapViewController ()

@end

@implementation PTGMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([self.navigationController.viewControllers count] == 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 40, 40);
        [button setImage:[UIImage imageNamed:@"menu_button"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showSlide) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self addLeftMenu];
    }
    if(VALID_NOTEMPTY(self.places, NSArray)) {
        [self addAnnotations];
        needUserUpdate = NO;
    }
    else {
        needUserUpdate = YES;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(mapView.userLocation.location.coordinate, 500, 500);
    [mapView setRegion:viewRegion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
-(void)showSlide {
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = CGRectMake(self.view.frame.size.width - 20, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
        [leftMenuview shouldShow:YES];
    }];
}
-(void)addAnnotations {
    for(PTGPlace *place in self.places) {
        [UIImageView downloadImageWithURLString:[[PTGURLUtils pinImageUrlString] stringByAppendingFormat:@"%@.png",place.category.categoryId]  successBlock:^(UIImage *image) {
            PTGMapAnnotation *annotation = [[PTGMapAnnotation alloc] init];
            annotation.pinImage = image;
            annotation.place = place;
            [annotation setupViews];
            [mapView addAnnotation:annotation];
        } failureBloc:^(NSError *error) {
        }];
    }
}


-(void)addLeftMenu {
    if(!leftMenuview) {
        leftMenuview = [PTGLeftMenuView initializeViews];
        leftMenuview.frame = CGRectMake(-leftMenuview.frame.size.width,
                                        0,
                                        leftMenuview.frame.size.width,
                                        self.tabBarController.view.frame.size.height
                                        -self.tabBarController.tabBar.frame.size.height);
        [self.tabBarController.view addSubview:leftMenuview];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *view = [[MKAnnotationView alloc] init];
    if([annotation isKindOfClass:[PTGMapAnnotation class]]) {
        view.image = ((PTGMapAnnotation *)annotation).pinImage;
    }
    else {
        view.image = [UIImage imageNamed:@"my_location_pin"];
    }
    return view;
    
}

-(void)mapView:(MKMapView *)mapViewD didUpdateUserLocation:(MKUserLocation *)userLocation {
    if(needUserUpdate) {
        double distance = [self getDistance];
        CLLocationCoordinate2D coord = mapView.userLocation.coordinate;
        
            NSString *url = [[PTGURLUtils placesNearMeUrlString] stringByAppendingFormat:@"%f/%f/%f",coord.latitude, coord.longitude, distance];
            [PTGPlace placesForUrl:url succes:^(NSString *requestUrl, NSArray *products) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self removeActivityIndicator];
                    self.places = [NSArray arrayWithArray:products];
                    [self addAnnotations];
                });
            } failure:^(NSString *requestUrl, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self removeActivityIndicator];
                    [self showAllertMessageForErro:error];
                });
            }];

    }
}

-(double)getDistance {
    double midY = MKMapRectGetMidY(mapView.visibleMapRect);
    double minX = MKMapRectGetMinY(mapView.visibleMapRect);
    
    MKMapPoint midleLeft = MKMapPointMake(minX, midY);
    CLLocationCoordinate2D coord = MKCoordinateForMapPoint(midleLeft);
    CLLocation *leftLocation = [[CLLocation alloc] initWithCoordinate:coord altitude:1 horizontalAccuracy:1 verticalAccuracy:-1 timestamp:nil];
    CLLocationDistance distance = [mapView.userLocation.location distanceFromLocation:leftLocation];
    return distance / 1000;
    
    
    
    
}

@end
