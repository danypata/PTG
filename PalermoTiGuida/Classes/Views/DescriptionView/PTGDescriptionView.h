//
//  PTGDescriptionView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/15/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"

#define SPACING_TOP 10

@protocol PTGDescriptionViewDelegate <NSObject>

-(void)shouldResizeScorllView;
-(void)portoButtonPressed;
-(void)imbracaoButtonPressed;

@end

@interface PTGDescriptionView : UIView {
    CGFloat initialHeight;
    IBOutlet UIImageView *bgImage;
    IBOutlet UIView *buttonContainer;
    IBOutlet UIButton *imbarcaoButton;
    IBOutlet UIButton *portoButton;
    IBOutlet UIImageView *mainImageView;
    IBOutlet UITextView *descriptionTextField;
    IBOutlet UIButton *moreButton;
}
@property(nonatomic, strong) id<PTGDescriptionViewDelegate>delegate;

- (IBAction)moreButtonPressed:(id)sender;
- (IBAction)portoButtonPressed:(id)sender;
- (IBAction)imbracaoButtonPressed:(id)sender;

+(PTGDescriptionView *)setupViews;
-(void)positionViews;
-(void)setDescriptionForPlace:(PTGPlace *)place;


@end
