//
//  PTGExtraCell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlaceCell.h"

@protocol PTGExtraCellDelegate <NSObject>

-(void)shouldShowOnMapPlaceAtIndex:(NSInteger )index;

@end

@interface PTGExtraCell : PTGPlaceCell {
    IBOutlet UILabel *localizeLabel;
}

@property(nonatomic) NSInteger index;
@property(nonatomic, assign) id<PTGExtraCellDelegate>delegate;

- (IBAction)localizeButtonTapped:(id)sender;
+(PTGExtraCell *)setupViews;
@end
