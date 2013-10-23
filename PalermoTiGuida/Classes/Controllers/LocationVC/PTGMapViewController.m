
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
#import "PTGCustomAnnotation.h"

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
        [self addSwitch];
    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedOnMap)];
    [mapView addGestureRecognizer:tapGesture];
}

-(void)tapDetectedOnMap {
    if(VALID(customMapView, PTGCustomMapView)) {
        [customMapView removeFromSuperview];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(leftMenuview) {
        CGRect leftMenuFrame = leftMenuview.frame ;
        leftMenuFrame.origin.y = -self.navigationController.navigationBar.frame.size.height;
        leftMenuFrame.size.height = self.view.frame.size.height + self.navigationController.navigationBar.frame.size.height;
        leftMenuview.frame = leftMenuFrame;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!needUserUpdate) {
        mapView.frame = CGRectMake(0,
                                   0,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height);
    }
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    navBarFrame.origin.x = 0;
    self.navigationController.navigationBar.frame = navBarFrame;
    [leftMenuview shouldShow:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)showSlide {
    if(!leftMenuview.isShown) {
        [UIView animateWithDuration:0.5 animations:^{
            [leftMenuview shouldShow:YES];
            CGRect navBarFrame = self.navigationController.navigationBar.frame;
            navBarFrame.origin.x = navBarFrame.size.width - 63;
            self.navigationController.navigationBar.frame = navBarFrame;
            navBarFrame = topBarContainer.frame;
            navBarFrame.origin.x = navBarFrame.size.width - 63;
            topBarContainer.frame = navBarFrame;
        }];
    }
    else {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect navBarFrame = self.navigationController.navigationBar.frame;
            navBarFrame.origin.x = 0;
            self.navigationController.navigationBar.frame = navBarFrame;
            navBarFrame = topBarContainer.frame;
            navBarFrame.origin.x = 0;
            topBarContainer.frame = navBarFrame;
            [leftMenuview shouldShow:NO];
        }];
    }
    
}
-(void)addAnnotations {
    [mapView removeAnnotations:mapView.annotations];
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
    if([self.places count] == 1 && !needUserUpdate) {
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
        leftMenuview.delegate = self;
        [self.view addSubview:leftMenuview];
        [leftMenuview setupDataSource];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapViewM viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"mapIdentifier";
    PTGCustomAnnotation *annotationView =(PTGCustomAnnotation *)[mapViewM dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!annotationView) {
        annotationView = [[PTGCustomAnnotation alloc] init];
    }
    if([annotation isKindOfClass:[PTGMapAnnotation class]]) {
        annotationView.image = ((PTGMapAnnotation *)annotation).pinImage;
        annotationView.place = ((PTGMapAnnotation *)annotation).place;
    }
    else {
        annotationView.image = [UIImage imageNamed:@"my_location_pin"];
    }

    return annotationView;
    
}
- (void)mapView:(MKMapView *)mMapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views) {
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(mMapView.visibleMapRect, point)) {
            continue;
        }
        CGRect endFrame = aV.frame;
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        [UIView animateWithDuration:0.3 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationCurveLinear animations:^{
            
            aV.frame = endFrame;
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    [UIView animateWithDuration:0.1 animations:^{
                        aV.transform = CGAffineTransformIdentity;
                    }];
                }];
            }
        }];
    }
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if([view isKindOfClass:[PTGCustomAnnotation class]]) {
        if(!customMapView) {
            customMapView = [PTGCustomMapView initializeView];
        }
        [customMapView setupWithPlace:((PTGCustomAnnotation *)view).place];
        if(needUserUpdate) {
            customMapView.frame = CGRectMake(5,
                                             topBarContainer.frame.origin.y
                                             + topBarContainer.frame.size.height + 15,
                                             customMapView.frame.size.width,
                                             customMapView.frame.size.height);
        }
        else {
            customMapView.frame = CGRectMake(5, 15, customMapView.frame.size.width, customMapView.frame.size.height);
        }
        [self.view addSubview:customMapView];
    }
}
-(void)mapView:(MKMapView *)mapViewD didUpdateUserLocation:(MKUserLocation *)userLocation {
    if(needUserUpdate) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500);
        [mapView setRegion:[mapView regionThatFits:region] animated:YES];
    }
}


