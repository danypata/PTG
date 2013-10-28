//
//  PTGNewsListCell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 27/10/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTGNews.h"

@interface PTGNewsListCell : UITableViewCell {
    
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *dayLabel;
    
    IBOutlet UILabel *titleLabel;
    
    IBOutlet UILabel *streetStaticLabel;
    
    IBOutlet UILabel *streetLabel;
    
    IBOutlet UILabel *distanceStaticLabel;
    
    IBOutlet UILabel *distanceLabel;
    
    IBOutlet UIImageView *cellBgImage;
}

+(PTGNewsListCell *)setupViews;
-(void)setupFonts;
-(void)setupWithNews:(PTGNews *)news;
-(void)isFirstCell;
-(void)isMiddleCell;
-(void)isLastCell;

@end
