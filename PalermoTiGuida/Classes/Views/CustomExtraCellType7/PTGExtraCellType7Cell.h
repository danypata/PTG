//
//  PTGExtraCellType7Cell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 12/11/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGPlace.h"

@interface PTGExtraCellType7Cell : UITableViewCell {
    
    
    IBOutlet UILabel *placeName;
    
    IBOutlet UILabel *stationNumberStaticLabel;
    
    IBOutlet UILabel *stationNumberLabel;
    
    IBOutlet UILabel *closingStaticLabel;
    
    IBOutlet UILabel *closingLabel;
    
    IBOutlet UILabel *urbanCostStaticLabel;
    
    IBOutlet UILabel *urbanCostLabel;
    
    IBOutlet UILabel *aeroportStaticLabel;
    
    IBOutlet UILabel *aeroportLabel;
}

+(PTGExtraCellType7Cell *)initializeViews;
-(void)setupLabels;
-(void)setupWithPlace:(PTGPlace *)place;

@end