-(void)loadPlacesForCurrentRegion {
    CLLocationCoordinate2D coord = mapView.region.center;
    double distance = [self getRadius];

    NSString *url = [[PTGURLUtils placesNearMeUrlString] stringByAppendingFormat:@"%f/%f/%f",coord.latitude, coord.longitude, distance];
//        NSString *url = [[PTGURLUtils placesNearMeUrlString] stringByAppendingFormat:@"%f/%f/%f",38.115796, 13.345693, distance];
    [PTGPlace placesNearMeForUrl:url succes:^(NSString *requestUrl, NSArray *products) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeActivityIndicator];
            self.places = [NSArray arrayWithArray:products];
            backupAnnotations = [NSMutableArray arrayWithArray:self.places];
            [self filterResultsUsingCategories:leftMenuview.selectedFilters];
            [self addAnnotations];
        });
    } failure:^(NSString *requestUrl, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self removeActivityIndicator];
            [self showAllertMessageForErro:error];
        });
    }];
    
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [customMapView removeFromSuperview];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    if(needUserUpdate) {
        [self loadPlacesForCurrentRegion];
    }
}

-(double)getRadius {
    CLLocationCoordinate2D centerCoor = mapView.centerCoordinate;
    // init center location from center coordinate
    CLLocation *centerLocation = [[CLLocation alloc] initWithLatitude:centerCoor.latitude longitude:centerCoor.longitude];
    CLLocationCoordinate2D topCenterCoor = [mapView convertPoint:CGPointMake(mapView.frame.size.width / 2.0f, 0) toCoordinateFromView:mapView];
    CLLocation *topCenterLocation = [[CLLocation alloc] initWithLatitude:topCenterCoor.latitude longitude:topCenterCoor.longitude];
    
    CLLocationDistance radius = [centerLocation distanceFromLocation:topCenterLocation];
    ZLog(@"%f",radius);
    return radius;
}

-(void)filterResultsUsingCategories:(NSArray *)categories {
    NSArray *ids = [categories valueForKey:@"categoryId"];
    if(VALID_NOTEMPTY(ids, NSArray)) {
        self.places = [backupAnnotations filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(PTGPlace *evaluatedObject, NSDictionary *bindings) {
            return [ids containsObject:evaluatedObject.category.categoryId];
        }]];
        [self addAnnotations];
        [fadeLabelSwitchLabel setOn:NO];
    }
    else {
        [fadeLabelSwitchLabel setOn:YES];
    }
}



-(void)addSwitch {
    fadeLabelSwitchLabel = [[TTFadeSwitch alloc] initWithFrame:CGRectMake(topBarContainer.frame.size.width - 75,
                                                                          (topBarContainer.frame.size.height - 30) / 2,
                                                                          60.f,
                                                                          30.f)];

    fadeLabelSwitchLabel.thumbImage = [UIImage imageNamed:@"switchToggle"];
    fadeLabelSwitchLabel.trackMaskImage = [UIImage imageNamed:@"switchMask"];
    fadeLabelSwitchLabel.thumbHighlightImage = [UIImage imageNamed:@"switchToggle"];
    fadeLabelSwitchLabel.trackImageOn = [UIImage imageNamed:@"switchGreen"];
    fadeLabelSwitchLabel.trackImageOff = [UIImage imageNamed:@"switchRed"];
    fadeLabelSwitchLabel.onString = @"ON";
    fadeLabelSwitchLabel.offString = @"OFF";
    fadeLabelSwitchLabel.onLabel.font = [UIFont systemFontOfSize:16.f];
    fadeLabelSwitchLabel.offLabel.font = [UIFont systemFontOfSize:16.f];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:fadeLabelSwitchLabel.onLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:fadeLabelSwitchLabel.offLabel];
    fadeLabelSwitchLabel.onLabel.textColor = [UIColor whiteColor];
    fadeLabelSwitchLabel.offLabel.textColor = [UIColor colorWithRed:53.f/255.f green:103.f/255.f blue:132.f/255.f alpha:1];
    fadeLabelSwitchLabel.labelsEdgeInsets = UIEdgeInsetsMake(5.0, 20, 1.0, 20);
    fadeLabelSwitchLabel.thumbInsetX = 0.0;
    fadeLabelSwitchLabel.thumbOffsetY = 1.0;
    [fadeLabelSwitchLabel setOn:YES];
    [topBarContainer addSubview:fadeLabelSwitchLabel];
    __weak PTGMapViewController *weakSelf = self;
    [fadeLabelSwitchLabel setChangeHandler:^(BOOL on) {
        if(on) {
            weakSelf.places = [backupAnnotations copy];
            [weakSelf addAnnotations];
            [leftMenuview setupDataSource];
        }
    }];
}


@end
