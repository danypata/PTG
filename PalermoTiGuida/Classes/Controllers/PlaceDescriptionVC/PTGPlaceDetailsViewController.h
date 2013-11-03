//
//  PTGPlaceDetailsViewController.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import "PTGBaseViewController.h"
#import "PTGDescriptionView.h"
#import "PTGPlace.h"
#import "PTGDescriptionContactView.h"

#define MESSAGE_SHARE_STATUS_SUCCESS            NSLocalizedString(@"Your post has been sent with success", @"")
#define MESSAGE_SHARE_STATUS_FAILED_UNKNONW     NSLocalizedString(@"Oops! Something went wrong when we try to send your post, please try\
again!", @"")
#define MESSAGE_SHARE_STATUS_CANCELED           NSLocalizedString(@"Sharing was canceled",@"")

#define MESSAGE_SHARE_STATUS_NO_ACCOUNT_CONFIG  NSLocalizedString(@"You don't have any twitter account configured. Please setup a twitter account on your device\
and try again!", @"")

#define MESSAGE_I_LIKE_IT                       NSLocalizedString(@"ha visitato %@ tramite l'applicazione PALERMOtiGUIDA.",@"")
#define SHARE_URL                               NSLocalizedString(@"http://www.palermotiguida.it",@"")

@interface PTGPlaceDetailsViewController : PTGBaseViewController <PTGDescriptionViewDelegate, PTGDescriptionContactViewDelegate>{
    
    IBOutlet UIScrollView *imageScrolLView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *descriptionStaticLabel;
    IBOutlet UIImageView *blueDividerImageView;
    IBOutlet UILabel *mapStaticLabel;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *distanceStaticLabel;
    IBOutlet UIImageView *mainImageView;
    IBOutlet UIScrollView *containerScrollView;
    PTGDescriptionView *descriptionView;
    PTGDescriptionContactView *contactView;
}
@property(nonatomic, strong) PTGPlace *place;
@property(nonatomic, strong) NSString *portOrBoardingId;
- (IBAction)mapButtonTapped:(id)sender;

@end
