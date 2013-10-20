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
        [self addLeftMenu];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0,44 , 44);
        [button setImage:[UIImage imageNamed:@"menu_button"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showSlide) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    mapView.delegate = self;
    if(VALID_NOTEMPTY(self.places, NSArray)) {
        needUserUpdate = NO;
        topBarContainer.hidden = YES;
        [self addAnnotations];
    }
    else {
        needUserUpdate = YES;
        topBarContainer.hidden = NO;
        topHeaderLabel.text = NSLocalizedString(topHeaderLabel.text, @"");
        [ICFontUtils applyFont:QLASSIK_TB forView:topHeaderLabel];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(leftMenuview) {
        CGRect leftMenuFrame = leftMenuview.frame ;
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            leftMenuFrame.size.height = self.view.frame.size.height;
        } else {
            leftMenuFrame.origin.y = -44;
            leftMenuFrame.size.height = self.view.frame.size.height + 44;
        }

        leftMenuview.frame = leftMenuFrame;
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    navBarFrame.origin.x = 0;
    self.navigationController.navigationBar.frame = navBarFrame;
    self.navigationController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [leftMenuview shouldShow:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)showSlide {
    if(!leftMenuview.isShown) {
        [leftMenuview setupDataSource];
        [UIView animateWithDuration:0.5 animations:^{
            [leftMenuview shouldShow:YES];
            CGRect navBarFrame = self.navigationController.navigationBar.frame;
            navBarFrame.origin.x = navBarFrame.size.width - 63;
            self.navigationController.navigationBar.frame = navBarFrame;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect navBarFrame = self.navigationController.navigationBar.frame;
            navBarFrame.origin.x = 0;
            self.navigationController.navigationBar.frame = navBarFrame;
            [leftMenuview shouldShow:NO];
        }];
    }
    
}
-(void)addAnnotations {
    for(PTGPlace *place in self.places) {
        [UIImageView downloadImageWithURLString:[[PTGURLUtils pinImageUrlString] stringByAppendingFormat:@"%@.png",place.category.categoryId]  successBlock:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                PTGMapAnnotation *annotation = [[PTGMapAnnotation alloc] init];
                annotation.pinImage = image;
                annotation.place = place;
                [annotation setupViews];
                [mapView addAnnotation:annotation];
                
            });
        } failureBloc:^(NSError *error) {
        }];
    }
    if([self.places count] == 1) {
        PTGPlace *place = [self.places objectAtIndex:0];
        CLLocationCoordinate2D pinLocation;
        pinLocation.latitude = [place.lat doubleValue];
        pinLocation.longitude = [place.longit doubleValue];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(pinLocation, 800, 800);
        [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    }
}


-(void)addLeftMenu {
    if(!leftMenuview) {
        leftMenuview = [PTGLeftMenuView initializeViews];
        leftMenuview.isShown = NO;
        leftMenuview.frame = CGRectMake(-leftMenuview.frame.size.width,
                                        0,
                                        leftMenuview.frame.size.width,
                                        self.view.frame.size.height);
        [self.view addSubview:leftMenuview];
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
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
        [mapView setRegion:[mapView regionThatFits:region] animated:YES];
        double distance = [self getDistance];
        CLLocationCoordinate2D coord = mapView.userLocation.coordinate;
        
        NSString *url = [[PTGURLUtils placesNearMeUrlString] stringByAppendingFormat:@"%f/%f/%f",coord.latitude, coord.longitude, distance];
        [PTGPlace placesForUrl:url succes:^(NSString *requestUrl, NSArray *products) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeActivityIndicator];
                self.places = [NSArray arrayWithArray:products];
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
