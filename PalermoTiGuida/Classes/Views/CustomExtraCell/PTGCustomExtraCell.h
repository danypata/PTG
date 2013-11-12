//
//  PTGCustomExtraCell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 09/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"
#import "PTGIconLabelView.h"
#import "PTGCoreTextView.h"

@interface PTGCustomExtraCell : UITableViewCell {
    
    IBOutlet UIView *containerView;
    CGFloat yOffset;
    PTGPlace *currentPlace;
    IBOutlet UIImageView *imageBg;
}

+(PTGCustomExtraCell *)initializeViews;
-(void)setupWithPlace:(PTGPlace *)place isLastSection:(BOOL)isLastSection;
@end
