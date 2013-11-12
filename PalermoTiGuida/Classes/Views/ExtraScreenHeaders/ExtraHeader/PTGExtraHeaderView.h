//
//  PTGExtraHeaderView.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 09/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"

@interface PTGExtraHeaderView : UIView {
    
    IBOutlet UILabel *moreInfoLabel;
    IBOutlet UIImageView *plusImageView;
    IBOutlet UILabel *distanceLabel;
    IBOutlet UILabel *distanceStaticLabel;
    IBOutlet UILabel *addressLabel;
    IBOutlet UILabel *addressStaticLabel;
    IBOutlet UILabel *localizeLabel;
    IBOutlet UIImageView *bgImage;
    IBOutlet UILabel *placeName;
    
    void(^tapHandlerBlock)(BOOL isOpen);
}
@property(nonatomic)    BOOL isOpen;

- (IBAction)localizeButtonTapped:(id)sender;
+(PTGExtraHeaderView *)initializeViews;
-(void)setupWithPlace:(PTGPlace *)place;
-(void)setTapBlock:(void(^)(BOOL isOpen))block;
-(void)setBackgroundImageForIndex:(NSInteger)index;

@end
