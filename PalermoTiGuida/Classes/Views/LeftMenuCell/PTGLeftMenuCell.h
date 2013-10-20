//
//  PTGLeftMenuCell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGLeftMenuCell : UITableViewCell {

    IBOutlet UIImageView *checkmark;
    IBOutlet UILabel *cellTitle;
}

+(PTGLeftMenuCell *)initializeViews;
-(void)setTitle:(NSString *)title;

@end
