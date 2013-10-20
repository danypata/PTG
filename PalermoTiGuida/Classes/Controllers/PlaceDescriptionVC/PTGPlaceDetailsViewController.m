//
//  PTGPlaceDetailsViewController.m
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGPlaceDetailsViewController.h"
#import "PTGDescriptionView.h"
#import "UIImageView+AFNetworking.h"
#import "PTGURLUtils.h"
#import "PTGLocationUtils.h"
#import "PTGMapViewController.h"

@interface PTGPlaceDetailsViewController ()

@end

@implementation PTGPlaceDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addActivityIndicator];
    descriptionView = [PTGDescriptionView setupViews];
    contactView = [PTGDescriptionContactView initializeViews];
    [containerScrollView addSubview:descriptionView];
    [containerScrollView addSubview:contactView];
    containerScrollView.alpha = 0.0;
    if(VALID(self.place, PTGPlace)) {
        [self.place loadDetailsWithSuccess:^(PTGPlace *newPlace) {
            self.place = newPlace;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeActivityIndicator];
                [self arrangeViews];
                [UIView animateWithDuration:0.3 animations:^{
                    containerScrollView.alpha = 1;
                }];

            });
        } failure:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeActivityIndicator];
                [self showAllertMessageForErro:error];
            });
        }];
    }
    else {
        __block CLLocation *oldLocation = nil;
        [[PTGLocationUtils sharedInstance] getLocationWithCompletionBlock:^(CLLocation *location) {
            if(oldLocation != nil && oldLocation.coordinate.longitude == location.coordinate.longitude
               && oldLocation.coordinate.latitude == location.coordinate.latitude) {
                return;
            }
            oldLocation = location;
            CGFloat lat = oldLocation.coordinate.latitude;
            CGFloat longit  = oldLocation.coordinate.longitude;
            __block NSMutableArray *copyProducts = [NSMutableArray new];
            NSString *url = [[PTGURLUtils placeWithDistanceUrl] stringByAppendingFormat:@"%@/4/%f/%f",self.portOrBoardingId,lat,longit];
            [PTGPlace placesForUrl:url succes:^(NSString *requestUrl, NSArray *products) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self removeActivityIndicator];
                    [copyProducts addObjectsFromArray:products];
                    if(VALID_NOTEMPTY(copyProducts, NSArray)) {
                        self.place = [copyProducts objectAtIndex:0];
                        [self arrangeViews];
                        [UIView animateWithDuration:0.3 animations:^{
                            containerScrollView.alpha = 1;
                        }];
                    }
                    else {
                        [self showAllertMessageForErro:[NSError errorWithDomain:@"No place found!" code:123 userInfo:nil]];
                    }
                });
            } failure:^(NSString *requestUrl, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self removeActivityIndicator];
                    [self showAllertMessageForErro:error];
                });
            }];
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self arrangeViews];
}

-(void)arrangeViews {
    titleLabel.text = self.place.name;
    distanceLabel.text = self.place.distance;
    [mainImageView setImageWithURLString:[PTGURLUtils detailImageUrlForId:self.place.mainImage] urlRebuildOptions:kFromOther withSuccess:nil failure:nil];
    [descriptionView setDescriptionForPlace:self.place];
    descriptionView.frame = CGRectMake(mainImageView.frame.origin.x,
                                       blueDividerImageView.frame.origin.y + blueDividerImageView.frame.size.height,
                                       descriptionView.frame.size.width,
                                       descriptionView.frame.size.height);
    
    descriptionView.delegate = self;
    [self setupFonts];
    [contactView setupPlace:self.place];
    contactView.frame = CGRectMake(0,
                                   descriptionView.frame.origin.y + descriptionView.frame.size.height - 10,
                                   contactView.frame.size.width,
                                   contactView.frame.size.height);
    containerScrollView.contentSize = CGSizeMake(containerScrollView.contentSize.width,
                                                 contactView.frame.size.height + contactView.frame.origin.y);
}
-(void)setupFonts {
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:descriptionStaticLabel];
    descriptionStaticLabel.text = NSLocalizedString(descriptionStaticLabel.text, @"");
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:mapStaticLabel];
    mapStaticLabel.text = NSLocalizedString(mapStaticLabel.text, @"");
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceLabel];
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:distanceStaticLabel];
    distanceStaticLabel.text = NSLocalizedString(distanceStaticLabel.text, @"");
    [ICFontUtils applyFont:QLASSIK_BOLD_TB forView:titleLabel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)mapButtonTapped:(id)sender {
    PTGMapViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PTGMapViewController class])];
    controller.places = @[self.place];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark  - description view delegate methods
-(void)shouldResizeScorllView {
    contactView.frame = CGRectMake(0,
                                   descriptionView.frame.origin.y + descriptionView.frame.size.height,
                                   contactView.frame.size.width,
                                   contactView.frame.size.height);
    containerScrollView.contentSize = CGSizeMake(containerScrollView.contentSize.width,
                                                 contactView.frame.size.height + contactView.frame.origin.y);
}

-(void)portoButtonPressed {
    PTGPlaceDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    vc.portOrBoardingId = self.place.placePortId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)imbracaoButtonPressed {
    PTGPlaceDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    vc.portOrBoardingId = self.place.placeBoardId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
@end
