//
//  PTExtraCellType8GCell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 12/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"

@interface PTExtraCellType8GCell : UITableViewCell {
    
    IBOutlet UIImageView *bgImage;
    IBOutlet UILabel *phoneLabel;
    IBOutlet UILabel *phoneStaticLabel;
    IBOutlet UILabel *placeName;
    IBOutlet UILabel *callStaticLabel;
}
- (IBAction)performCall:(id)sender;
+(PTExtraCellType8GCell *)initializeViews;
-(void)setupWithPlace:(PTGPlace *)place;
-(void)setBackgroundImageForIndex:(NSInteger)index;
@end
