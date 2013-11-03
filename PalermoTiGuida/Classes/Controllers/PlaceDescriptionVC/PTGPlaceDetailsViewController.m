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
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>

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
    contactView.delegate = self;
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
                        [descriptionView positionViews];
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
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

-(void)arrangeViews {
    titleLabel.text = self.place.name;
    distanceLabel.text = self.place.distance;
    [mainImageView setImageWithURLString:[PTGURLUtils detailImageUrlForId:self.place.mainImage] urlRebuildOptions:kFromOther withSuccess:nil failure:nil];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:self.place.slides];
    NSInteger width = mainImageView.frame.origin.x + mainImageView.frame.size.width;
    for(int i = 1; i< [array count]; i++) {
        NSString *string = [array objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width,
                                                                               mainImageView.frame.origin.y,
                                                                               mainImageView.frame.size.width,
                                                                               mainImageView.frame.size.height)];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        [imageScrolLView addSubview:imageView];
        imageView.backgroundColor = [UIColor redColor];
        [imageView setImageWithURLString:[PTGURLUtils detailImageUrlForId:string] urlRebuildOptions:kFromOther withSuccess:nil failure:nil];
    }
    imageScrolLView.contentSize = CGSizeMake([array count] * width, imageScrolLView.contentSize.height );
    [descriptionView setDescriptionForPlace:self.place];
    descriptionView.frame = CGRectMake(0,
                                       blueDividerImageView.frame.origin.y + blueDividerImageView.frame.size.height,
                                       descriptionView.frame.size.width,
                                       descriptionView.frame.size.height);
    
    descriptionView.delegate = self;
    [self setupFonts];
    [contactView setupPlace:self.place];
    contactView.frame = CGRectMake(0,
                                   descriptionView.frame.origin.y + descriptionView.frame.size.height - 2,
                                   contactView.frame.size.width,
                                   contactView.frame.size.height);
    containerScrollView.contentSize = CGSizeMake(containerScrollView.contentSize.width,
                                                 contactView.frame.size.height + contactView.frame.origin.y + SPACING_TOP);
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

#pragma mark - PTGDescriptionContactViewDelegate methods 

-(void)shouldShareOnTwitter {
    if([TWTweetComposeViewController canSendTweet]) {
        
        TWTweetComposeViewController *twt = [[TWTweetComposeViewController alloc] init];
        NSString *initialText = [NSString stringWithFormat:MESSAGE_I_LIKE_IT,self.place.name];
        [twt setInitialText:initialText];
        [twt addImage:mainImageView.image];
        [twt addURL:[NSURL URLWithString:SHARE_URL]];
        
        twt.completionHandler = ^(TWTweetComposeViewControllerResult result) {
            switch (result) {
                case TWTweetComposeViewControllerResultCancelled: {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MESSAGE_SHARE_STATUS_CANCELED delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertView show];
                }
                break;
                case TWTweetComposeViewControllerResultDone: {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MESSAGE_SHARE_STATUS_SUCCESS delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertView show];
                }
                    break;
                default:
                    break;
            }
            [self dismissModalViewControllerAnimated:YES];
        };
        [self presentModalViewController:twt animated:YES];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MESSAGE_SHARE_STATUS_NO_ACCOUNT_CONFIG delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
    }
}

-(void)shouldShareOnFacebook {
    [FBSession openActiveSessionWithPublishPermissions:@[@"publish_actions"] defaultAudience:FBSessionDefaultAudienceEveryone
                                          allowLoginUI:YES
                                     completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                         [self sessionStateChanged:session product:self.place state:session.state error:error];
                                     }];
}

- (void)sessionStateChanged:(FBSession *)session
                    product:(PTGPlace *)place
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen: {
            NSMutableDictionary *params =
            [NSMutableDictionary dictionaryWithObjectsAndKeys:
             place.name, @"name",
             MESSAGE_I_LIKE_IT, @"caption",
             SHARE_URL, @"link",
             [PTGURLUtils detailImageUrlForId:self.place.mainImage], @"picture",
             nil];
            [FBWebDialogs presentFeedDialogModallyWithSession:session parameters:params handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                if (error == nil && VALID_NOTEMPTY(resultURL, NSURL) && [[resultURL absoluteString] rangeOfString:@"post_id"].location != NSNotFound) {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MESSAGE_SHARE_STATUS_SUCCESS delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alertView show];
                }
            }];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed: {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MESSAGE_SHARE_STATUS_FAILED_UNKNONW delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertView show];
        }
            break;
        default:
            break;
    }
}

@end
