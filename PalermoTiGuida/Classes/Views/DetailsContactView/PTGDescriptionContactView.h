//
//  PTGDescriptionContactView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/16/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"
#import "TTFadeSwitch.h"

@protocol PTGDescriptionContactViewDelegate <NSObject>

-(void)shouldShareOnTwitter;
-(void)shouldShareOnFacebook;

@end

#define DEFAULT_MARGIN 10
#define DAYS_ARRAY @[NSLocalizedString(@"Monday",@""),\
                     NSLocalizedString(@"Tuesday",@""),\
                     NSLocalizedString(@"Wednesday",@""),\
                     NSLocalizedString(@"Thursday",@""),\
                     NSLocalizedString(@"Friday",@""),\
                     NSLocalizedString(@"Saturday",@""),\
                     NSLocalizedString(@"Sunday",@"")]

@interface PTGDescriptionContactView : UIView<UIAlertViewDelegate> {
    IBOutlet UILabel *headerTitleLabel;
    IBOutlet UILabel *switchLabel;
    IBOutlet UIButton *twitterButton;
    IBOutlet UIButton *facebookButton;
    CGFloat yOffset;
    IBOutlet UIImageView *bgImage;
    IBOutlet UIView *buttonsView;
    PTGPlace *currentPlace;
    IBOutlet UIImageView *switchImageView;
    TTFadeSwitch *fadeLabelSwitchLabel;
}
@property(nonatomic, assign) id<PTGDescriptionContactViewDelegate>delegate;
- (IBAction)facebookButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;

+(PTGDescriptionContactView *)initializeViews;
-(void)setupPlace:(PTGPlace *)place;

@end
