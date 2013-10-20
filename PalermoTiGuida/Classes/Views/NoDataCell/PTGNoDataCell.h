//
//  PTGNoDataCell.h
//  PalermoTiGuida
//
//  Created by dan.patacean on 10/19/13.
//  Copyright (c) 2013 Dan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTGNoDataCell : UITableViewCell {
    IBOutlet UIImageView *bgImage;
    
}
@property(nonatomic, strong) IBOutlet UITextView *textView;

+(PTGNoDataCell *)initializeVies;
-(void)setupFonts;
@end
