//
//  PTGDescriptionContactView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/16/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"

#define DEFAULT_MARGIN 10
@interface PTGDescriptionContactView : UIView {
    IBOutlet UILabel *headerTitleLabel;
    IBOutlet UILabel *switchLabel;
    IBOutlet UIButton *twitterButton;
    IBOutlet UIButton *facebookButton;
    CGFloat yOffset;
    IBOutlet UIImageView *bgImage;
    IBOutlet UIView *buttonsView;
}
- (IBAction)facebookButtonTapped:(id)sender;
- (IBAction)twitterButtonTapped:(id)sender;

+(PTGDescriptionContactView *)initializeViews;
-(void)setupPlace:(PTGPlace *)place;

@end
