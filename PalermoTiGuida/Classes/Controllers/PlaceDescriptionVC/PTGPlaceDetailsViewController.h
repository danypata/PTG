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

@interface PTGPlaceDetailsViewController : PTGBaseViewController <PTGDescriptionViewDelegate>{
    
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
